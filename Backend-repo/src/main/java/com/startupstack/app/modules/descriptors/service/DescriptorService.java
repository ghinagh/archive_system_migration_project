package com.startupstack.app.modules.descriptors.service;

import com.startupstack.app.modules.catalogue.repository.CatalogueRepository;
import com.startupstack.app.modules.catalogue.repository.TimeDescriptorRepository;
import com.startupstack.app.modules.lookups.repository.CodingRepository;
import com.startupstack.app.modules.descriptors.dto.FileAddRequest;
import com.startupstack.app.modules.descriptors.dto.FileAddResponse;
import com.startupstack.app.modules.descriptors.dto.GeoRequest;
import com.startupstack.app.modules.descriptors.dto.GeoResponse;
import com.startupstack.app.modules.descriptors.dto.NarowerRequest;
import com.startupstack.app.modules.descriptors.dto.NarowerResponse;
import com.startupstack.app.modules.descriptors.dto.RelativeRequest;
import com.startupstack.app.modules.descriptors.dto.RelativeResponse;
import com.startupstack.app.modules.descriptors.dto.ResRequest;
import com.startupstack.app.modules.descriptors.dto.ResResponse;
import com.startupstack.app.modules.descriptors.dto.SubjectAnalysisRequest;
import com.startupstack.app.modules.descriptors.dto.SubjectAnalysisResponse;
import com.startupstack.app.modules.descriptors.dto.TextRequest;
import com.startupstack.app.modules.descriptors.dto.TextResponse;
import com.startupstack.app.modules.descriptors.entity.FileAddEntity;
import com.startupstack.app.modules.descriptors.entity.GeoEntity;
import com.startupstack.app.modules.descriptors.entity.NarowerEntity;
import com.startupstack.app.modules.descriptors.entity.RelativeEntity;
import com.startupstack.app.modules.descriptors.entity.ResEntity;
import com.startupstack.app.modules.descriptors.entity.SubjectAnalysisEntity;
import com.startupstack.app.modules.descriptors.entity.TextEntity;
import com.startupstack.app.modules.descriptors.mapper.DescriptorMapper;
import com.startupstack.app.modules.descriptors.repository.FileAddRepository;
import com.startupstack.app.modules.descriptors.repository.GeoRepository;
import com.startupstack.app.modules.descriptors.repository.NarowerRepository;
import com.startupstack.app.modules.descriptors.repository.RelativeRepository;
import com.startupstack.app.modules.descriptors.repository.ResRepository;
import com.startupstack.app.modules.descriptors.repository.SubjectAnalysisRepository;
import com.startupstack.app.modules.descriptors.repository.TextRepository;
import com.startupstack.app.shared.exception.BusinessException;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
public class DescriptorService {

    private final CatalogueRepository catalogueRepository;
    private final SubjectAnalysisRepository subjectRepository;
    private final GeoRepository geoRepository;
    private final FileAddRepository fileAddRepository;
    private final TextRepository textRepository;
    private final NarowerRepository narowerRepository;
    private final RelativeRepository relativeRepository;
    private final ResRepository resRepository;
    private final CodingRepository codingRepository;
    private final TimeDescriptorRepository timeDescriptorRepository;
    private final DescriptorMapper mapper;

    public DescriptorService(CatalogueRepository catalogueRepository,
                             SubjectAnalysisRepository subjectRepository,
                             GeoRepository geoRepository,
                             FileAddRepository fileAddRepository,
                             TextRepository textRepository,
                             NarowerRepository narowerRepository,
                             RelativeRepository relativeRepository,
                             ResRepository resRepository,
                             CodingRepository codingRepository,
                             TimeDescriptorRepository timeDescriptorRepository,
                             DescriptorMapper mapper) {
        this.catalogueRepository = catalogueRepository;
        this.subjectRepository = subjectRepository;
        this.geoRepository = geoRepository;
        this.fileAddRepository = fileAddRepository;
        this.textRepository = textRepository;
        this.narowerRepository = narowerRepository;
        this.relativeRepository = relativeRepository;
        this.resRepository = resRepository;
        this.codingRepository = codingRepository;
        this.timeDescriptorRepository = timeDescriptorRepository;
        this.mapper = mapper;
    }

    /**
     * Legacy Form6's Column01 ("نوع المسؤولية البيانية") shows a resolved CODING
     * description (DataField "typ_aut"), distinct from the raw 2-char RES_APP_TY
     * code (hidden Column03) — same "29"+code compound key DBList2 edits.
     */
    private String resolveResourceTypeDescription(String resourceType) {
        if (resourceType == null || resourceType.isBlank()) {
            return null;
        }
        return codingRepository.findFirstBySubCode("29" + resourceType)
                .map(c -> c.getSubDesc())
                .orElse(null);
    }

    private void validateCatalogue(String appNo) {
        if (!catalogueRepository.existsById(appNo)) {
            throw new ResourceNotFoundException("Catalogue record not found: " + appNo);
        }
    }

    /**
     * Form6.frm's is_trans(box_mn_trans) gates every add/delete/edit on the authors
     * grid ("لا تستطيع التعديل او الالغاء ....لان الوثيقة مقفلة") — MN_TRANS=1 means
     * locked. Enforced here rather than only client-side.
     */
    private void validateNotLocked(String appNo) {
        catalogueRepository.findById(appNo).ifPresent(c -> {
            if (c.getTrans() != null && c.getTrans() == 1) {
                throw new BusinessException("Catalogue record is locked: " + appNo);
            }
        });
    }

    @Transactional(readOnly = true)
    public List<SubjectAnalysisResponse> getSubjects(String appNo) {
        validateCatalogue(appNo);
        return mapper.toSubjectResponseList(subjectRepository.findByAppNo(appNo));
    }

    @Transactional
    public SubjectAnalysisResponse addSubject(String appNo, SubjectAnalysisRequest request) {
        validateCatalogue(appNo);
        SubjectAnalysisEntity entity = mapper.toSubjectEntity(request);
        entity.setAppNo(appNo);
        return mapper.toSubjectResponse(subjectRepository.save(entity));
    }

    /**
     * Form2.frm's DBList1_KeyUp(Delete) cascades del_analis with del_geo1/del_rel1/
     * del_nar1/del_fad1/del_time1 — every GEO/RELATIVE/NAROWER/FILE_ADD/TIME row for
     * this ANALIS row's serial is removed too, not just the descriptor itself.
     */
    @Transactional
    public void deleteSubject(String appNo, Integer id) {
        validateCatalogue(appNo);
        SubjectAnalysisEntity entity = subjectRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Subject analysis not found: " + id));
        if (!appNo.equals(entity.getAppNo())) {
            throw new ResourceNotFoundException("Subject analysis " + id + " does not belong to catalogue " + appNo);
        }
        String serialNo = entity.getSerialNo();
        subjectRepository.deleteById(id);
        geoRepository.deleteByAppNoAndSerialNo(appNo, serialNo);
        relativeRepository.deleteByAppNoAndSerialNo(appNo, serialNo);
        narowerRepository.deleteByAppNoAndSerialNo(appNo, serialNo);
        fileAddRepository.deleteByAppNoAndSerialNo(appNo, serialNo);
        timeDescriptorRepository.deleteByAppNoAndSerNo(appNo, serialNo);
    }

    @Transactional(readOnly = true)
    public List<GeoResponse> getGeoDescriptors(String appNo) {
        validateCatalogue(appNo);
        return mapper.toGeoResponseList(geoRepository.findByAppNo(appNo));
    }

    @Transactional
    public GeoResponse addGeoDescriptor(String appNo, GeoRequest request) {
        validateCatalogue(appNo);
        GeoEntity entity = mapper.toGeoEntity(request);
        entity.setAppNo(appNo);
        return mapper.toGeoResponse(geoRepository.save(entity));
    }

    @Transactional
    public void deleteGeoDescriptor(String appNo, Integer id) {
        validateCatalogue(appNo);
        GeoEntity entity = geoRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Geo descriptor not found: " + id));
        if (!appNo.equals(entity.getAppNo())) {
            throw new ResourceNotFoundException("Geo descriptor " + id + " does not belong to catalogue " + appNo);
        }
        geoRepository.deleteById(id);
    }

    @Transactional(readOnly = true)
    public List<FileAddResponse> getFiles(String appNo) {
        validateCatalogue(appNo);
        return mapper.toFileResponseList(fileAddRepository.findByAppNo(appNo));
    }

    @Transactional
    public FileAddResponse addFile(String appNo, FileAddRequest request) {
        validateCatalogue(appNo);
        FileAddEntity entity = mapper.toFileEntity(request);
        entity.setAppNo(appNo);
        return mapper.toFileResponse(fileAddRepository.save(entity));
    }

    @Transactional
    public void deleteFile(String appNo, UUID id) {
        validateCatalogue(appNo);
        FileAddEntity entity = fileAddRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("File relation not found: " + id));
        if (!appNo.equals(entity.getAppNo())) {
            throw new ResourceNotFoundException("File relation " + id + " does not belong to catalogue " + appNo);
        }
        fileAddRepository.deleteById(id);
    }

    @Transactional(readOnly = true)
    public List<TextResponse> getTexts(String appNo) {
        validateCatalogue(appNo);
        return mapper.toTextResponseList(textRepository.findByAppNo(appNo));
    }

    @Transactional
    public TextResponse addText(String appNo, TextRequest request) {
        validateCatalogue(appNo);
        TextEntity entity = mapper.toTextEntity(request);
        entity.setAppNo(appNo);
        return mapper.toTextResponse(textRepository.save(entity));
    }

    @Transactional(readOnly = true)
    public List<NarowerResponse> getNarrowerTerms(String appNo) {
        validateCatalogue(appNo);
        return mapper.toNarowerResponseList(narowerRepository.findByAppNo(appNo));
    }

    @Transactional
    public NarowerResponse addNarrowerTerm(String appNo, NarowerRequest request) {
        validateCatalogue(appNo);
        NarowerEntity entity = mapper.toNarowerEntity(request);
        entity.setAppNo(appNo);
        return mapper.toNarowerResponse(narowerRepository.save(entity));
    }

    @Transactional
    public void deleteNarrowerTerm(String appNo, Integer id) {
        validateCatalogue(appNo);
        NarowerEntity entity = narowerRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Narrower term not found: " + id));
        if (!appNo.equals(entity.getAppNo())) {
            throw new ResourceNotFoundException("Narrower term " + id + " does not belong to catalogue " + appNo);
        }
        narowerRepository.deleteById(id);
    }

    @Transactional(readOnly = true)
    public List<RelativeResponse> getRelatedTerms(String appNo) {
        validateCatalogue(appNo);
        return mapper.toRelativeResponseList(relativeRepository.findByAppNo(appNo));
    }

    @Transactional
    public RelativeResponse addRelatedTerm(String appNo, RelativeRequest request) {
        validateCatalogue(appNo);
        RelativeEntity entity = mapper.toRelativeEntity(request);
        entity.setAppNo(appNo);
        return mapper.toRelativeResponse(relativeRepository.save(entity));
    }

    @Transactional
    public void deleteRelatedTerm(String appNo, Integer id) {
        validateCatalogue(appNo);
        RelativeEntity entity = relativeRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Related term not found: " + id));
        if (!appNo.equals(entity.getAppNo())) {
            throw new ResourceNotFoundException("Related term " + id + " does not belong to catalogue " + appNo);
        }
        relativeRepository.deleteById(id);
    }

    @Transactional(readOnly = true)
    public List<ResResponse> getLinkedAuthors(String appNo) {
        validateCatalogue(appNo);
        List<ResResponse> responses = mapper.toResResponseList(resRepository.findByAppNo(appNo));
        responses.forEach(r -> r.setResourceTypeDescription(resolveResourceTypeDescription(r.getResourceType())));
        return responses;
    }

    @Transactional
    public ResResponse addLinkedAuthor(String appNo, ResRequest request) {
        validateCatalogue(appNo);
        validateNotLocked(appNo);
        ResEntity entity = mapper.toResEntity(request);
        entity.setAppNo(appNo);
        ResResponse response = mapper.toResResponse(resRepository.save(entity));
        response.setResourceTypeDescription(resolveResourceTypeDescription(response.getResourceType()));
        return response;
    }

    /**
     * Legacy has no dedicated "edit" button — DBList1/DBList2's SPACE+ENTER on an
     * existing DataGrid2 row calls upd_res/upd_res1 to correct just the author or
     * resource type in place, without deleting the row. This is the equivalent.
     */
    @Transactional
    public ResResponse updateLinkedAuthor(String appNo, Integer id, ResRequest request) {
        validateCatalogue(appNo);
        validateNotLocked(appNo);
        ResEntity entity = resRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Author link not found: " + id));
        if (!appNo.equals(entity.getAppNo())) {
            throw new ResourceNotFoundException("Author link " + id + " does not belong to catalogue " + appNo);
        }
        mapper.updateResEntity(request, entity);
        ResResponse response = mapper.toResResponse(resRepository.save(entity));
        response.setResourceTypeDescription(resolveResourceTypeDescription(response.getResourceType()));
        return response;
    }

    @Transactional
    public void removeLinkedAuthor(String appNo, Integer id) {
        validateCatalogue(appNo);
        validateNotLocked(appNo);
        ResEntity entity = resRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Author link not found: " + id));
        if (!appNo.equals(entity.getAppNo())) {
            throw new ResourceNotFoundException("Author link " + id + " does not belong to catalogue " + appNo);
        }
        resRepository.deleteById(id);
    }
}
