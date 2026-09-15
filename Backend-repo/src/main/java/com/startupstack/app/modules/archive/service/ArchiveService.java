package com.startupstack.app.modules.archive.service;

import com.startupstack.app.modules.archive.dto.BatchChartRequest;
import com.startupstack.app.modules.archive.dto.ChartOperationRequest;
import com.startupstack.app.modules.archive.dto.ChartOperationResponse;
import com.startupstack.app.modules.archive.dto.ChartRequest;
import com.startupstack.app.modules.archive.dto.ChartResponse;
import com.startupstack.app.modules.archive.entity.ChartEntity;
import com.startupstack.app.modules.archive.entity.ChartOperationEntity;
import com.startupstack.app.modules.archive.mapper.ChartMapper;
import com.startupstack.app.modules.archive.mapper.ChartOperationMapper;
import com.startupstack.app.modules.archive.repository.ChartOperationRepository;
import com.startupstack.app.modules.archive.repository.ChartRepository;
import com.startupstack.app.modules.archive.specification.ChartSpecification;
import com.startupstack.app.shared.exception.BusinessException;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import com.startupstack.app.shared.util.SecurityUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
public class ArchiveService {

    private final ChartRepository chartRepository;
    private final ChartOperationRepository operationRepository;
    private final ChartMapper chartMapper;
    private final ChartOperationMapper operationMapper;

    public ArchiveService(ChartRepository chartRepository,
                          ChartOperationRepository operationRepository,
                          ChartMapper chartMapper,
                          ChartOperationMapper operationMapper) {
        this.chartRepository = chartRepository;
        this.operationRepository = operationRepository;
        this.chartMapper = chartMapper;
        this.operationMapper = operationMapper;
    }

    @Transactional(readOnly = true)
    public Page<ChartResponse> findAllCharts(String title, String source, Double type,
                                             String subjectCode, Pageable pageable) {
        String userEnt = SecurityUtils.isAdmin() ? null : SecurityUtils.getCurrentUserEnt();
        Specification<ChartEntity> spec = ChartSpecification.belongsToUserEntity(userEnt)
                .and(ChartSpecification.titleContains(title))
                .and(ChartSpecification.hasSource(source))
                .and(ChartSpecification.hasType(type))
                .and(ChartSpecification.hasSubjectCode(subjectCode));
        return chartRepository.findAll(spec, pageable).map(chartMapper::toResponse);
    }

    @Transactional(readOnly = true)
    public ChartResponse findChartById(Integer id) {
        ChartEntity entity = chartRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Chart not found: " + id));
        return chartMapper.toResponse(entity);
    }

    @Transactional
    public ChartResponse createChart(ChartRequest request) {
        validateStockUniquenessForCreate(request.getStock());

        ChartEntity entity = chartMapper.toEntity(request);
        entity.setChaNo(generateNextChaNo());
        ChartEntity saved = chartRepository.save(entity);

        if (request.getStock() != null) {
            ChartOperationEntity bootstrap = new ChartOperationEntity();
            bootstrap.setChart(saved);
            bootstrap.setSerial(operationRepository.findMaxSerialByChaNo(saved.getChaNo()) + 1);
            bootstrap.setDate(LocalDateTime.now());
            bootstrap.setFromSite(request.getFromSite());
            bootstrap.setToSite(request.getToSite());
            bootstrap.setFromPerson(request.getFromPerson());
            bootstrap.setToPerson(request.getToPerson());
            bootstrap.setTitle(request.getTitle());
            bootstrap.setTransferred(false);
            ChartOperationEntity savedOp = operationRepository.save(bootstrap);
            applyCascadeToChart(saved, savedOp);
        }

        return chartMapper.toResponse(saved);
    }

    @Transactional
    public ChartResponse updateChart(Integer id, ChartRequest request) {
        ChartEntity entity = chartRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Chart not found: " + id));

        validateStockUniquenessForUpdate(request.getStock(), id);

        chartMapper.updateEntity(request, entity);
        return chartMapper.toResponse(chartRepository.save(entity));
    }

    @Transactional
    public void deleteChart(Integer id) {
        if (!chartRepository.existsById(id)) {
            throw new ResourceNotFoundException("Chart not found: " + id);
        }
        chartRepository.deleteById(id);
    }

    @Transactional
    public List<String> createBatch(BatchChartRequest request) {
        validateStockUniquenessForCreate(request.getCharitTemplate().getStock());

        List<String> createdNumbers = new ArrayList<>();

        for (int i = 0; i < request.getQuantity(); i++) {
            int seq = request.getStartSequence() + i;

            ChartEntity entity = chartMapper.toEntity(request.getCharitTemplate());
            String chaNo = generateNextChaNo();
            entity.setChaNo(chaNo);
            entity.setTitle(request.getBaseTitle() + " - " + seq);

            chartRepository.save(entity);
            createdNumbers.add(chaNo);
        }

        return createdNumbers;
    }

    @Transactional(readOnly = true)
    public Page<ChartOperationResponse> findOperationsByChart(Integer chartId, Pageable pageable) {
        ChartEntity chart = chartRepository.findById(chartId)
                .orElseThrow(() -> new ResourceNotFoundException("Chart not found: " + chartId));
        return operationRepository.findByChart_ChaNo(chart.getChaNo(), pageable)
                .map(operationMapper::toResponse);
    }

    @Transactional(readOnly = true)
    public ChartOperationResponse findOperationById(Integer chartId, Integer operationId) {
        chartRepository.findById(chartId)
                .orElseThrow(() -> new ResourceNotFoundException("Chart not found: " + chartId));
        ChartOperationEntity operation = operationRepository.findById(operationId)
                .orElseThrow(() -> new ResourceNotFoundException("Operation not found: " + operationId));
        return operationMapper.toResponse(operation);
    }

    @Transactional
    public ChartOperationResponse createOperation(Integer chartId, ChartOperationRequest request) {
        ChartEntity chart = chartRepository.findById(chartId)
                .orElseThrow(() -> new ResourceNotFoundException("Chart not found: " + chartId));

        ChartOperationEntity operation = operationMapper.toEntity(request);
        operation.setChart(chart);

        double maxSerial = operationRepository.findMaxSerialByChaNo(chart.getChaNo());
        operation.setSerial(maxSerial + 1);

        ChartOperationEntity saved = operationRepository.save(operation);
        applyCascadeToChart(chart, saved);

        return operationMapper.toResponse(saved);
    }

    @Transactional
    public ChartOperationResponse updateOperation(Integer chartId, Integer operationId,
                                                  ChartOperationRequest request) {
        ChartEntity chart = chartRepository.findById(chartId)
                .orElseThrow(() -> new ResourceNotFoundException("Chart not found: " + chartId));
        ChartOperationEntity operation = operationRepository.findById(operationId)
                .orElseThrow(() -> new ResourceNotFoundException("Operation not found: " + operationId));
        operationMapper.updateEntity(request, operation);
        ChartOperationEntity saved = operationRepository.save(operation);
        applyCascadeToChart(chart, saved);

        return operationMapper.toResponse(saved);
    }

    @Transactional
    public void deleteOperation(Integer chartId, Integer operationId) {
        ChartEntity chart = chartRepository.findById(chartId)
                .orElseThrow(() -> new ResourceNotFoundException("Chart not found: " + chartId));
        ChartOperationEntity operation = operationRepository.findById(operationId)
                .orElseThrow(() -> new ResourceNotFoundException("Operation not found: " + operationId));

        Double deletedSerial = operation.getSerial();
        String chaNo = chart.getChaNo();

        operationRepository.delete(operation);
        operationRepository.flush();

        operationRepository.findFirstByChart_ChaNoAndSerialLessThanOrderBySerialDesc(chaNo, deletedSerial)
                .ifPresentOrElse(
                        previous -> {
                            chart.setFromSite(previous.getFromSite());
                            chart.setToSite(previous.getToSite());
                            chart.setFromPerson(previous.getFromPerson());
                            chart.setToPerson(previous.getToPerson());
                        },
                        () -> {
                            chart.setFromSite(null);
                            chart.setToSite(null);
                            chart.setFromPerson(null);
                            chart.setToPerson(null);
                        }
                );
        chartRepository.save(chart);
    }

    private void applyCascadeToChart(ChartEntity chart, ChartOperationEntity operation) {
        chart.setFromSite(operation.getFromSite());
        chart.setToSite(operation.getToSite());
        chart.setFromPerson(operation.getFromPerson());
        chart.setToPerson(operation.getToPerson());
        chartRepository.save(chart);
    }

    // --- The SELECT ... FOR UPDATE in the native query prevents concurrent reads
    // from obtaining the same max value.
    private String generateNextChaNo() {
        int maxNo = chartRepository.findMaxChaNoAsInteger();
        int nextNo = maxNo + 1;
        return String.format("%06d", nextNo);
    }

    private void validateStockUniquenessForCreate(Double stock) {
        if (stock != null && chartRepository.existsByStock(stock)) {
            throw new BusinessException("Stock number " + stock + " is already assigned to another chart");
        }
    }

    private void validateStockUniquenessForUpdate(Double stock, Integer excludeId) {
        if (stock != null && chartRepository.existsByStockAndIdNot(stock, excludeId)) {
            throw new BusinessException("Stock number " + stock + " is already assigned to another chart");
        }
    }
}
