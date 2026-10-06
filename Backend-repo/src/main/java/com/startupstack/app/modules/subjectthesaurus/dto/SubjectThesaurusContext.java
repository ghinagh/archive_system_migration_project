package com.startupstack.app.modules.subjectthesaurus.dto;

/** {@code canWrite} mirrors Form5's {@code box_user_no = "244"} gate on اضافة / تسجيل / الغاء. */
public record SubjectThesaurusContext(String userNo, boolean canWrite) {}
