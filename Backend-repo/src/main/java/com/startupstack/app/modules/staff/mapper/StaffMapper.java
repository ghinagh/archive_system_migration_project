package com.startupstack.app.modules.staff.mapper;

import com.startupstack.app.modules.staff.dto.StaffRequest;
import com.startupstack.app.modules.staff.dto.StaffResponse;
import com.startupstack.app.modules.staff.entity.Person1Entity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface StaffMapper {

    @Mapping(source = "prsName",     target = "name")
    @Mapping(source = "prsInst",     target = "institution")
    @Mapping(source = "prsAdrs",     target = "address")
    @Mapping(source = "prsInstTel",  target = "institutionPhone")
    @Mapping(source = "prsInstBox",  target = "institutionBox")
    @Mapping(source = "prsInstDirct",target = "institutionDirectorate")
    @Mapping(source = "prsInstEmail",target = "institutionEmail")
    @Mapping(source = "prsKayd",     target = "registrationId")
    @Mapping(source = "prsBrthDte",  target = "birthDate")
    @Mapping(source = "prsVlg",      target = "village")
    @Mapping(source = "prsSakan",    target = "residence")
    @Mapping(source = "prsAdrs1",    target = "secondaryAddress")
    @Mapping(source = "prsTel",      target = "phone")
    @Mapping(source = "prsEmail",    target = "email")
    @Mapping(source = "prsBox",      target = "poBox")
    @Mapping(source = "prsTypIcht",  target = "specialtyTypeCode")
    @Mapping(source = "prsQualty",   target = "qualification")
    @Mapping(source = "prsIchtDte1", target = "specialtyDate1")
    @Mapping(source = "prsIchtDte2", target = "specialtyDate2")
    @Mapping(source = "prsEnt",      target = "entity")
    StaffResponse toResponse(Person1Entity entity);

    @Mapping(source = "name",                  target = "prsName")
    @Mapping(source = "institution",           target = "prsInst")
    @Mapping(source = "address",               target = "prsAdrs")
    @Mapping(source = "institutionPhone",      target = "prsInstTel")
    @Mapping(source = "institutionBox",        target = "prsInstBox")
    @Mapping(source = "institutionDirectorate",target = "prsInstDirct")
    @Mapping(source = "institutionEmail",      target = "prsInstEmail")
    @Mapping(source = "registrationId",        target = "prsKayd")
    @Mapping(source = "birthDate",             target = "prsBrthDte")
    @Mapping(source = "village",               target = "prsVlg")
    @Mapping(source = "residence",             target = "prsSakan")
    @Mapping(source = "secondaryAddress",      target = "prsAdrs1")
    @Mapping(source = "phone",                 target = "prsTel")
    @Mapping(source = "email",                 target = "prsEmail")
    @Mapping(source = "poBox",                 target = "prsBox")
    @Mapping(source = "specialtyTypeCode",     target = "prsTypIcht")
    @Mapping(source = "qualification",         target = "prsQualty")
    @Mapping(source = "specialtyDate1",        target = "prsIchtDte1")
    @Mapping(source = "specialtyDate2",        target = "prsIchtDte2")
    @Mapping(source = "entity",                target = "prsEnt")
    Person1Entity toEntity(StaffRequest request);

    @Mapping(source = "name",                  target = "prsName")
    @Mapping(source = "institution",           target = "prsInst")
    @Mapping(source = "address",               target = "prsAdrs")
    @Mapping(source = "institutionPhone",      target = "prsInstTel")
    @Mapping(source = "institutionBox",        target = "prsInstBox")
    @Mapping(source = "institutionDirectorate",target = "prsInstDirct")
    @Mapping(source = "institutionEmail",      target = "prsInstEmail")
    @Mapping(source = "registrationId",        target = "prsKayd")
    @Mapping(source = "birthDate",             target = "prsBrthDte")
    @Mapping(source = "village",               target = "prsVlg")
    @Mapping(source = "residence",             target = "prsSakan")
    @Mapping(source = "secondaryAddress",      target = "prsAdrs1")
    @Mapping(source = "phone",                 target = "prsTel")
    @Mapping(source = "email",                 target = "prsEmail")
    @Mapping(source = "poBox",                 target = "prsBox")
    @Mapping(source = "specialtyTypeCode",     target = "prsTypIcht")
    @Mapping(source = "qualification",         target = "prsQualty")
    @Mapping(source = "specialtyDate1",        target = "prsIchtDte1")
    @Mapping(source = "specialtyDate2",        target = "prsIchtDte2")
    @Mapping(source = "entity",                target = "prsEnt")
    @Mapping(target = "prsNo", ignore = true)
    void updateEntity(StaffRequest request, @MappingTarget Person1Entity entity);
}
