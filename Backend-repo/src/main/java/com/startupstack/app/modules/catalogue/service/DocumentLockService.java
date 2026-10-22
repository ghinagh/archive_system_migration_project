package com.startupstack.app.modules.catalogue.service;

import com.startupstack.app.modules.catalogue.dto.CatalogueResponse;
import com.startupstack.app.modules.catalogue.entity.CatalogueEntity;
import com.startupstack.app.modules.catalogue.mapper.CatalogueMapper;
import com.startupstack.app.modules.catalogue.repository.CatalogueRepository;
import com.startupstack.app.shared.exception.BusinessException;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Document locking (main.mn_trans), as the legacy program does it — gated by a key, not by role:
 * <ul>
 *   <li>ARCHIVE.frm m30 "اقفال الوثائق المفتوحة": key 891045 → upd_main_trans1
 *       (update main set mn_trans = 1 where mn_trans = 0) → "انتهى الاقفال.......".</li>
 *   <li>Form6.frm Command20 / m_user_password "فتح صلاحية": only for a locked record, key 891045 →
 *       upd_main_trans @no (mn_trans = 0); a wrong key → "كلمة السر خطا....؟".</li>
 * </ul>
 */
@Service
public class DocumentLockService {

    public static final String WRONG_KEY = "كلمة السر خطا....؟";

    private final NamedParameterJdbcTemplate jdbc;
    private final CatalogueRepository catalogueRepository;
    private final CatalogueMapper catalogueMapper;
    private final String accessKey;

    public DocumentLockService(NamedParameterJdbcTemplate jdbc,
                               CatalogueRepository catalogueRepository,
                               CatalogueMapper catalogueMapper,
                               @Value("${app.document-lock.access-key:891045}") String accessKey) {
        this.jdbc = jdbc;
        this.catalogueRepository = catalogueRepository;
        this.catalogueMapper = catalogueMapper;
        this.accessKey = accessKey;
    }

    /** upd_main_trans1 — locks every open document; returns how many were locked. */
    @Transactional
    public int lockAllOpen(String key) {
        requireKey(key);
        return jdbc.update("UPDATE main SET mn_trans = 1 WHERE mn_trans = 0", new MapSqlParameterSource());
    }

    /** upd_main_trans @no — only a locked record is touched (If box_mn_trans = 1). */
    @Transactional
    public CatalogueResponse unlock(String appNo, String key) {
        CatalogueEntity entity = catalogueRepository.findById(appNo)
                .orElseThrow(() -> new ResourceNotFoundException("Catalogue record not found: " + appNo));
        requireKey(key);
        if (entity.getTrans() != null && entity.getTrans() == 1) {
            entity.setTrans(0);
            entity = catalogueRepository.save(entity);
        }
        return catalogueMapper.toResponse(entity);
    }

    private void requireKey(String key) {
        if (key == null || !accessKey.equals(key.trim())) {
            throw new BusinessException(WRONG_KEY);
        }
    }
}
