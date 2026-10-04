package com.startupstack.app.modules.digitization.service;

import com.startupstack.app.modules.digitization.config.DemandProperties;
import com.startupstack.app.modules.digitization.dto.DeliveryJobStatus;
import com.startupstack.app.modules.digitization.dto.DemandQueueContext;
import com.startupstack.app.modules.digitization.dto.DemandQueueProcessRequest;
import com.startupstack.app.modules.digitization.dto.DemandQueueUser;
import com.startupstack.app.modules.digitization.dto.DemandResponse;
import com.startupstack.app.modules.digitization.entity.DemandEntity;
import com.startupstack.app.modules.digitization.mapper.DemandMapper;
import com.startupstack.app.modules.digitization.repository.DemandRepository;
import com.startupstack.app.modules.digitization.specification.DigitizationSpecification;
import com.startupstack.app.modules.lookups.entity.CodingEntity;
import com.startupstack.app.modules.lookups.repository.CodingRepository;
import com.startupstack.app.modules.users.entity.UserEntity;
import com.startupstack.app.modules.users.repository.UserRepository;
import com.startupstack.app.shared.exception.BusinessException;
import com.startupstack.app.shared.util.SecurityUtils;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.Objects;

/**
 * The "طلبيات الفيديو" order queue — new_vdpreview.frm (ARCHIVE.frm menu f5).
 *
 * <p>Everything here follows that form rather than the other screens that share the
 * {@code demand} table: its grid query (demand LEFT JOIN main / config, {@code ORDER BY dmd_no
 * DESC}, no paging), its search criteria, its user lock, its F1/F2/F5 grid keys and its three
 * processing buttons.
 */
@Service
public class DemandQueueService {

    private final DemandRepository demandRepository;
    private final UserRepository userRepository;
    private final CodingRepository codingRepository;
    private final DemandMapper demandMapper;
    private final DemandProperties demandProperties;
    private final DeliveryJobService deliveryJobService;

    public DemandQueueService(DemandRepository demandRepository,
                              UserRepository userRepository,
                              CodingRepository codingRepository,
                              DemandMapper demandMapper,
                              DemandProperties demandProperties,
                              DeliveryJobService deliveryJobService) {
        this.demandRepository = demandRepository;
        this.userRepository = userRepository;
        this.codingRepository = codingRepository;
        this.demandMapper = demandMapper;
        this.demandProperties = demandProperties;
        this.deliveryJobService = deliveryJobService;
    }

    /**
     * Strict legacy rule. user1.frm's login sets {@code box_user_no} to the typed config.user_no
     * and {@code box_user_start} to config.user_start; new_vdpreview.frm then unlocks the user
     * filter only for {@code box_user_no = "244"} (Form_Load / Command11) and enables "start"
     * (Form_Load) and F5 (DataGrid1_KeyUp) only for {@code box_user_start = 1}. Nothing in the
     * form consults user_level, so the migrated admin level grants neither right here.
     */
    @Transactional(readOnly = true)
    public DemandQueueContext context() {
        UserEntity user = currentUser();
        String userNo = user == null ? null : trim(user.getUserNo());
        boolean allUsers = userNo != null && userNo.equals(demandProperties.getQueueAllUsersUserNo());
        boolean operator = user != null && user.getUserStart() != null
                && user.getUserStart() == demandProperties.getQueueOperatorUserStart();
        return new DemandQueueContext(userNo, user == null ? null : trim(user.getUserName()), allUsers, operator);
    }

    /**
     * The grid query. Criteria mirror the form's crit11 / crit1 builders:
     * <ul>
     *   <li>dates — {@code dmd_dte >= from AND dmd_dte <= to}, by calendar day;</li>
     *   <li>Check1 الطلبات المنجزة — {@code dmd_chek = 2}; Check2 الغير منجزة —
     *       {@code (dmd_chek <> 2 OR dmd_chek IS NULL)} (both together AND, as legacy);</li>
     *   <li>البحث بالشرح — {@code dmd_desc + mn_act_ttl LIKE '%x%'};</li>
     *   <li>رقم الطلب — zero-padded to 7, exact;</li>
     *   <li>المستخدم — {@code dmd_user = user_no}, forced to the caller unless unlocked;</li>
     *   <li>رقم ملف الفيديو — {@code dmd_mch_stock LIKE '%x%'}.</li>
     * </ul>
     */
    @Transactional(readOnly = true)
    public List<DemandResponse> search(LocalDate dateFrom, LocalDate dateTo, boolean done, boolean notDone,
                                       String text, String demandNo, String userNo, String stock) {
        DemandQueueContext ctx = context();
        String effectiveUser = ctx.isCanSeeAllUsers()
                ? blankToNull(userNo)
                : Objects.requireNonNullElse(ctx.getUserNo(), "__none__");

        Specification<DemandEntity> spec = Specification
                .where(DigitizationSpecification.demandDateBetween(
                        dateFrom == null ? null : dateFrom.atStartOfDay(),
                        dateTo == null ? null : dateTo.atStartOfDay()))
                .and(done ? DigitizationSpecification.demandIsFulfilled(true) : null)
                .and(notDone ? DigitizationSpecification.demandIsFulfilled(false) : null)
                .and(DigitizationSpecification.demandQueueTextMatches(blankToNull(text)))
                .and(DigitizationSpecification.demandHasDemandNo(padDemandNo(demandNo)))
                .and(DigitizationSpecification.demandHasUser(effectiveUser))
                .and(DigitizationSpecification.demandHasMachineStock(blankToNull(stock)));

        return demandRepository.findAll(spec, Sort.by(Sort.Direction.DESC, "demandNo"))
                .stream().map(demandMapper::toResponse).toList();
    }

    /**
     * DBList1 fed by {@code serh_config(m_dmd_user.Text, Len(Trim(m_dmd_user.Text)))}
     * (m_dmd_user_Change). serh_config itself is NOT in the legacy DDL, so its body is unknown.
     * Applied here: a leading-characters match on user_name, ordered by name — the form every
     * one of the 16 legacy lookup procs with the same (text, length) signature uses
     * ({@code substring(<name>,1,@lent) = ltrim(@desc) ... order by <name>}: serh_auther,
     * serh_period, serh_macnz, serh_positon, proc_auther, ...). Only the two "wrd" word-search
     * variants differ (LIKE). This is pattern evidence, not proof of serh_config's body.
     */
    @Transactional(readOnly = true)
    public List<DemandQueueUser> users(String prefix) {
        if (!context().isCanSeeAllUsers()) {
            throw new BusinessException("Only the unlocked user may filter by another user");
        }
        String p = prefix == null ? "" : prefix.trim();
        return userRepository.findByUserNameStartingWithOrderByUserName(p).stream()
                .map(u -> new DemandQueueUser(trim(u.getUserNo()), trim(u.getUserName())))
                .toList();
    }

    /**
     * m_view_path DBCombo — {@code select * from view_coding14}, ListField SUB_DESC.
     *
     * <p>Data limitation (2026-10-04): the migrated CODING table holds 12 seeded rows under the
     * 03 / 12 / 13 / 24 prefixes only; no '09' level-2 row exists, so this list is empty until the
     * legacy CODING '09' entries are migrated. They are not in the legacy DDL dump (schema only),
     * so they are not fabricated here.
     */
    @Transactional(readOnly = true)
    public List<String> pathOptions() {
        requireOperator();
        return codingRepository.findViewCoding14().stream()
                .map(CodingEntity::getSubDesc)
                .filter(Objects::nonNull)
                .map(String::trim)
                .toList();
    }

    /**
     * F5 panel: Command3 "تنفيذ الكل" / Command18 "تنفيذ مشهد" → {@code upd_path} for rows whose
     * {@code dmd_chek = 1}, path = chosen base + legacy stock text + ".avi".
     */
    @Transactional
    public void assignPath(List<Integer> ids, String basePath) {
        requireOperator();
        List<DemandEntity> rows = visibleRows(ids);
        for (DemandEntity row : rows) {
            if (row.getChecked() == null || row.getChecked() != 1) {
                continue;
            }
            String stock = legacyPathStock(row.getMachineStock());
            if (stock == null) {
                continue;
            }
            row.setPath(basePath + stock + ".avi");
        }
        demandRepository.saveAll(rows);
    }

    /** F1 (all rows → 1), F2 (all rows → 2), or a single grid-cell edit. */
    @Transactional
    public void setChecked(List<Integer> ids, Integer checked) {
        List<DemandEntity> rows = visibleRows(ids);
        rows.forEach(r -> r.setChecked(checked));
        demandRepository.saveAll(rows);
    }

    /** start / newstart / copy. "start" is only enabled for {@code box_user_start = 1}. */
    public DeliveryJobStatus process(DemandQueueProcessRequest request) {
        if ("START".equals(request.getMechanism())) {
            requireOperator();
        }
        String name = request.getOutputName().trim();
        if (name.isEmpty() || name.contains("/") || name.contains("\\") || name.contains("..")
                || name.contains(":")) {
            throw new BusinessException("The output name must be a plain file name");
        }
        List<Integer> ids = visibleRows(request.getIds()).stream().map(DemandEntity::getId).toList();
        // visibleRows loses order; keep the grid order the client sent.
        List<Integer> ordered = request.getIds().stream().filter(ids::contains).toList();
        DeliveryJobStatus status = deliveryJobService.start(ordered);
        deliveryJobService.runQueueProcess(status.getJobId(), ordered, request.getMechanism(), request.isClip(), name);
        return status;
    }

    /**
     * Legacy {@code Mid("00000", 1, 6 - Len(Trim(m_stock))) + Trim(Str(m_stock))}: the padding
     * length comes from the stored text, the digits from its numeric value. A stored "123"
     * becomes "000123"; a stored "000123" becomes "123". Non-numeric stock is skipped (legacy
     * would raise a type error).
     */
    static String legacyPathStock(String stock) {
        String t = trim(stock);
        if (t == null || t.isEmpty()) {
            return null;
        }
        long number;
        try {
            number = Long.parseLong(t);
        } catch (NumberFormatException e) {
            return null;
        }
        int pad = Math.max(0, Math.min(5, 6 - t.length()));
        return "00000".substring(0, pad) + number;
    }

    /** Legacy {@code Mid("0000000", 1, 7 - Len(no)) + no}. */
    static String padDemandNo(String demandNo) {
        String t = blankToNull(demandNo);
        if (t == null) {
            return null;
        }
        return t.length() >= 7 ? t : "0".repeat(7 - t.length()) + t;
    }

    /** Rows the caller may act on — the legacy grid only ever held their own unless unlocked. */
    private List<DemandEntity> visibleRows(List<Integer> ids) {
        DemandQueueContext ctx = context();
        List<DemandEntity> rows = demandRepository.findAllById(ids);
        if (ctx.isCanSeeAllUsers()) {
            return rows;
        }
        return rows.stream().filter(r -> ctx.getUserNo() != null && ctx.getUserNo().equals(trim(r.getUserNo()))).toList();
    }

    private void requireOperator() {
        if (!context().isCanOperate()) {
            throw new BusinessException("This action is reserved for operators (user_start = 1)");
        }
    }

    private UserEntity currentUser() {
        String username = SecurityUtils.getCurrentUsername();
        return username == null ? null : userRepository.findByUserName(username).orElse(null);
    }

    private static String trim(String value) {
        return value == null ? null : value.trim();
    }

    private static String blankToNull(String value) {
        return value == null || value.isBlank() ? null : value.trim();
    }
}
