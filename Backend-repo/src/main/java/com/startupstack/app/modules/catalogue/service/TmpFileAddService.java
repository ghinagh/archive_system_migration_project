package com.startupstack.app.modules.catalogue.service;

import com.startupstack.app.modules.catalogue.dto.TmpFileAddRequest;
import com.startupstack.app.modules.catalogue.dto.TmpFileAddResponse;
import com.startupstack.app.modules.catalogue.entity.TmpFileAddEntity;
import com.startupstack.app.modules.catalogue.entity.TmpFileAddId;
import com.startupstack.app.modules.catalogue.repository.TmpFileAddRepository;
import com.startupstack.app.modules.users.entity.UserEntity;
import com.startupstack.app.modules.users.repository.UserRepository;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import jakarta.persistence.EntityNotFoundException;
import org.hibernate.ObjectNotFoundException;
import com.startupstack.app.shared.util.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Clock;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class TmpFileAddService {

    private final TmpFileAddRepository tmpFileAddRepository;
    private final UserRepository userRepository;
    private final Clock clock;

    @Autowired
    public TmpFileAddService(TmpFileAddRepository tmpFileAddRepository, UserRepository userRepository) {
        this(tmpFileAddRepository, userRepository, Clock.systemDefaultZone());
    }

    TmpFileAddService(TmpFileAddRepository tmpFileAddRepository, UserRepository userRepository, Clock clock) {
        this.tmpFileAddRepository = tmpFileAddRepository;
        this.userRepository = userRepository;
        this.clock = clock;
    }

    /**
     * Read through a projection rather than the (tmp_fad_no, tmp_ser) entity: legacy tmp_fileadd rows
     * may have a NULL tmp_ser (tmp_file.frm lists them too), which the entity identity cannot load.
     */
    @Transactional(readOnly = true)
    public List<TmpFileAddResponse> findAll(String fadNo, String userNo, Integer finalStatus) {
        return tmpFileAddRepository.findListRows(fadNo, userNo, finalStatus).stream()
                .map(r -> new TmpFileAddResponse(r.getTmpFadNo(), r.getTmpSer(), r.getTmpFileName(), r.getTmpRmrk(),
                        r.getTmpMk(), r.getTmpDate(), r.getTmpUserNo(), r.getUserName(), r.getTmpFinal()))
                .toList();
    }

    /**
     * tmp_file.frm DataGrid1 KeyUp Insert → execute op_tmp Form2.Text1, box_user_no, today:
     * tmp_user_no = the login's config.user_no (char(3)), tmp_ser = max(tmp_ser) of that USER + 1
     * (declare @max1 int truncates; none → 1), tmp_fad_no = @m_code char(7), tmp_date = today,
     * tmp_final = 0; name, remark and place stay NULL.
     */
    @Transactional
    public TmpFileAddResponse create(TmpFileAddRequest request) {
        String username = SecurityUtils.getCurrentUsername();
        UserEntity user = username == null ? null : userRepository.findByUserName(username).orElse(null);
        String userNo = user == null || user.getUserNo() == null ? null : pad(user.getUserNo(), 3);
        String fadNo = pad(request.tmpFadNo(), 7);
        Double max = tmpFileAddRepository.findMaxSerialOfUser(userNo);
        double ser = max == null ? 1 : (int) max.doubleValue() + 1;
        LocalDateTime today = LocalDate.now(clock).atStartOfDay();
        tmpFileAddRepository.insertOp(ser, userNo, fadNo, today);
        return new TmpFileAddResponse(fadNo, ser, null, null, null, today, userNo,
                userNo == null ? null : user.getUserName(), 0);
    }

    private static String pad(String s, int n) {
        return s.length() >= n ? s : s + " ".repeat(n - s.length());
    }

    @Transactional
    public TmpFileAddResponse finalize(String fadNo, Double ser) {
        if (tmpFileAddRepository.finalizeRows(fadNo, ser) == 0) {
            throw new ResourceNotFoundException("TmpFileAdd not found: fadNo=" + fadNo + ", ser=" + ser);
        }
        TmpFileAddEntity entity = tmpFileAddRepository.findByTmpFadNo(fadNo).stream()
                .filter(e -> ser.equals(e.getTmpSer())).findFirst()
                .orElseThrow(() -> new ResourceNotFoundException("TmpFileAdd not found: fadNo=" + fadNo + ", ser=" + ser));
        entity.setTmpFinal(1);
        return toResponse(entity);
    }

    @Transactional
    public void delete(String fadNo, Double ser) {
        if (tmpFileAddRepository.deleteOneRow(fadNo, ser) == 0) {
            throw new ResourceNotFoundException("TmpFileAdd not found: fadNo=" + fadNo + ", ser=" + ser);
        }
    }

    private TmpFileAddId buildId(String fadNo, Double ser) {
        TmpFileAddId id = new TmpFileAddId();
        id.setTmpFadNo(fadNo);
        id.setTmpSer(ser);
        return id;
    }

    private TmpFileAddResponse toResponse(TmpFileAddEntity entity) {
        String userName = userName(entity);
        return new TmpFileAddResponse(
                entity.getTmpFadNo(),
                entity.getTmpSer(),
                entity.getTmpFileName(),
                entity.getTmpRmrk(),
                entity.getTmpMk(),
                entity.getTmpDate(),
                entity.getTmpUserNo(),
                userName,
                entity.getTmpFinal()
        );
    }

    /**
     * The documenter's name, or null when tmp_user_no names no config user: legacy stored any char(3)
     * there (no foreign key), so a missing or deleted user must not break the listing.
     */
    static String userName(TmpFileAddEntity entity) {
        try {
            return entity.getUser() != null ? entity.getUser().getUserName() : null;
        } catch (EntityNotFoundException | ObjectNotFoundException e) {
            return null;
        }
    }
}
