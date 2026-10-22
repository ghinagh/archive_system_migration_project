package com.startupstack.app.modules.catalogue.service;

import com.startupstack.app.modules.catalogue.repository.CatalogueRepository;
import com.startupstack.app.shared.exception.BusinessException;
import org.springframework.stereotype.Component;

/**
 * Legacy bok.bas {@code is_trans(box_mn_trans)}: every add / edit / delete on a locked document
 * (main.mn_trans = 1) is refused with the same message. Form2.frm (analysis) calls it before each
 * insr_* / del_* / upd_* on its lists, times, dates and text.
 */
@Component
public class CatalogueLockGuard {

    public static final String LOCKED_MESSAGE = "لاتستطيع التعدل او الالغاء ....لان الوثيقة مقفلة.";

    private final CatalogueRepository catalogueRepository;

    public CatalogueLockGuard(CatalogueRepository catalogueRepository) {
        this.catalogueRepository = catalogueRepository;
    }

    public void assertEditable(String appNo) {
        catalogueRepository.findById(appNo).ifPresent(c -> {
            if (c.getTrans() != null && c.getTrans() == 1) {
                throw new BusinessException(LOCKED_MESSAGE);
            }
        });
    }
}
