package com.startupstack.app.modules.digitization.service;

import com.startupstack.app.modules.catalogue.repository.CatalogueRepository;
import com.startupstack.app.modules.digitization.config.DemandProperties;
import com.startupstack.app.modules.digitization.dto.AddSceneRequest;
import com.startupstack.app.modules.digitization.dto.DemandRequest;
import com.startupstack.app.modules.digitization.dto.DemandResponse;
import com.startupstack.app.modules.digitization.dto.DemandStatsResponse;
import com.startupstack.app.modules.digitization.dto.DeliveryJobStatus;
import com.startupstack.app.modules.digitization.dto.DemandTestResult;
import com.startupstack.app.modules.digitization.dto.DigitRequest;
import com.startupstack.app.modules.digitization.dto.LogUsageRequestBatch;
import com.startupstack.app.modules.digitization.dto.LogUsageRequestItem;
import com.startupstack.app.modules.digitization.dto.ManageResultRequest;
import com.startupstack.app.modules.digitization.dto.DigitResponse;
import com.startupstack.app.modules.digitization.dto.ResultRequest;
import com.startupstack.app.modules.digitization.dto.ResultResponse;
import com.startupstack.app.modules.digitization.entity.DemandEntity;
import com.startupstack.app.modules.digitization.entity.DigitEntity;
import com.startupstack.app.modules.digitization.entity.DigitId;
import com.startupstack.app.modules.digitization.entity.ResultEntity;
import com.startupstack.app.modules.digitization.mapper.DemandMapper;
import com.startupstack.app.modules.digitization.mapper.DigitMapper;
import com.startupstack.app.modules.digitization.mapper.ResultMapper;
import com.startupstack.app.modules.digitization.repository.DemandRepository;
import com.startupstack.app.modules.digitization.repository.DigitRepository;
import com.startupstack.app.modules.digitization.repository.ResultRepository;
import com.startupstack.app.modules.digitization.specification.DigitizationSpecification;
import com.startupstack.app.modules.lookups.entity.CodingEntity;
import com.startupstack.app.modules.lookups.repository.CodingRepository;
import com.startupstack.app.modules.users.entity.UserEntity;
import com.startupstack.app.modules.users.repository.UserRepository;
import com.startupstack.app.shared.exception.BusinessException;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import com.startupstack.app.shared.media.FfmpegService;
import com.startupstack.app.shared.media.MediaService;
import com.startupstack.app.shared.media.StockTier;
import com.startupstack.app.shared.util.FilenameSanitiser;
import com.startupstack.app.shared.util.SecurityUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Service
public class DigitizationService {

    private final DigitRepository digitRepository;
    private final DemandRepository demandRepository;
    private final ResultRepository resultRepository;
    private final CatalogueRepository catalogueRepository;
    private final UserRepository userRepository;
    private final DigitMapper digitMapper;
    private final DemandMapper demandMapper;
    private final ResultMapper resultMapper;
    private final MediaService mediaService;
    private final FfmpegService ffmpegService;
    private final CodingRepository codingRepository;
    private final DemandProperties demandProperties;
    private final DeliveryJobService deliveryJobService;

    public DigitizationService(DigitRepository digitRepository,
                               DemandRepository demandRepository,
                               ResultRepository resultRepository,
                               CatalogueRepository catalogueRepository,
                               UserRepository userRepository,
                               DigitMapper digitMapper,
                               DemandMapper demandMapper,
                               ResultMapper resultMapper,
                               MediaService mediaService,
                               FfmpegService ffmpegService,
                               CodingRepository codingRepository,
                               DemandProperties demandProperties,
                               DeliveryJobService deliveryJobService) {
        this.deliveryJobService = deliveryJobService;
        this.demandProperties = demandProperties;
        this.digitRepository = digitRepository;
        this.demandRepository = demandRepository;
        this.resultRepository = resultRepository;
        this.catalogueRepository = catalogueRepository;
        this.userRepository = userRepository;
        this.codingRepository = codingRepository;
        this.digitMapper = digitMapper;
        this.demandMapper = demandMapper;
        this.resultMapper = resultMapper;
        this.mediaService = mediaService;
        this.ffmpegService = ffmpegService;
    }

    @Transactional(readOnly = true)
    public Page<DigitResponse> findAllRecords(String docNo, String type, Pageable pageable) {
        String userEnt = SecurityUtils.isAdmin() ? null : SecurityUtils.getCurrentUserEnt();
        Specification<DigitEntity> spec = DigitizationSpecification.digitBelongsToUserEntity(userEnt)
                .and(DigitizationSpecification.digitHasDocNo(docNo))
                .and(DigitizationSpecification.digitHasType(type));
        return digitRepository.findAll(spec, pageable).map(digitMapper::toResponse);
    }

    @Transactional(readOnly = true)
    public DigitResponse findRecordById(String docNo, Integer serial) {
        DigitId id = new DigitId();
        id.setDocNo(docNo);
        id.setSerial(serial);
        DigitEntity entity = digitRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Digit record not found: " + docNo + "/" + serial));
        return digitMapper.toResponse(entity);
    }

    @Transactional
    public DigitResponse createRecord(DigitRequest request) {
        catalogueRepository.findById(request.getDocNo())
                .orElseThrow(() -> new ResourceNotFoundException("Catalogue record not found: " + request.getDocNo()));
        DigitEntity entity = digitMapper.toEntity(request);
        return digitMapper.toResponse(digitRepository.save(entity));
    }

    @Transactional
    public DigitResponse updateRecord(String docNo, Integer serial, DigitRequest request) {
        DigitId id = new DigitId();
        id.setDocNo(docNo);
        id.setSerial(serial);
        DigitEntity entity = digitRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Digit record not found: " + docNo + "/" + serial));
        digitMapper.updateEntity(request, entity);
        return digitMapper.toResponse(digitRepository.save(entity));
    }

    @Transactional
    public void deleteRecord(String docNo, Integer serial) {
        DigitId id = new DigitId();
        id.setDocNo(docNo);
        id.setSerial(serial);
        if (!digitRepository.existsById(id)) {
            throw new ResourceNotFoundException("Digit record not found: " + docNo + "/" + serial);
        }
        digitRepository.deleteById(id);
    }

    @Transactional(readOnly = true)
    public Page<DemandResponse> findAllDemands(String userNo, String machineNo, String demandNo,
                                                String machineStock, Boolean fulfilled,
                                                LocalDateTime dateFrom, LocalDateTime dateTo,
                                                String search, Pageable pageable) {
        Specification<DemandEntity> spec = buildDemandSpec(userNo, machineNo, demandNo, machineStock, fulfilled, dateFrom, dateTo, search);
        return demandRepository.findAll(spec, pageable).map(demandMapper::toResponse);
    }

    /**
     * Command15 "عدد ومدة المشاهد" — count and total duration of the demands matching the
     * current filter, without paging through them.
     */
    @Transactional(readOnly = true)
    public DemandStatsResponse getDemandStats(String userNo, String machineNo, String demandNo,
                                               String machineStock, Boolean fulfilled,
                                               LocalDateTime dateFrom, LocalDateTime dateTo, String search) {
        Specification<DemandEntity> spec = buildDemandSpec(userNo, machineNo, demandNo, machineStock, fulfilled, dateFrom, dateTo, search);
        List<DemandEntity> all = demandRepository.findAll(spec);
        long totalSeconds = all.stream()
                .mapToLong(e -> e.getOutputSize() == null ? 0L : e.getOutputSize().longValue())
                .sum();
        return new DemandStatsResponse(all.size(), totalSeconds);
    }

    private Specification<DemandEntity> buildDemandSpec(String userNo, String machineNo, String demandNo,
                                                          String machineStock, Boolean fulfilled,
                                                          LocalDateTime dateFrom, LocalDateTime dateTo, String search) {
        // Legacy locked the order queue to the requester's own demands unless their user code was
        // the hardcoded admin override "244" (m_dmd_user.Enabled = False for everyone else). The
        // modern equivalent is a real role check: non-admins can never see or filter by another
        // user's orders, no matter what userNo they pass.
        boolean isAdmin = SecurityUtils.isAdmin();
        // If a non-admin's username can't be resolved to a user_no, fail closed (match nothing)
        // rather than silently dropping the ownership filter and exposing every user's demands.
        String effectiveUserNo = isAdmin ? userNo : Objects.requireNonNullElse(currentUserNo(), "__none__");

        return DigitizationSpecification.demandHasUser(effectiveUserNo)
                .and(DigitizationSpecification.demandHasMachine(machineNo))
                .and(DigitizationSpecification.demandHasDemandNo(demandNo))
                .and(DigitizationSpecification.demandHasMachineStock(machineStock))
                .and(DigitizationSpecification.demandIsFulfilled(fulfilled))
                .and(DigitizationSpecification.demandDateBetween(dateFrom, dateTo))
                .and(DigitizationSpecification.demandDescriptionOrTitleContains(search));
    }

    /**
     * Admin-only reassignment of a demand's resolved storage path — migrated equivalent of the
     * legacy new_vdpreview.frm F5 panel ("تحديد المسار"), which was itself gated behind the
     * box_user_start operator flag.
     */
    @Transactional
    public DemandResponse reassignPath(Integer id, String path) {
        if (!SecurityUtils.isAdmin()) {
            throw new BusinessException("Only an administrator can reassign a demand's storage path");
        }
        DemandEntity entity = demandRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Demand not found: " + id));
        entity.setPath(path);
        return demandMapper.toResponse(demandRepository.save(entity));
    }

    /**
     * Marks a chosen set of demands fulfilled/pending in one call — the explicit, opt-in
     * replacement for the legacy F1/F2 keys, which silently bulk-applied to every row in the
     * currently visible grid rather than just the selected one.
     */
    @Transactional
    public void bulkSetFulfilled(List<Integer> ids, boolean fulfilled) {
        bulkSetChecked(ids, fulfilled ? 2 : 1);
    }

    /**
     * Writes the raw legacy dmd_chek value. The archive-search cockpit's "الاختيار" checkbox
     * needs the de-selected state ({@code 0}) that {@link #bulkSetFulfilled}'s boolean cannot
     * express — see DemandBulkStatusRequest#getChecked.
     */
    @Transactional
    public void bulkSetChecked(List<Integer> ids, int checked) {
        if (checked < 0 || checked > 2) {
            throw new BusinessException("Unsupported dmd_chek value: " + checked);
        }
        List<DemandEntity> entities = demandRepository.findAllById(ids);
        for (DemandEntity entity : entities) {
            entity.setChecked(checked);
        }
        demandRepository.saveAll(entities);
    }

    /**
     * Fulfils a single demand using one of the legacy screen's three parallel mechanisms:
     * Command9 "start" (full re-encode), Command4 "newstart" (ffmpeg stream-copy trim), or
     * Command5 "copy" (plain whole-file copy). All three converge on the same outcome —
     * a file lands in the archive path and the demand is marked done.
     */
    @Transactional
    public DemandResponse fulfilDemand(Integer id, String mechanism) {
        DemandEntity entity = requireDemandWithStock(id);
        String destination = fulfilOne(entity, mechanism);
        entity.setPath(destination);
        entity.setChecked(2);
        return demandMapper.toResponse(demandRepository.save(entity));
    }

    /**
     * Fulfils several demands at once. With {@code mergeClip} set — the legacy "كليب" checkbox —
     * every selected demand's trimmed clip is concatenated into a single output file instead of
     * each getting its own.
     */
    @Transactional
    public void bulkFulfil(List<Integer> ids, String mechanism, boolean mergeClip) {
        List<DemandEntity> entities = new ArrayList<>();
        for (Integer id : ids) {
            entities.add(requireDemandWithStock(id));
        }

        if (mergeClip && entities.size() > 1) {
            List<String> clipPaths = new ArrayList<>();
            for (DemandEntity entity : entities) {
                clipPaths.add(fulfilOne(entity, mechanism));
            }
            String merged = mediaService.archivePathFor("merged_" + entities.get(0).getDemandNo());
            ffmpegService.mergeConcat(clipPaths, merged);
            for (DemandEntity entity : entities) {
                entity.setPath(merged);
                entity.setChecked(2);
            }
        } else {
            for (DemandEntity entity : entities) {
                entity.setPath(fulfilOne(entity, mechanism));
                entity.setChecked(2);
            }
        }
        demandRepository.saveAll(entities);
    }

    /** Command19 "test" — dry-run check that each demand's source tape exists and is decodable, without fulfilling anything. */
    @Transactional(readOnly = true)
    public List<DemandTestResult> testDemands(List<Integer> ids) {
        List<DemandTestResult> results = new ArrayList<>();
        for (Integer id : ids) {
            DemandEntity entity = demandRepository.findById(id).orElse(null);
            if (entity == null) {
                results.add(new DemandTestResult(id, null, false, "Demand not found"));
                continue;
            }
            if (entity.getMachineStock() == null || entity.getMachineStock().isBlank()) {
                results.add(new DemandTestResult(id, entity.getDemandNo(), false, "No tape/stock number on file"));
                continue;
            }
            boolean ok = ffmpegService.checkPlayable(sourcePathFor(entity));
            results.add(new DemandTestResult(id, entity.getDemandNo(), ok, ok ? "OK" : "Source file missing or unreadable"));
        }
        return results;
    }

    private DemandEntity requireDemandWithStock(Integer id) {
        DemandEntity entity = demandRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Demand not found: " + id));
        if (entity.getMachineStock() == null || entity.getMachineStock().isBlank()) {
            throw new BusinessException("Demand has no tape/stock number to fulfil from");
        }
        return entity;
    }

    /**
     * The source for every fulfilment mechanism is the broadcast master. Legacy always feeds
     * ffmpeg {@code V_PATH}, which is the demand's own {@code dmd_path} — already resolved
     * against the HIGH tier when the scene was queued — so that column wins here and tier
     * resolution is only a fallback for rows predating it.
     */
    private String sourcePathFor(DemandEntity entity) {
        String stored = entity.getPath();
        if (stored != null && !stored.isBlank()) {
            return stored.trim();
        }
        return mediaService.resolveStockPath(entity.getMachineStock(), StockTier.HIGH, null);
    }

    private String fulfilOne(DemandEntity entity, String mechanism) {
        String source = sourcePathFor(entity);
        BigDecimal in = entity.getInputSize();
        BigDecimal duration = entity.getOutputSize();
        return switch (mechanism) {
            case "START" -> {
                String destination = mediaService.archivePathFor(entity.getDemandNo() + "_" + entity.getSerial());
                ffmpegService.reencode(source, destination, in, duration);
                yield destination;
            }
            case "NEWSTART" -> {
                String destination = mediaService.archivePathFor(entity.getDemandNo() + "_" + entity.getSerial());
                ffmpegService.streamCopyTrim(source, destination, in, duration);
                yield destination;
            }
            case "COPY" -> mediaService.copyToArchive(entity.getMachineStock(), StockTier.HIGH, null);
            default -> throw new BusinessException("Unknown fulfilment mechanism: " + mechanism);
        };
    }

    /**
     * Legacy Command5 "ارسل الى EDLC". The executing user is resolved here, on the request
     * thread, because {@link SecurityUtils} reads request-scoped attributes that are gone by
     * the time the background job runs.
     */
    public DeliveryJobStatus startSendToEdlc(List<Integer> ids) {
        String username = SecurityUtils.getCurrentUsername();
        UserEntity user = username == null ? null : userRepository.findByUserName(username).orElse(null);
        DeliveryJobStatus status = deliveryJobService.start(ids);
        deliveryJobService.runSendToEdlc(
                status.getJobId(), ids,
                user == null ? null : user.getUserNo(),
                user == null ? username : user.getUserName());
        return status;
    }

    /** Legacy Command14 "تنفيد". */
    public DeliveryJobStatus startExtractClips(List<Integer> ids) {
        DeliveryJobStatus status = deliveryJobService.start(ids);
        deliveryJobService.runExtractClips(status.getJobId(), ids);
        return status;
    }

    public DeliveryJobStatus getDeliveryJob(String jobId) {
        return deliveryJobService.getStatus(jobId);
    }

    /** Legacy {@code box_user_start < 2} — low-privilege accounts bypass the scene-length cap. */
    private boolean isExemptFromSceneCap(UserEntity user) {
        return user != null
                && user.getUserStart() != null
                && user.getUserStart() < demandProperties.getPrivilegedUserStartLevel();
    }

    private String currentUserNo() {
        String username = SecurityUtils.getCurrentUsername();
        if (username == null) {
            return null;
        }
        return userRepository.findByUserName(username).map(UserEntity::getUserNo).orElse(null);
    }

    @Transactional(readOnly = true)
    public DemandResponse findDemandById(Integer id) {
        DemandEntity entity = demandRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Demand not found: " + id));
        return demandMapper.toResponse(entity);
    }

    @Transactional
    public DemandResponse createDemand(DemandRequest request) {
        DemandEntity entity = demandMapper.toEntity(request);

        if (request.getUserNo() != null) {
            entity.setUser(userRepository.findById(request.getUserNo())
                    .orElseThrow(() -> new ResourceNotFoundException("User not found: " + request.getUserNo())));
        }
        if (request.getMachineNo() != null) {
            entity.setCatalogue(catalogueRepository.findById(request.getMachineNo())
                    .orElseThrow(() -> new ResourceNotFoundException("Catalogue record not found: " + request.getMachineNo())));
        }

        return demandMapper.toResponse(demandRepository.save(entity));
    }

    /**
     * Legacy Command20_Click (USER_INTERFACE1.frm:3843-3853) runs del_demand only when
     * {@code dmd_chek <> 2} — a fulfilled scene has already been delivered and cannot be
     * removed from the request. Enforced here rather than only in the UI so the guard holds
     * for any caller.
     */
    @Transactional
    public void deleteDemand(Integer id) {
        DemandEntity entity = demandRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Demand not found: " + id));
        if (entity.getChecked() != null && entity.getChecked() == 2) {
            throw new BusinessException("A fulfilled scene cannot be removed from the request");
        }
        demandRepository.delete(entity);
    }

    /**
     * Adds one scene to a material request, collapsing the legacy
     * op_demand/max_demand/max_demand_ser/upd_demand4/insr_demand4 stored-procedure chain
     * (USER_INTERFACE1.frm Command15_Click) into one call. Pass the {@code demandNo} this
     * returns back in on the next call to keep appending scenes to the same request; leave
     * it blank to start a new one.
     */
    @Transactional
    public DemandResponse addScene(AddSceneRequest request) {
        var catalogue = catalogueRepository.findById(request.getMachineNo())
                .orElseThrow(() -> new ResourceNotFoundException("Catalogue record not found: " + request.getMachineNo()));

        String demandNo = request.getDemandNo();
        int serial;
        if (demandNo == null || demandNo.isBlank()) {
            int next = demandRepository.findMaxNumericDemandNo() + 1;
            demandNo = String.format("%07d", next);
            serial = 1;
        } else {
            Integer maxSerial = demandRepository.findMaxSerialForDemandNo(demandNo);
            serial = (maxSerial == null ? 0 : maxSerial) + 1;
        }

        if (request.getOutSeconds().compareTo(request.getInSeconds()) < 0) {
            throw new BusinessException("Out point must not be before the in point");
        }

        String username = SecurityUtils.getCurrentUsername();
        UserEntity user = username == null ? null : userRepository.findByUserName(username).orElse(null);

        // Legacy Command15_Click:3520 — `If m_len_mch < 400 Or box_user_start < 2`. Ordinary
        // operators cannot queue a scene at or beyond the cap; users below the privilege
        // threshold are exempt.
        BigDecimal sceneLength = request.getOutSeconds().subtract(request.getInSeconds());
        if (!isExemptFromSceneCap(user)
                && sceneLength.compareTo(BigDecimal.valueOf(demandProperties.getMaxSceneSeconds())) >= 0) {
            throw new BusinessException("A scene may not be longer than "
                    + demandProperties.getMaxSceneSeconds() + " seconds");
        }

        // dmd_path addresses the broadcast MASTER, not the preview proxy — legacy
        // Command12_Click:3187 builds it from high_stock_path() and dig_typ_high, and the
        // delivery pipelines later cut from whatever this column holds.
        String path = request.getPath();
        if ((path == null || path.isBlank()) && request.getMachineStock() != null) {
            path = mediaService.resolveStockPath(
                    request.getMachineStock(), StockTier.HIGH, request.getHighExtension());
        }

        var length = request.getOutSeconds().subtract(request.getInSeconds());
        long totalSeconds = length.longValue();

        DemandEntity entity = new DemandEntity();
        entity.setDemandNo(demandNo);
        entity.setSerial(serial);
        entity.setUser(user);
        entity.setCatalogue(catalogue);
        entity.setDate(LocalDateTime.now());
        entity.setInputSize(request.getInSeconds());
        entity.setOutputSize(length);
        entity.setPath(path);
        // The description becomes an output filename downstream, so it is sanitised here
        // rather than trusting the client — legacy Command15_Click:3488-3505.
        entity.setDescription(FilenameSanitiser.sanitise(request.getDescription()));
        entity.setMachineStock(request.getMachineStock());
        entity.setChecked(1);
        entity.setHours((int) (totalSeconds / 3600));
        entity.setMinutes((int) ((totalSeconds % 3600) / 60));
        entity.setSeconds((int) (totalSeconds % 60));
        entity.setFrames(0);
        entity.setTime1(LocalDateTime.now().format(DateTimeFormatter.ofPattern("HH:mm:ss")));

        return demandMapper.toResponse(demandRepository.save(entity));
    }

    @Transactional(readOnly = true)
    public Page<ResultResponse> findAllResults(String digitNo, String type, String type1, String resultNo,
                                                String person, String cote, String permit, String subject,
                                                String title, LocalDateTime dateFrom, LocalDateTime dateTo,
                                                Pageable pageable) {
        Specification<ResultEntity> spec = DigitizationSpecification.resultHasDigitNo(digitNo)
                .and(DigitizationSpecification.resultHasType(type))
                .and(DigitizationSpecification.resultHasType1(type1))
                .and(DigitizationSpecification.resultHasResultNo(resultNo))
                .and(DigitizationSpecification.resultPersonContains(person))
                .and(DigitizationSpecification.resultHasCote(cote))
                .and(DigitizationSpecification.resultHasPermit(permit))
                .and(DigitizationSpecification.resultSubjectContains(subject))
                .and(DigitizationSpecification.resultTitleContains(title))
                .and(DigitizationSpecification.resultDateBetween(dateFrom, dateTo));
        return resultRepository.findAll(spec, pageable).map(this::toEnrichedResultResponse);
    }

    /**
     * Resolves the legacy tmp_dmd_result view's three CODING joins (desc_cote via '32'+res_cote,
     * desc_permit via '33'+res_permit, desc_typ1 via '24'+res_typ1) so the request list can show
     * human-readable labels instead of raw 2–3 character codes.
     */
    private ResultResponse toEnrichedResultResponse(ResultEntity entity) {
        ResultResponse response = resultMapper.toResponse(entity);
        response.setCoteDescription(resolveCoding("32", entity.getCote()));
        response.setPermitDescription(resolveCoding("33", entity.getPermit()));
        response.setType1Description(resolveCoding("24", entity.getType1()));
        return response;
    }

    private String resolveCoding(String domainPrefix, String code) {
        if (code == null || code.isBlank()) {
            return null;
        }
        return codingRepository.findFirstBySubCode(domainPrefix + code)
                .map(CodingEntity::getSubDesc)
                .orElse(null);
    }

    @Transactional(readOnly = true)
    public ResultResponse findResultById(Integer id) {
        ResultEntity entity = resultRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Result not found: " + id));
        return resultMapper.toResponse(entity);
    }

    @Transactional
    public ResultResponse createResult(ResultRequest request) {
        ResultEntity entity = resultMapper.toEntity(request);
        return resultMapper.toResponse(resultRepository.save(entity));
    }

    @Transactional
    public ResultResponse updateResult(Integer id, ResultRequest request) {
        ResultEntity entity = resultRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Result not found: " + id));
        resultMapper.updateEntity(request, entity);
        return resultMapper.toResponse(resultRepository.save(entity));
    }

    /**
     * "مع تسجيل الطلب" — logs a usage request for one or more documents found on شاشة البحث,
     * collapsing the legacy op_result/max_result/insr_result stored-procedure chain
     * (Command9 "نسخ الاختيار" / Command11 "نسخ الجدول") into one call. Every item shares a
     * single new resultNo (minted once, like op_result/max_result) with an incrementing
     * serial per item (like insr_result) — exactly how a multi-row export became one request
     * with several lines rather than N unrelated requests.
     */
    @Transactional
    public List<ResultResponse> logUsageRequest(LogUsageRequestBatch request) {
        int nextResultNo = resultRepository.findMaxNumericResultNo() + 1;
        String resultNo = String.format("%07d", nextResultNo);
        LocalDateTime now = LocalDateTime.now();
        String userNo = currentUserNo();

        List<ResultEntity> entities = new ArrayList<>();
        int serial = 1;
        for (LogUsageRequestItem item : request.getItems()) {
            ResultEntity entity = new ResultEntity();
            entity.setResultNo(resultNo);
            entity.setSerial(serial++);
            entity.setCatalogueAppNo(item.getCatalogueAppNo());
            entity.setDigitNo(item.getDigitNo());
            entity.setType(item.getType());
            entity.setType1(item.getType1());
            entity.setDate(now);
            entity.setUserNo(userNo);
            entity.setPerson(request.getPerson());
            entity.setCote(request.getCote());
            entity.setPermit(request.getPermit());
            entity.setSubject(request.getSubject());
            entities.add(entity);
        }

        return resultRepository.saveAll(entities).stream().map(resultMapper::toResponse).toList();
    }

    /**
     * "الغاء الطلب" — legacy gated this to a single hardcoded user code ("244"); the modern
     * equivalent is a real admin-role check.
     */
    @Transactional
    public void deleteResult(Integer id) {
        if (!SecurityUtils.isAdmin()) {
            throw new BusinessException("Only an administrator can cancel a usage request");
        }
        if (!resultRepository.existsById(id)) {
            throw new ResourceNotFoundException("Result not found: " + id);
        }
        resultRepository.deleteById(id);
    }

    /**
     * "معالجة طلبات معينة" Frame2 تعديل (Command9) — legacy upd_result1 keys on res_no, not
     * the unique id, and updates every row sharing that request number (a multi-serial
     * request has several rows). No validation beyond "رقم الطلب not empty", exactly as
     * legacy only guards with "If Not v_res_no.Text = """.
     */
    @Transactional
    public List<ResultResponse> updateResultByResultNo(String resultNo, ManageResultRequest request) {
        List<ResultEntity> rows = resultRepository.findByResultNo(resultNo);
        if (rows.isEmpty()) {
            throw new ResourceNotFoundException("Result not found: " + resultNo);
        }
        for (ResultEntity entity : rows) {
            entity.setPerson(request.getPerson());
            entity.setCote(request.getCote());
            entity.setPermit(request.getPermit());
            entity.setSubject(request.getSubject());
        }
        return resultRepository.saveAll(rows).stream().map(resultMapper::toResponse).toList();
    }

    /**
     * "معالجة طلبات معينة" Frame2 الغاء الطلب (Command6) — legacy del_result keys on res_no
     * and deletes every row sharing it. Legacy gated this to a single hardcoded user code
     * ("244"); modern equivalent is a real admin-role check (same pattern as deleteResult()).
     */
    @Transactional
    public void deleteResultByResultNo(String resultNo) {
        if (!SecurityUtils.isAdmin()) {
            throw new BusinessException("Only an administrator can cancel a usage request");
        }
        List<ResultEntity> rows = resultRepository.findByResultNo(resultNo);
        if (rows.isEmpty()) {
            throw new ResourceNotFoundException("Result not found: " + resultNo);
        }
        resultRepository.deleteAll(rows);
    }
}
