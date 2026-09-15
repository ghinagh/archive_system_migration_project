package com.startupstack.app.modules.descriptors.service;

import com.startupstack.app.modules.catalogue.repository.CatalogueRepository;
import com.startupstack.app.modules.descriptors.dto.*;
import com.startupstack.app.modules.descriptors.entity.*;
import com.startupstack.app.modules.descriptors.mapper.DescriptorMapper;
import com.startupstack.app.modules.descriptors.repository.*;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class DescriptorServiceTest {

    private static final String APP_NO = "MN000001";

    @Mock
    private CatalogueRepository catalogueRepository;
    @Mock
    private SubjectAnalysisRepository subjectRepository;
    @Mock
    private GeoRepository geoRepository;
    @Mock
    private FileAddRepository fileAddRepository;
    @Mock
    private TextRepository textRepository;
    @Mock
    private NarowerRepository narowerRepository;
    @Mock
    private RelativeRepository relativeRepository;
    @Mock
    private ResRepository resRepository;
    @Mock
    private DescriptorMapper mapper;
    @InjectMocks
    private DescriptorService descriptorService;

    @BeforeEach
    void setUp() {
        lenient().when(catalogueRepository.existsById(APP_NO)).thenReturn(true);
    }

    // --- shared catalogue validation ---

    @Test
    void getSubjects_catalogueMissing_throwsResourceNotFound() {
        when(catalogueRepository.existsById("MISSING")).thenReturn(false);

        assertThrows(ResourceNotFoundException.class, () -> descriptorService.getSubjects("MISSING"));
        verifyNoInteractions(subjectRepository);
    }

    @Test
    void addGeoDescriptor_catalogueMissing_throwsResourceNotFound() {
        when(catalogueRepository.existsById("MISSING")).thenReturn(false);

        assertThrows(ResourceNotFoundException.class,
                () -> descriptorService.addGeoDescriptor("MISSING", new GeoRequest()));
        verifyNoInteractions(geoRepository);
    }

    // --- subject analysis ---

    @Test
    void getSubjects_returnsMappedList() {
        SubjectAnalysisEntity entity = new SubjectAnalysisEntity();
        entity.setAppNo(APP_NO);
        when(subjectRepository.findByAppNo(APP_NO)).thenReturn(List.of(entity));
        when(mapper.toSubjectResponseList(List.of(entity))).thenReturn(List.of(new SubjectAnalysisResponse()));

        List<SubjectAnalysisResponse> result = descriptorService.getSubjects(APP_NO);

        assertEquals(1, result.size());
    }

    @Test
    void addSubject_setsAppNoAndSaves() {
        SubjectAnalysisRequest request = new SubjectAnalysisRequest();
        SubjectAnalysisEntity mapped = new SubjectAnalysisEntity();
        when(mapper.toSubjectEntity(request)).thenReturn(mapped);
        when(subjectRepository.save(mapped)).thenReturn(mapped);
        when(mapper.toSubjectResponse(mapped)).thenReturn(new SubjectAnalysisResponse());

        descriptorService.addSubject(APP_NO, request);

        assertEquals(APP_NO, mapped.getAppNo());
        verify(subjectRepository).save(mapped);
    }

    @Test
    void deleteSubject_existingAndOwned_deletes() {
        SubjectAnalysisEntity entity = new SubjectAnalysisEntity();
        entity.setAppNo(APP_NO);
        when(subjectRepository.findById(5)).thenReturn(Optional.of(entity));

        descriptorService.deleteSubject(APP_NO, 5);

        verify(subjectRepository).deleteById(5);
    }

    @Test
    void deleteSubject_notFound_throwsResourceNotFound() {
        when(subjectRepository.findById(999)).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> descriptorService.deleteSubject(APP_NO, 999));
    }

    @Test
    void deleteSubject_belongsToDifferentCatalogue_throwsResourceNotFound() {
        SubjectAnalysisEntity entity = new SubjectAnalysisEntity();
        entity.setAppNo("MN999999");
        when(subjectRepository.findById(5)).thenReturn(Optional.of(entity));

        assertThrows(ResourceNotFoundException.class, () -> descriptorService.deleteSubject(APP_NO, 5));
        verify(subjectRepository, never()).deleteById(any());
    }

    // --- geo descriptors ---

    @Test
    void getGeoDescriptors_returnsMappedList() {
        GeoEntity entity = new GeoEntity();
        when(geoRepository.findByAppNo(APP_NO)).thenReturn(List.of(entity));
        when(mapper.toGeoResponseList(List.of(entity))).thenReturn(List.of(new GeoResponse()));

        assertEquals(1, descriptorService.getGeoDescriptors(APP_NO).size());
    }

    @Test
    void addGeoDescriptor_setsAppNoAndSaves() {
        GeoRequest request = new GeoRequest();
        GeoEntity mapped = new GeoEntity();
        when(mapper.toGeoEntity(request)).thenReturn(mapped);
        when(geoRepository.save(mapped)).thenReturn(mapped);
        when(mapper.toGeoResponse(mapped)).thenReturn(new GeoResponse());

        descriptorService.addGeoDescriptor(APP_NO, request);

        assertEquals(APP_NO, mapped.getAppNo());
    }

    @Test
    void deleteGeoDescriptor_belongsToDifferentCatalogue_throwsResourceNotFound() {
        GeoEntity entity = new GeoEntity();
        entity.setAppNo("MN999999");
        when(geoRepository.findById(5)).thenReturn(Optional.of(entity));

        assertThrows(ResourceNotFoundException.class, () -> descriptorService.deleteGeoDescriptor(APP_NO, 5));
        verify(geoRepository, never()).deleteById(any());
    }

    @Test
    void deleteGeoDescriptor_existingAndOwned_deletes() {
        GeoEntity entity = new GeoEntity();
        entity.setAppNo(APP_NO);
        when(geoRepository.findById(5)).thenReturn(Optional.of(entity));

        descriptorService.deleteGeoDescriptor(APP_NO, 5);

        verify(geoRepository).deleteById(5);
    }

    // --- files ---

    @Test
    void getFiles_returnsMappedList() {
        FileAddEntity entity = new FileAddEntity();
        when(fileAddRepository.findByAppNo(APP_NO)).thenReturn(List.of(entity));
        when(mapper.toFileResponseList(List.of(entity))).thenReturn(List.of(new FileAddResponse()));

        assertEquals(1, descriptorService.getFiles(APP_NO).size());
    }

    @Test
    void addFile_setsAppNoAndSaves() {
        FileAddRequest request = new FileAddRequest();
        FileAddEntity mapped = new FileAddEntity();
        when(mapper.toFileEntity(request)).thenReturn(mapped);
        when(fileAddRepository.save(mapped)).thenReturn(mapped);
        when(mapper.toFileResponse(mapped)).thenReturn(new FileAddResponse());

        descriptorService.addFile(APP_NO, request);

        assertEquals(APP_NO, mapped.getAppNo());
    }

    // --- text ---

    @Test
    void getTexts_returnsMappedList() {
        TextEntity entity = new TextEntity();
        when(textRepository.findByAppNo(APP_NO)).thenReturn(List.of(entity));
        when(mapper.toTextResponseList(List.of(entity))).thenReturn(List.of(new TextResponse()));

        assertEquals(1, descriptorService.getTexts(APP_NO).size());
    }

    @Test
    void addText_setsAppNoAndSaves() {
        TextRequest request = new TextRequest();
        TextEntity mapped = new TextEntity();
        when(mapper.toTextEntity(request)).thenReturn(mapped);
        when(textRepository.save(mapped)).thenReturn(mapped);
        when(mapper.toTextResponse(mapped)).thenReturn(new TextResponse());

        descriptorService.addText(APP_NO, request);

        assertEquals(APP_NO, mapped.getAppNo());
    }

    // --- narrower terms ---

    @Test
    void getNarrowerTerms_returnsMappedList() {
        NarowerEntity entity = new NarowerEntity();
        when(narowerRepository.findByAppNo(APP_NO)).thenReturn(List.of(entity));
        when(mapper.toNarowerResponseList(List.of(entity))).thenReturn(List.of(new NarowerResponse()));

        assertEquals(1, descriptorService.getNarrowerTerms(APP_NO).size());
    }

    @Test
    void addNarrowerTerm_setsAppNoAndSaves() {
        NarowerRequest request = new NarowerRequest();
        NarowerEntity mapped = new NarowerEntity();
        when(mapper.toNarowerEntity(request)).thenReturn(mapped);
        when(narowerRepository.save(mapped)).thenReturn(mapped);
        when(mapper.toNarowerResponse(mapped)).thenReturn(new NarowerResponse());

        descriptorService.addNarrowerTerm(APP_NO, request);

        assertEquals(APP_NO, mapped.getAppNo());
    }

    @Test
    void deleteNarrowerTerm_belongsToDifferentCatalogue_throwsResourceNotFound() {
        NarowerEntity entity = new NarowerEntity();
        entity.setAppNo("MN999999");
        when(narowerRepository.findById(5)).thenReturn(Optional.of(entity));

        assertThrows(ResourceNotFoundException.class, () -> descriptorService.deleteNarrowerTerm(APP_NO, 5));
        verify(narowerRepository, never()).deleteById(any());
    }

    @Test
    void deleteNarrowerTerm_existingAndOwned_deletes() {
        NarowerEntity entity = new NarowerEntity();
        entity.setAppNo(APP_NO);
        when(narowerRepository.findById(5)).thenReturn(Optional.of(entity));

        descriptorService.deleteNarrowerTerm(APP_NO, 5);

        verify(narowerRepository).deleteById(5);
    }

    // --- related terms ---

    @Test
    void getRelatedTerms_returnsMappedList() {
        RelativeEntity entity = new RelativeEntity();
        when(relativeRepository.findByAppNo(APP_NO)).thenReturn(List.of(entity));
        when(mapper.toRelativeResponseList(List.of(entity))).thenReturn(List.of(new RelativeResponse()));

        assertEquals(1, descriptorService.getRelatedTerms(APP_NO).size());
    }

    @Test
    void addRelatedTerm_setsAppNoAndSaves() {
        RelativeRequest request = new RelativeRequest();
        RelativeEntity mapped = new RelativeEntity();
        when(mapper.toRelativeEntity(request)).thenReturn(mapped);
        when(relativeRepository.save(mapped)).thenReturn(mapped);
        when(mapper.toRelativeResponse(mapped)).thenReturn(new RelativeResponse());

        descriptorService.addRelatedTerm(APP_NO, request);

        assertEquals(APP_NO, mapped.getAppNo());
    }

    @Test
    void deleteRelatedTerm_belongsToDifferentCatalogue_throwsResourceNotFound() {
        RelativeEntity entity = new RelativeEntity();
        entity.setAppNo("MN999999");
        when(relativeRepository.findById(5)).thenReturn(Optional.of(entity));

        assertThrows(ResourceNotFoundException.class, () -> descriptorService.deleteRelatedTerm(APP_NO, 5));
        verify(relativeRepository, never()).deleteById(any());
    }

    @Test
    void deleteRelatedTerm_existingAndOwned_deletes() {
        RelativeEntity entity = new RelativeEntity();
        entity.setAppNo(APP_NO);
        when(relativeRepository.findById(5)).thenReturn(Optional.of(entity));

        descriptorService.deleteRelatedTerm(APP_NO, 5);

        verify(relativeRepository).deleteById(5);
    }

    // --- linked authors ---

    @Test
    void getLinkedAuthors_returnsMappedList() {
        ResEntity entity = new ResEntity();
        when(resRepository.findByAppNo(APP_NO)).thenReturn(List.of(entity));
        when(mapper.toResResponseList(List.of(entity))).thenReturn(List.of(new ResResponse()));

        assertEquals(1, descriptorService.getLinkedAuthors(APP_NO).size());
    }

    @Test
    void addLinkedAuthor_setsAppNoAndSaves() {
        ResRequest request = new ResRequest();
        ResEntity mapped = new ResEntity();
        when(mapper.toResEntity(request)).thenReturn(mapped);
        when(resRepository.save(mapped)).thenReturn(mapped);
        when(mapper.toResResponse(mapped)).thenReturn(new ResResponse());

        descriptorService.addLinkedAuthor(APP_NO, request);

        assertEquals(APP_NO, mapped.getAppNo());
    }

    @Test
    void removeLinkedAuthor_belongsToDifferentCatalogue_throwsResourceNotFound() {
        ResEntity entity = new ResEntity();
        entity.setAppNo("MN999999");
        when(resRepository.findById(5)).thenReturn(Optional.of(entity));

        assertThrows(ResourceNotFoundException.class, () -> descriptorService.removeLinkedAuthor(APP_NO, 5));
        verify(resRepository, never()).deleteById(any());
    }

    @Test
    void removeLinkedAuthor_notFound_throwsResourceNotFound() {
        when(resRepository.findById(999)).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> descriptorService.removeLinkedAuthor(APP_NO, 999));
    }

    @Test
    void removeLinkedAuthor_existingAndOwned_deletes() {
        ResEntity entity = new ResEntity();
        entity.setAppNo(APP_NO);
        when(resRepository.findById(5)).thenReturn(Optional.of(entity));

        descriptorService.removeLinkedAuthor(APP_NO, 5);

        verify(resRepository).deleteById(5);
    }
}
