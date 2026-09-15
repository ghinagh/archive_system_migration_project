package com.startupstack.app.modules.sites.service;

import com.startupstack.app.modules.sites.dto.PostRequest;
import com.startupstack.app.modules.sites.dto.PostResponse;
import com.startupstack.app.modules.sites.dto.PostWithSiteView;
import com.startupstack.app.modules.sites.entity.FormEntity;
import com.startupstack.app.modules.sites.entity.PostEntity;
import com.startupstack.app.modules.sites.mapper.PostMapper;
import com.startupstack.app.modules.sites.repository.FormRepository;
import com.startupstack.app.modules.sites.repository.PostRepository;
import com.startupstack.app.modules.sites.specification.SitesSpecification;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import com.startupstack.app.shared.util.SecurityUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class PostService {

    private final PostRepository postRepository;
    private final FormRepository formRepository;
    private final PostMapper postMapper;

    public PostService(PostRepository postRepository,
                       FormRepository formRepository,
                       PostMapper postMapper) {
        this.postRepository = postRepository;
        this.formRepository = formRepository;
        this.postMapper = postMapper;
    }

    @Transactional(readOnly = true)
    public Page<PostResponse> findAll(String formNo, Integer wilyaNo,
                                      Boolean includeSiteInfo, Pageable pageable) {
        boolean isAdmin    = SecurityUtils.isAdmin();
        Integer userWilaya = SecurityUtils.getCurrentUserWilaya(); // null for admins

        // JWT restriction takes precedence over the client-supplied wilaya param.
        Integer effectiveWilaya = userWilaya != null ? userWilaya : wilyaNo;

        if (Boolean.TRUE.equals(includeSiteInfo)) {
            return postRepository.findAllWithSiteInfo(formNo, effectiveWilaya, pageable)
                    .map(this::mapProjectionToResponse);
        }
        String userEnt = isAdmin ? null : SecurityUtils.getCurrentUserEnt();
        Specification<PostEntity> spec = SitesSpecification.postBelongsToUserEntity(userEnt)
                .and(SitesSpecification.postHasWilya(userWilaya))   // JWT-enforced restriction
                .and(SitesSpecification.postHasFormNo(formNo))
                .and(SitesSpecification.postHasWilya(wilyaNo));      // client-requested filter
        return postRepository.findAll(spec, pageable).map(postMapper::toResponse);
    }

    @Transactional(readOnly = true)
    public PostResponse findById(String serial) {
        PostEntity entity = postRepository.findById(serial)
                .orElseThrow(() -> new ResourceNotFoundException("Post not found: " + serial));
        return postMapper.toResponse(entity);
    }

    @Transactional
    public PostResponse create(PostRequest request) {
        PostEntity entity = postMapper.toEntity(request);

        if (request.getFormNo() != null) {
            FormEntity form = formRepository.findById(request.getFormNo())
                    .orElseThrow(() -> new ResourceNotFoundException("Form not found: " + request.getFormNo()));
            entity.setForm(form);
        }

        return postMapper.toResponse(postRepository.save(entity));
    }

    @Transactional
    public PostResponse update(String serial, PostRequest request) {
        PostEntity entity = postRepository.findById(serial)
                .orElseThrow(() -> new ResourceNotFoundException("Post not found: " + serial));
        postMapper.updateEntity(request, entity);

        if (request.getFormNo() != null) {
            FormEntity form = formRepository.findById(request.getFormNo())
                    .orElseThrow(() -> new ResourceNotFoundException("Form not found: " + request.getFormNo()));
            entity.setForm(form);
        }

        return postMapper.toResponse(postRepository.save(entity));
    }

    @Transactional
    public void delete(String serial) {
        if (!postRepository.existsById(serial)) {
            throw new ResourceNotFoundException("Post not found: " + serial);
        }
        postRepository.deleteById(serial);
    }

    private PostResponse mapProjectionToResponse(PostWithSiteView v) {
        PostResponse r = new PostResponse();
        r.setSerial(v.getSerial());
        r.setFormNo(v.getFormNo());
        r.setSiteNo(v.getSiteNo());
        r.setDocNo(v.getDocNo());
        r.setStartDate(v.getStartDate());
        r.setEndDate(v.getEndDate());
        r.setWilyaNo(v.getWilyaNo());
        r.setStatus(v.getStatus());
        r.setLevelNo(v.getLevelNo());
        r.setType(v.getType());
        r.setUser(v.getUser());
        r.setPermission(v.getPermission());
        r.setLevel(v.getPostLevel());
        r.setSiteDescription(v.getSiteDescription());
        r.setSiteLevel(v.getSiteLevel());
        return r;
    }
}
