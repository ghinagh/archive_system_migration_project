package com.startupstack.app.config;

import com.startupstack.app.modules.formthesaurus.config.FormThesaurusProperties;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
@EnableConfigurationProperties(FormThesaurusProperties.class)
public class FormThesaurusConfig {}
