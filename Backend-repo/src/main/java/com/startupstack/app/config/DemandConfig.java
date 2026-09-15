package com.startupstack.app.config;

import com.startupstack.app.modules.digitization.config.DemandProperties;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
@EnableConfigurationProperties(DemandProperties.class)
public class DemandConfig {}
