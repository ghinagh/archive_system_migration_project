package com.startupstack.app.modules.lookups.service;

import com.startupstack.app.modules.lookups.dto.Arrays1Response;
import com.startupstack.app.modules.lookups.dto.ArraysResponse;
import com.startupstack.app.modules.lookups.dto.CodingRequest;
import com.startupstack.app.modules.lookups.dto.CodingResponse;
import com.startupstack.app.modules.lookups.dto.CotePubRequest;
import com.startupstack.app.modules.lookups.dto.CotePubResponse;
import com.startupstack.app.modules.lookups.dto.DictResponse;
import com.startupstack.app.modules.lookups.dto.MacnzRequest;
import com.startupstack.app.modules.lookups.dto.MacnzResponse;
import com.startupstack.app.modules.lookups.dto.MemResponse;
import com.startupstack.app.modules.lookups.dto.RelisResponse;
import com.startupstack.app.modules.lookups.dto.TOperationResponse;
import com.startupstack.app.modules.lookups.entity.ArraysEntity;
import com.startupstack.app.modules.lookups.entity.CodingEntity;
import com.startupstack.app.modules.lookups.entity.CodingEntityId;
import com.startupstack.app.modules.lookups.entity.CotePubEntity;
import com.startupstack.app.modules.lookups.entity.MacnzEntity;
import com.startupstack.app.modules.lookups.mapper.LookupsMapper;
import com.startupstack.app.modules.lookups.repository.Arrays1Repository;
import com.startupstack.app.modules.lookups.repository.ArraysRepository;
import com.startupstack.app.modules.lookups.repository.CodingRepository;
import com.startupstack.app.modules.lookups.repository.CotePubRepository;
import com.startupstack.app.modules.lookups.repository.DictRepository;
import com.startupstack.app.modules.lookups.repository.MacnzRepository;
import com.startupstack.app.modules.lookups.repository.MemRepository;
import com.startupstack.app.modules.lookups.repository.RelisRepository;
import com.startupstack.app.modules.lookups.repository.TOperationRepository;
import com.startupstack.app.shared.exception.BusinessException;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class LookupsService {

    private final ArraysRepository arraysRepository;
    private final Arrays1Repository arrays1Repository;
    private final MacnzRepository macnzRepository;
    private final CodingRepository codingRepository;
    private final RelisRepository relisRepository;
    private final DictRepository dictRepository;
    private final MemRepository memRepository;
    private final CotePubRepository cotePubRepository;
    private final TOperationRepository tOperationRepository;
    private final LookupsMapper lookupsMapper;

    public LookupsService(ArraysRepository arraysRepository,
                          Arrays1Repository arrays1Repository,
                          MacnzRepository macnzRepository,
                          CodingRepository codingRepository,
                          RelisRepository relisRepository,
                          DictRepository dictRepository,
                          MemRepository memRepository,
                          CotePubRepository cotePubRepository,
                          TOperationRepository tOperationRepository,
                          LookupsMapper lookupsMapper) {
        this.arraysRepository = arraysRepository;
        this.arrays1Repository = arrays1Repository;
        this.macnzRepository = macnzRepository;
        this.codingRepository = codingRepository;
        this.relisRepository = relisRepository;
        this.dictRepository = dictRepository;
        this.memRepository = memRepository;
        this.cotePubRepository = cotePubRepository;
        this.tOperationRepository = tOperationRepository;
        this.lookupsMapper = lookupsMapper;
    }

    @Cacheable(value = "lookups-arrays", key = "#arTyp != null ? #arTyp : 'ALL'")
    public List<ArraysResponse> getAllArrays(String arTyp) {
        List<ArraysEntity> entities = arTyp != null
                ? arraysRepository.findByArTyp(arTyp)
                : arraysRepository.findAll();
        return lookupsMapper.toArraysResponseList(entities);
    }

    @Cacheable(value = "lookups-arrays1", key = "#arTyp != null ? #arTyp : 'ALL'")
    public List<Arrays1Response> getAllArrays1(String arTyp) {
        return lookupsMapper.toArrays1ResponseList(
                arTyp != null ? arrays1Repository.findByArTyp(arTyp) : arrays1Repository.findAll());
    }

    @Cacheable(value = "lookups-relations")
    public List<RelisResponse> getAllRelations() {
        return lookupsMapper.toRelisResponseList(relisRepository.findAll());
    }

    @Cacheable(value = "lookups-dict", key = "#subCode3 != null ? #subCode3 : 'ALL'")
    public List<DictResponse> getAllDict(String subCode3) {
        return lookupsMapper.toDictResponseList(
                subCode3 != null ? dictRepository.findBySubCode3(subCode3) : dictRepository.findAll());
    }

    @Cacheable(value = "lookups-mem")
    public List<MemResponse> getAllMem() {
        return lookupsMapper.toMemResponseList(memRepository.findAll());
    }

    @Cacheable(value = "lookups-cote-pub")
    public List<CotePubResponse> getAllCotePub() {
        return lookupsMapper.toCotePubResponseList(cotePubRepository.findAll());
    }

    @CacheEvict(value = "lookups-cote-pub", allEntries = true)
    @Transactional
    public CotePubResponse createCotePub(CotePubRequest request) {
        CotePubEntity entity = new CotePubEntity();
        entity.setCtpNo(request.ctpNo());
        entity.setCtpNam(request.ctpNam());
        return lookupsMapper.toCotePubResponse(cotePubRepository.save(entity));
    }

    @CacheEvict(value = "lookups-cote-pub", allEntries = true)
    @Transactional
    public CotePubResponse updateCotePub(Double id, CotePubRequest request) {
        CotePubEntity entity = cotePubRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("CotePub not found: " + id));
        entity.setCtpNam(request.ctpNam());
        return lookupsMapper.toCotePubResponse(cotePubRepository.save(entity));
    }

    @CacheEvict(value = "lookups-cote-pub", allEntries = true)
    @Transactional
    public void deleteCotePub(Double id) {
        if (!cotePubRepository.existsById(id)) {
            throw new ResourceNotFoundException("CotePub not found: " + id);
        }
        cotePubRepository.deleteById(id);
    }

    @Cacheable(value = "lookups-operations")
    public List<TOperationResponse> getAllOperations() {
        return lookupsMapper.toTOperationResponseList(tOperationRepository.findAll());
    }

    @Cacheable(value = "lookups-subjects")
    public List<MacnzResponse> getAllSubjects() {
        return lookupsMapper.toMacnzResponseList(macnzRepository.findAll());
    }

    @CacheEvict(value = "lookups-subjects", allEntries = true)
    @Transactional
    public MacnzResponse createSubject(MacnzRequest request) {
        if (macnzRepository.existsById(request.code())) {
            throw new BusinessException("Subject code already exists: " + request.code());
        }
        MacnzEntity entity = new MacnzEntity();
        entity.setSubCode(request.code());
        entity.setSubLevel(request.level());
        entity.setSubDesc(request.description());
        return lookupsMapper.toMacnzResponse(macnzRepository.save(entity));
    }

    @CacheEvict(value = "lookups-subjects", allEntries = true)
    @Transactional
    public MacnzResponse updateSubject(String code, MacnzRequest request) {
        MacnzEntity entity = macnzRepository.findById(code)
                .orElseThrow(() -> new ResourceNotFoundException("Subject not found: " + code));
        entity.setSubDesc(request.description());
        return lookupsMapper.toMacnzResponse(macnzRepository.save(entity));
    }

    @CacheEvict(value = "lookups-subjects", allEntries = true)
    @Transactional
    public void deleteSubject(String code) {
        if (!macnzRepository.existsById(code)) {
            throw new ResourceNotFoundException("Subject not found: " + code);
        }
        macnzRepository.deleteById(code);
    }

    @Cacheable(value = "lookups-coding")
    public List<CodingResponse> getAllCoding() {
        List<CodingResponse> codes = lookupsMapper.toCodingResponseList(codingRepository.findAll());
        return codes.stream()
                .map(c -> ensureCodeHasPrefix(c, c.getLevel()))
                .toList();
    }

    @Cacheable(value = "lookups-coding-by-level", key = "#level")
    public List<CodingResponse> getCodingByLevel(String level) {
        List<CodingResponse> codes = lookupsMapper.toCodingResponseList(
                codingRepository.findBySubLeveOrderBySubDesc(level));
        return codes.stream()
                .map(c -> ensureCodeHasPrefix(c, level))
                .toList();
    }

    /**
     * The documentation form's "appDoc"/"dataEntry" DataCombos (legacy m_mn_app_doc /
     * m_mn_data_en) are bound via a compound SUB_CODE of "01"+code / "02"+code
     * (see Form6.frm BoundText assignments) — a SUB_CODE prefix, not the single-char
     * SUB_LEVE column used by {@link #getCodingByLevel}.
     */
    @Cacheable(value = "lookups-coding-by-code-prefix", key = "#codePrefix")
    public List<CodingResponse> getCodingByCodePrefix(String codePrefix) {
        List<CodingResponse> codes = lookupsMapper.toCodingResponseList(
                codingRepository.findBySubCodeStartingWithOrderBySubDesc(codePrefix));
        return codes.stream()
                .map(c -> ensureCodeHasPrefix(c, codePrefix))
                .toList();
    }

    private CodingResponse ensureCodeHasPrefix(CodingResponse response, String expectedPrefix) {
        String code = response.getCode();
        if (code == null || code.isBlank()) {
            return response;
        }
        if (!code.startsWith(expectedPrefix)) {
            response.setCode(expectedPrefix + code);
        }
        return response;
    }

    @CacheEvict(value = "lookups-coding", allEntries = true)
    @Transactional
    public CodingResponse createCoding(CodingRequest request) {
        CodingEntity entity = new CodingEntity();
        entity.setSubLeve(request.level());
        entity.setSubCode(request.code());
        entity.setSubDesc(request.description());
        return lookupsMapper.toCodingResponse(codingRepository.save(entity));
    }

    @CacheEvict(value = "lookups-coding", allEntries = true)
    @Transactional
    public CodingResponse updateCoding(String level, String code, CodingRequest request) {
        CodingEntityId id = new CodingEntityId();
        id.setSubLeve(level);
        id.setSubCode(code);
        CodingEntity entity = codingRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException(
                        "Coding entry not found: level=" + level + ", code=" + code));
        entity.setSubDesc(request.description());
        return lookupsMapper.toCodingResponse(codingRepository.save(entity));
    }

    @CacheEvict(value = "lookups-coding", allEntries = true)
    @Transactional
    public void deleteCoding(String level, String code) {
        CodingEntityId id = new CodingEntityId();
        id.setSubLeve(level);
        id.setSubCode(code);
        if (!codingRepository.existsById(id)) {
            throw new ResourceNotFoundException(
                    "Coding entry not found: level=" + level + ", code=" + code);
        }
        codingRepository.deleteById(id);
    }
}
