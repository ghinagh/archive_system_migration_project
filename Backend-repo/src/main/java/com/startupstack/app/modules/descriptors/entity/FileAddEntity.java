package com.startupstack.app.modules.descriptors.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.util.UUID;

/**
 * A legacy "additional file" cross-reference: says the catalogue record {@link #appNo}
 * has a related supplementary dossier {@link #fileNo} (itself another catalogued
 * subject/document), tagged with a relation-type code — see
 * {@link com.startupstack.app.modules.descriptors.dto.FileAddRelationType}.
 */
@Getter
@Setter
@Entity
@Table(name = "FILE_ADD")
public class FileAddEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id", updatable = false, nullable = false)
    private UUID id;

    @Column(name = "FAD_APP_NO")
    private String appNo;

    @Column(name = "FAD_DESC_N")
    private String descriptorNo;

    @Column(name = "FAD_SER_NO")
    private String serialNo;

    @Column(name = "FAD_FAD_T1")
    private String fileType1;

    @Column(name = "FAD_FAD_T2")
    private String fileType2;

    @Column(name = "FAD_RLTV_N")
    private String relativeNo;

    @Column(name = "FAD_FAD_NO")
    private String fileNo;
}
