package com.startupstack.app.modules.persons.service;

import com.startupstack.app.modules.persons.dto.PersonRequest;
import com.startupstack.app.modules.persons.dto.PersonResponse;
import com.startupstack.app.modules.persons.dto.PostAssignmentResponse;
import com.startupstack.app.modules.persons.entity.PersonEntity;
import com.startupstack.app.modules.persons.mapper.PersonMapper;
import com.startupstack.app.modules.persons.repository.PersonRepository;
import com.startupstack.app.modules.persons.specification.PersonSpecification;
import com.startupstack.app.modules.sites.entity.PositionEntity;
import com.startupstack.app.modules.sites.repository.PositionRepository;
import com.startupstack.app.modules.sites.repository.PostRepository;
import com.startupstack.app.modules.sites.repository.SiteRepository;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import com.startupstack.app.shared.util.SecurityUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class PersonService {

    private final PersonRepository personRepository;
    private final PersonMapper personMapper;
    private final PostRepository postRepository;
    private final SiteRepository siteRepository;
    private final PositionRepository positionRepository;

    public PersonService(PersonRepository personRepository,
                         PersonMapper personMapper,
                         PostRepository postRepository,
                         SiteRepository siteRepository,
                         PositionRepository positionRepository) {
        this.personRepository = personRepository;
        this.personMapper = personMapper;
        this.postRepository = postRepository;
        this.siteRepository = siteRepository;
        this.positionRepository = positionRepository;
    }

    @Transactional(readOnly = true)
    public Page<PersonResponse> findAll(String name, String entity, Pageable pageable) {
        String userEnt = SecurityUtils.isAdmin() ? null : SecurityUtils.getCurrentUserEnt();
        Specification<PersonEntity> spec = PersonSpecification.belongsToUserEntity(userEnt)
                .and(PersonSpecification.hasName(name))
                .and(PersonSpecification.hasEntity(entity));
        return personRepository.findAll(spec, pageable).map(personMapper::toResponse);
    }

    @Transactional(readOnly = true)
    public PersonResponse findById(String prsNo) {
        PersonEntity person = personRepository.findById(prsNo)
                .orElseThrow(() -> new ResourceNotFoundException("Person not found: " + prsNo));
        return personMapper.toResponse(person);
    }

    @Transactional
    public PersonResponse create(PersonRequest request) {
        PersonEntity person = personMapper.toEntity(request);
        return personMapper.toResponse(personRepository.save(person));
    }

    @Transactional
    public PersonResponse update(String prsNo, PersonRequest request) {
        PersonEntity person = personRepository.findById(prsNo)
                .orElseThrow(() -> new ResourceNotFoundException("Person not found: " + prsNo));
        personMapper.updateEntity(request, person);
        return personMapper.toResponse(personRepository.save(person));
    }

    @Transactional
    public void delete(String prsNo) {
        if (!personRepository.existsById(prsNo)) {
            throw new ResourceNotFoundException("Person not found: " + prsNo);
        }
        personRepository.deleteById(prsNo);
    }

    @Transactional(readOnly = true)
    public List<PostAssignmentResponse> getAssignments(String prsNo) {
        if (!personRepository.existsById(prsNo)) {
            throw new ResourceNotFoundException("Person not found: " + prsNo);
        }
        return postRepository.findByFormNo(prsNo).stream()
                .map(post -> {
                    String siteDesc = null;
                    if (post.getSiteNo() != null && !post.getSiteNo().isBlank()) {
                        siteDesc = siteRepository.findById(post.getSiteNo().trim())
                                .map(site -> site.getDescription())
                                .orElse(null);
                    }
                    String positionNo = null;
                    String positionName = null;
                    if (post.getLevelNo() != null && !post.getLevelNo().isBlank()) {
                        java.util.Optional<PositionEntity> pos =
                                positionRepository.findById(post.getLevelNo().trim());
                        positionNo = pos.map(PositionEntity::getPosNo).orElse(null);
                        positionName = pos.map(PositionEntity::getName).orElse(null);
                    }
                    return new PostAssignmentResponse(
                            post.getSerial(),
                            siteDesc,
                            post.getType(),
                            post.getStartDate(),
                            post.getEndDate(),
                            post.getStatus(),
                            post.getLevel(),
                            positionNo,
                            positionName
                    );
                })
                .toList();
    }
}
