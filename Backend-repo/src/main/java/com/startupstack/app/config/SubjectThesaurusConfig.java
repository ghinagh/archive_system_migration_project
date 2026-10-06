package com.startupstack.app.config;

import com.startupstack.app.modules.subjectthesaurus.config.SubjectThesaurusProperties;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
@EnableConfigurationProperties(SubjectThesaurusProperties.class)
public class SubjectThesaurusConfig {}
