package com.startupstack.app.modules.persons.controller;

import com.startupstack.app.modules.persons.dto.PersonRequest;
import com.startupstack.app.modules.persons.dto.PersonResponse;
import com.startupstack.app.modules.persons.dto.PostAssignmentResponse;
import com.startupstack.app.modules.persons.service.PersonService;
import com.startupstack.app.shared.annotation.Permission;
import com.startupstack.app.shared.constants.PermissionConstants;
import com.startupstack.app.shared.response.ApiResponse;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/persons")
public class PersonController {

    private final PersonService personService;

    public PersonController(PersonService personService) {
        this.personService = personService;
    }

    @GetMapping
    public ResponseEntity<ApiResponse<Page<PersonResponse>>> getAll(
            @RequestParam(required = false) String name,
            @RequestParam(required = false) String entity,
            Pageable pageable) {
        return ResponseEntity.ok(ApiResponse.success(personService.findAll(name, entity, pageable)));
    }

    @GetMapping("/{prsNo}")
    public ResponseEntity<ApiResponse<PersonResponse>> getById(@PathVariable String prsNo) {
        return ResponseEntity.ok(ApiResponse.success(personService.findById(prsNo)));
    }

    @Permission(PermissionConstants.PERM_CREATE)
    @PostMapping
    public ResponseEntity<ApiResponse<PersonResponse>> create(@Valid @RequestBody PersonRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(personService.create(request)));
    }

    @Permission(PermissionConstants.PERM_UPDATE)
    @PutMapping("/{prsNo}")
    public ResponseEntity<ApiResponse<PersonResponse>> update(
            @PathVariable String prsNo,
            @Valid @RequestBody PersonRequest request) {
        return ResponseEntity.ok(ApiResponse.success(personService.update(prsNo, request)));
    }

    @GetMapping("/{prsNo}/assignments")
    public ResponseEntity<ApiResponse<List<PostAssignmentResponse>>> getAssignments(
            @PathVariable String prsNo) {
        return ResponseEntity.ok(ApiResponse.success(personService.getAssignments(prsNo)));
    }

    @Permission(PermissionConstants.PERM_DELETE)
    @DeleteMapping("/{prsNo}")
    public ResponseEntity<ApiResponse<Void>> delete(@PathVariable String prsNo) {
        personService.delete(prsNo);
        return ResponseEntity.ok(ApiResponse.error("Person deleted successfully"));
    }
}
