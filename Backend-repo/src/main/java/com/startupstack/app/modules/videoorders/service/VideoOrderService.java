package com.startupstack.app.modules.videoorders.service;

import com.startupstack.app.modules.archive.entity.ChartEntity;
import com.startupstack.app.modules.archive.repository.ChartRepository;
import com.startupstack.app.modules.videoorders.dto.VideoOrderRequest;
import com.startupstack.app.modules.videoorders.dto.VideoOrderResponse;
import com.startupstack.app.modules.videoorders.entity.VideoOrderEntity;
import com.startupstack.app.modules.videoorders.mapper.VideoOrderMapper;
import com.startupstack.app.modules.videoorders.repository.VideoOrderRepository;
import com.startupstack.app.modules.videoorders.specification.VideoOrderSpecification;
import com.startupstack.app.shared.exception.BusinessException;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import com.startupstack.app.shared.media.MediaService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Service
public class VideoOrderService {

    private static final String DEFAULT_STATUS = "PENDING";

    private final VideoOrderRepository videoOrderRepository;
    private final ChartRepository chartRepository;
    private final VideoOrderMapper videoOrderMapper;
    private final MediaService mediaService;

    public VideoOrderService(VideoOrderRepository videoOrderRepository,
                              ChartRepository chartRepository,
                              VideoOrderMapper videoOrderMapper,
                              MediaService mediaService) {
        this.videoOrderRepository = videoOrderRepository;
        this.chartRepository = chartRepository;
        this.videoOrderMapper = videoOrderMapper;
        this.mediaService = mediaService;
    }

    @Transactional(readOnly = true)
    public Page<VideoOrderResponse> findAll(String status, String stockNo, Pageable pageable) {
        Specification<VideoOrderEntity> spec = VideoOrderSpecification.hasStatus(status)
                .and(VideoOrderSpecification.stockNoEquals(stockNo));
        return videoOrderRepository.findAll(spec, pageable).map(this::toResponseWithMedia);
    }

    @Transactional(readOnly = true)
    public VideoOrderResponse findById(UUID id) {
        VideoOrderEntity entity = getOrThrow(id);
        return toResponseWithMedia(entity);
    }

    @Transactional
    public VideoOrderResponse create(VideoOrderRequest request) {
        if (videoOrderRepository.existsByOrderNo(request.getOrderNo())) {
            throw new BusinessException("Video order already exists: " + request.getOrderNo());
        }

        VideoOrderEntity entity = videoOrderMapper.toEntity(request);
        if (entity.getStatus() == null) {
            entity.setStatus(DEFAULT_STATUS);
        }
        applyChart(entity, request.getChartId());

        return toResponseWithMedia(videoOrderRepository.save(entity));
    }

    @Transactional
    public VideoOrderResponse update(UUID id, VideoOrderRequest request) {
        VideoOrderEntity entity = getOrThrow(id);

        if (!entity.getOrderNo().equals(request.getOrderNo())
                && videoOrderRepository.existsByOrderNo(request.getOrderNo())) {
            throw new BusinessException("Video order already exists: " + request.getOrderNo());
        }

        videoOrderMapper.updateEntity(request, entity);
        applyChart(entity, request.getChartId());

        return toResponseWithMedia(videoOrderRepository.save(entity));
    }

    @Transactional
    public void delete(UUID id) {
        if (!videoOrderRepository.existsById(id)) {
            throw new ResourceNotFoundException("Video order not found: " + id);
        }
        videoOrderRepository.deleteById(id);
    }

    @Transactional
    public VideoOrderResponse updateStatus(UUID id, String newStatus) {
        VideoOrderEntity entity = getOrThrow(id);
        entity.setStatus(newStatus);
        return toResponseWithMedia(videoOrderRepository.save(entity));
    }

    private VideoOrderEntity getOrThrow(UUID id) {
        return videoOrderRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Video order not found: " + id));
    }

    private void applyChart(VideoOrderEntity entity, Integer chartId) {
        if (chartId == null) {
            entity.setChart(null);
            return;
        }
        ChartEntity chart = chartRepository.findById(chartId)
                .orElseThrow(() -> new ResourceNotFoundException("Chart not found: " + chartId));
        entity.setChart(chart);
    }

    private VideoOrderResponse toResponseWithMedia(VideoOrderEntity entity) {
        VideoOrderResponse response = videoOrderMapper.toResponse(entity);
        response.setMediaAvailable(mediaService.fileExists(entity.getStockNo()));
        return response;
    }
}
