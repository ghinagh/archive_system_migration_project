package com.startupstack.app.modules.sites.service;

import com.startupstack.app.modules.sites.dto.SiteRequest;
import com.startupstack.app.modules.sites.dto.SiteResponse;
import com.startupstack.app.modules.sites.dto.SiteWithFormView;
import com.startupstack.app.modules.sites.dto.SiteWithNameView;
import com.startupstack.app.modules.sites.entity.SiteEntity;
import com.startupstack.app.modules.sites.mapper.SiteMapper;
import com.startupstack.app.modules.sites.repository.SiteRepository;
import com.startupstack.app.modules.sites.specification.SitesSpecification;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import com.startupstack.app.shared.util.SecurityUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class SiteService {

    private final SiteRepository siteRepository;
    private final SiteMapper siteMapper;

    public SiteService(SiteRepository siteRepository, SiteMapper siteMapper) {
        this.siteRepository = siteRepository;
        this.siteMapper = siteMapper;
    }

    @Transactional(readOnly = true)
    public Page<SiteResponse> findAll(String level, String status, Integer wilyaNo,
                                      Boolean includeNames, Boolean includeFormInfo,
                                      Pageable pageable) {
        boolean isAdmin    = SecurityUtils.isAdmin();
        Integer userWilaya = SecurityUtils.getCurrentUserWilaya(); // null for admins

        // For native-query paths the repository accepts a single wilaya parameter.
        // If the JWT restricts the user to a specific wilaya that value takes precedence
        // over the client-supplied wilyaNo; the client param is secondary.
        Integer effectiveWilaya = userWilaya != null ? userWilaya : wilyaNo;

        if (Boolean.TRUE.equals(includeFormInfo)) {
            return siteRepository.findAllWithFormInfo(level, status, effectiveWilaya, pageable)
                    .map(this::mapFormViewToResponse);
        }
        if (Boolean.TRUE.equals(includeNames)) {
            return siteRepository.findAllWithNames(level, status, effectiveWilaya, pageable)
                    .map(this::mapNameViewToResponse);
        }
        String userEnt = isAdmin ? null : SecurityUtils.getCurrentUserEnt();
        Specification<SiteEntity> spec = SitesSpecification.siteBelongsToUserEntity(userEnt)
                .and(SitesSpecification.siteHasWilya(userWilaya))   // JWT-enforced restriction
                .and(SitesSpecification.siteHasLevel(level))
                .and(SitesSpecification.siteHasStatus(status))
                .and(SitesSpecification.siteHasWilya(wilyaNo));      // client-requested filter
        return siteRepository.findAll(spec, pageable).map(siteMapper::toResponse);
    }

    private SiteResponse mapNameViewToResponse(SiteWithNameView v) {
        SiteResponse r = new SiteResponse();
        r.setSiteNo(v.getSiteNo());
        r.setDescription(v.getDescription());
        r.setLevelNo(v.getLevelNo());
        r.setLevel(v.getLevel());
        r.setProcess(v.getProcess());
        r.setDocNo(v.getDocNo());
        r.setStartDate(v.getStartDate());
        r.setEndDate(v.getEndDate());
        r.setFree(v.getFree());
        r.setType(v.getType());
        r.setWilyaNo(v.getWilyaNo());
        r.setStatus(v.getStatus());
        r.setUser(v.getUser());
        r.setPermission(v.getPermission());
        r.setAccessLevel(v.getAccessLevel());
        r.setKind(v.getKind());
        r.setFormName(v.getFormName());
        return r;
    }

    private SiteResponse mapFormViewToResponse(SiteWithFormView v) {
        SiteResponse r = mapNameViewToResponse(v);
        r.setFormType(v.getFormType());
        r.setFormPrintName(v.getFormPrintName());
        return r;
    }

    @Transactional(readOnly = true)
    public SiteResponse findById(String siteNo) {
        SiteEntity entity = siteRepository.findById(siteNo)
                .orElseThrow(() -> new ResourceNotFoundException("Site not found: " + siteNo));
        return siteMapper.toResponse(entity);
    }

    @Transactional
    public SiteResponse create(SiteRequest request) {
        SiteEntity entity = siteMapper.toEntity(request);
        return siteMapper.toResponse(siteRepository.save(entity));
    }

    @Transactional
    public SiteResponse update(String siteNo, SiteRequest request) {
        SiteEntity entity = siteRepository.findById(siteNo)
                .orElseThrow(() -> new ResourceNotFoundException("Site not found: " + siteNo));
        siteMapper.updateEntity(request, entity);
        return siteMapper.toResponse(siteRepository.save(entity));
    }

    @Transactional
    public void delete(String siteNo) {
        if (!siteRepository.existsById(siteNo)) {
            throw new ResourceNotFoundException("Site not found: " + siteNo);
        }
        siteRepository.deleteById(siteNo);
    }
}
