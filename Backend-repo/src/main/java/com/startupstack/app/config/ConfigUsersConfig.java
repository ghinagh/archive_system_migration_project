package com.startupstack.app.config;

import com.startupstack.app.modules.configusers.config.ConfigUsersProperties;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
@EnableConfigurationProperties(ConfigUsersProperties.class)
public class ConfigUsersConfig {}
