package com.startupstack.app.modules.staff.service;

import com.startupstack.app.modules.staff.dto.StaffRequest;
import com.startupstack.app.modules.staff.dto.StaffResponse;
import com.startupstack.app.modules.staff.entity.Person1Entity;
import com.startupstack.app.modules.staff.mapper.StaffMapper;
import com.startupstack.app.modules.staff.repository.Person1Repository;
import com.startupstack.app.modules.staff.specification.StaffSpecification;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import com.startupstack.app.shared.util.SecurityUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class StaffService {

    private final Person1Repository person1Repository;
    private final StaffMapper staffMapper;

    public StaffService(Person1Repository person1Repository, StaffMapper staffMapper) {
        this.person1Repository = person1Repository;
        this.staffMapper = staffMapper;
    }

    @Transactional(readOnly = true)
    public Page<StaffResponse> findAll(String name, String entity, Pageable pageable) {
        String userEnt = SecurityUtils.isAdmin() ? null : SecurityUtils.getCurrentUserEnt();
        Specification<Person1Entity> spec = StaffSpecification.belongsToUserEntity(userEnt)
                .and(StaffSpecification.hasName(name))
                .and(StaffSpecification.hasEntity(entity));
        return person1Repository.findAll(spec, pageable).map(staffMapper::toResponse);
    }

    @Transactional(readOnly = true)
    public StaffResponse findById(String prsNo) {
        Person1Entity staff = person1Repository.findById(prsNo)
                .orElseThrow(() -> new ResourceNotFoundException("Staff member not found: " + prsNo));
        return staffMapper.toResponse(staff);
    }

    @Transactional
    public StaffResponse create(StaffRequest request) {
        Person1Entity entity = staffMapper.toEntity(request);
        return staffMapper.toResponse(person1Repository.save(entity));
    }

    @Transactional
    public StaffResponse update(String prsNo, StaffRequest request) {
        Person1Entity entity = person1Repository.findById(prsNo)
                .orElseThrow(() -> new ResourceNotFoundException("Staff member not found: " + prsNo));
        staffMapper.updateEntity(request, entity);
        return staffMapper.toResponse(person1Repository.save(entity));
    }

    @Transactional
    public void delete(String prsNo) {
        if (!person1Repository.existsById(prsNo)) {
            throw new ResourceNotFoundException("Staff member not found: " + prsNo);
        }
        person1Repository.deleteById(prsNo);
    }
}
