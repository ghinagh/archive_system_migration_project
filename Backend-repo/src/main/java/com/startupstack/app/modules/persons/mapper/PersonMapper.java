package com.startupstack.app.modules.persons.mapper;

import com.startupstack.app.modules.persons.dto.PersonRequest;
import com.startupstack.app.modules.persons.dto.PersonResponse;
import com.startupstack.app.modules.persons.entity.PersonEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface PersonMapper {

    @Mapping(source = "prsName", target = "name")
    @Mapping(source = "prsInst", target = "institution")
    @Mapping(source = "prsAdrs", target = "address")
    @Mapping(source = "prsInstTel", target = "institutionPhone")
    @Mapping(source = "prsInstBox", target = "institutionBox")
    @Mapping(source = "prsInstDirct", target = "institutionDirectorate")
    @Mapping(source = "prsInstEmail", target = "institutionEmail")
    @Mapping(source = "prsKayd", target = "registrationId")
    @Mapping(source = "prsBrthDte", target = "birthDate")
    @Mapping(source = "prsVlg", target = "village")
    @Mapping(source = "prsSakan", target = "residence")
    @Mapping(source = "prsAdrs1", target = "secondaryAddress")
    @Mapping(source = "prsTel", target = "phone")
    @Mapping(source = "prsEmail", target = "email")
    @Mapping(source = "prsBox", target = "poBox")
    @Mapping(source = "prsQualty", target = "qualification")
    @Mapping(source = "prsIchtDte1", target = "specialtyDate")
    @Mapping(source = "prsEnt", target = "entity")
    @Mapping(source = "prsMzhb", target = "denomination")
    @Mapping(source = "prsPolitc", target = "politicalAffiliation")
    @Mapping(source = "prsSocialMedia", target = "socialMedia")
    @Mapping(source = "prsOldjob", target = "previousJob")
    @Mapping(source = "prsSex", target = "sex")
    PersonResponse toResponse(PersonEntity entity);

    @Mapping(source = "name", target = "prsName")
    @Mapping(source = "institution", target = "prsInst")
    @Mapping(source = "address", target = "prsAdrs")
    @Mapping(source = "institutionPhone", target = "prsInstTel")
    @Mapping(source = "institutionBox", target = "prsInstBox")
    @Mapping(source = "institutionDirectorate", target = "prsInstDirct")
    @Mapping(source = "institutionEmail", target = "prsInstEmail")
    @Mapping(source = "registrationId", target = "prsKayd")
    @Mapping(source = "birthDate", target = "prsBrthDte")
    @Mapping(source = "village", target = "prsVlg")
    @Mapping(source = "residence", target = "prsSakan")
    @Mapping(source = "secondaryAddress", target = "prsAdrs1")
    @Mapping(source = "phone", target = "prsTel")
    @Mapping(source = "email", target = "prsEmail")
    @Mapping(source = "poBox", target = "prsBox")
    @Mapping(source = "qualification", target = "prsQualty")
    @Mapping(source = "specialtyDate", target = "prsIchtDte1")
    @Mapping(source = "entity", target = "prsEnt")
    @Mapping(source = "denomination", target = "prsMzhb")
    @Mapping(source = "politicalAffiliation", target = "prsPolitc")
    @Mapping(source = "socialMedia", target = "prsSocialMedia")
    @Mapping(source = "previousJob", target = "prsOldjob")
    @Mapping(source = "sex", target = "prsSex")
    PersonEntity toEntity(PersonRequest request);

    @Mapping(source = "name", target = "prsName")
    @Mapping(source = "institution", target = "prsInst")
    @Mapping(source = "address", target = "prsAdrs")
    @Mapping(source = "institutionPhone", target = "prsInstTel")
    @Mapping(source = "institutionBox", target = "prsInstBox")
    @Mapping(source = "institutionDirectorate", target = "prsInstDirct")
    @Mapping(source = "institutionEmail", target = "prsInstEmail")
    @Mapping(source = "registrationId", target = "prsKayd")
    @Mapping(source = "birthDate", target = "prsBrthDte")
    @Mapping(source = "village", target = "prsVlg")
    @Mapping(source = "residence", target = "prsSakan")
    @Mapping(source = "secondaryAddress", target = "prsAdrs1")
    @Mapping(source = "phone", target = "prsTel")
    @Mapping(source = "email", target = "prsEmail")
    @Mapping(source = "poBox", target = "prsBox")
    @Mapping(source = "qualification", target = "prsQualty")
    @Mapping(source = "specialtyDate", target = "prsIchtDte1")
    @Mapping(source = "entity", target = "prsEnt")
    @Mapping(source = "denomination", target = "prsMzhb")
    @Mapping(source = "politicalAffiliation", target = "prsPolitc")
    @Mapping(source = "socialMedia", target = "prsSocialMedia")
    @Mapping(source = "previousJob", target = "prsOldjob")
    @Mapping(source = "sex", target = "prsSex")
    @Mapping(target = "prsNo", ignore = true)
    void updateEntity(PersonRequest request, @MappingTarget PersonEntity entity);
}
