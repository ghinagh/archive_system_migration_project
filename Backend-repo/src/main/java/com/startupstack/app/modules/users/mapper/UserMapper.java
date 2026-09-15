package com.startupstack.app.modules.users.mapper;

import com.startupstack.app.modules.users.dto.LoginResponse;
import com.startupstack.app.modules.users.dto.UserRequest;
import com.startupstack.app.modules.users.dto.UserResponse;
import com.startupstack.app.modules.users.entity.UserEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface UserMapper {

    @Mapping(target = "token", ignore = true)
    @Mapping(source = "userName", target = "username")
    @Mapping(source = "userLevel", target = "level")
    LoginResponse toLoginResponse(UserEntity entity);

    @Mapping(source = "userCnfPath", target = "configPath")
    @Mapping(source = "userStart", target = "startPage")
    @Mapping(source = "userPwd", target = "passwordChangeFlag")
    @Mapping(source = "userCmpvd", target = "compressedVideoPath")
    @Mapping(source = "userVideoPath", target = "videoPath")
    @Mapping(source = "userCompany", target = "company")
    @Mapping(source = "userVideoPath1", target = "secondaryVideoPath")
    @Mapping(source = "siteWly", target = "wilayaScope")
    UserResponse toResponse(UserEntity entity);

    @Mapping(source = "configPath", target = "userCnfPath")
    @Mapping(source = "startPage", target = "userStart")
    @Mapping(source = "passwordChangeFlag", target = "userPwd")
    @Mapping(source = "compressedVideoPath", target = "userCmpvd")
    @Mapping(source = "videoPath", target = "userVideoPath")
    @Mapping(source = "company", target = "userCompany")
    @Mapping(source = "secondaryVideoPath", target = "userVideoPath1")
    @Mapping(source = "wilayaScope", target = "siteWly")
    @Mapping(target = "userPassword", ignore = true)
    UserEntity toEntity(UserRequest request);

    @Mapping(source = "configPath", target = "userCnfPath")
    @Mapping(source = "startPage", target = "userStart")
    @Mapping(source = "passwordChangeFlag", target = "userPwd")
    @Mapping(source = "compressedVideoPath", target = "userCmpvd")
    @Mapping(source = "videoPath", target = "userVideoPath")
    @Mapping(source = "company", target = "userCompany")
    @Mapping(source = "secondaryVideoPath", target = "userVideoPath1")
    @Mapping(source = "wilayaScope", target = "siteWly")
    @Mapping(target = "userNo", ignore = true)
    @Mapping(target = "userPassword", ignore = true)
    void updateEntity(UserRequest request, @MappingTarget UserEntity entity);
}
