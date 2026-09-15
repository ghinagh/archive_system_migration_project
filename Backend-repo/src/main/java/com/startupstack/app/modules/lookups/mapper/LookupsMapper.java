package com.startupstack.app.modules.lookups.mapper;

import com.startupstack.app.modules.lookups.dto.Arrays1Response;
import com.startupstack.app.modules.lookups.dto.ArraysResponse;
import com.startupstack.app.modules.lookups.dto.CodingResponse;
import com.startupstack.app.modules.lookups.dto.CotePubResponse;
import com.startupstack.app.modules.lookups.dto.DictResponse;
import com.startupstack.app.modules.lookups.dto.MacnzResponse;
import com.startupstack.app.modules.lookups.dto.MemResponse;
import com.startupstack.app.modules.lookups.dto.RelisResponse;
import com.startupstack.app.modules.lookups.dto.TOperationResponse;
import com.startupstack.app.modules.lookups.entity.Arrays1Entity;
import com.startupstack.app.modules.lookups.entity.ArraysEntity;
import com.startupstack.app.modules.lookups.entity.CodingEntity;
import com.startupstack.app.modules.lookups.entity.CotePubEntity;
import com.startupstack.app.modules.lookups.entity.DictEntity;
import com.startupstack.app.modules.lookups.entity.MacnzEntity;
import com.startupstack.app.modules.lookups.entity.MemEntity;
import com.startupstack.app.modules.lookups.entity.RelisEntity;
import com.startupstack.app.modules.lookups.entity.TOperationEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.List;

@Mapper(componentModel = "spring")
public interface LookupsMapper {

    @Mapping(source = "arTyp", target = "type")
    @Mapping(source = "arCode", target = "code")
    @Mapping(source = "arDesc", target = "description")
    @Mapping(source = "arLevel", target = "level")
    ArraysResponse toArraysResponse(ArraysEntity entity);

    List<ArraysResponse> toArraysResponseList(List<ArraysEntity> entities);

    @Mapping(source = "arTyp", target = "type")
    @Mapping(source = "arNo", target = "code")
    @Mapping(source = "arDesc", target = "description")
    Arrays1Response toArrays1Response(Arrays1Entity entity);

    List<Arrays1Response> toArrays1ResponseList(List<Arrays1Entity> entities);

    RelisResponse toRelisResponse(RelisEntity entity);

    List<RelisResponse> toRelisResponseList(List<RelisEntity> entities);

    @Mapping(source = "subDesc3", target = "description")
    DictResponse toDictResponse(DictEntity entity);

    List<DictResponse> toDictResponseList(List<DictEntity> entities);

    @Mapping(source = "subDesc4", target = "description")
    MemResponse toMemResponse(MemEntity entity);

    List<MemResponse> toMemResponseList(List<MemEntity> entities);

    CotePubResponse toCotePubResponse(CotePubEntity entity);

    List<CotePubResponse> toCotePubResponseList(List<CotePubEntity> entities);

    @Mapping(source = "operationCode", target = "code")
    TOperationResponse toTOperationResponse(TOperationEntity entity);

    List<TOperationResponse> toTOperationResponseList(List<TOperationEntity> entities);

    @Mapping(source = "subCode", target = "code")
    @Mapping(source = "subLevel", target = "level")
    @Mapping(source = "subDesc", target = "description")
    @Mapping(source = "subLogic", target = "logic")
    MacnzResponse toMacnzResponse(MacnzEntity entity);

    List<MacnzResponse> toMacnzResponseList(List<MacnzEntity> entities);

    @Mapping(source = "subLeve", target = "level")
    @Mapping(source = "subCode", target = "code")
    @Mapping(source = "subDesc", target = "description")
    CodingResponse toCodingResponse(CodingEntity entity);

    List<CodingResponse> toCodingResponseList(List<CodingEntity> entities);
}
