package com.startupstack.app.modules.digitization.specification;

import com.startupstack.app.modules.digitization.entity.DemandEntity;
import com.startupstack.app.modules.digitization.entity.DigitEntity;
import com.startupstack.app.modules.digitization.entity.ResultEntity;
import org.springframework.data.jpa.domain.Specification;

import java.time.LocalDateTime;

public final class DigitizationSpecification {

    private DigitizationSpecification() {
    }

    /**
     * Restricts DIGIT records to those whose catalogue entry entity matches
     * {@code userEnt} (via the MN_DATA_EN column on the joined main table). No-op for admins (null).
     */
    public static Specification<DigitEntity> digitBelongsToUserEntity(String userEnt) {
        return (root, query, cb) ->
                userEnt == null ? cb.conjunction() : cb.equal(root.get("catalogue").get("dataEntry"), userEnt);
    }

    /** DEMAND table has no direct entity column — always returns conjunction (no filter applied). */
    public static Specification<DemandEntity> demandBelongsToUserEntity(String userEnt) {
        return (root, query, cb) -> cb.conjunction();
    }

    /** result table has no entity column — always returns conjunction (no filter applied). */
    public static Specification<ResultEntity> resultBelongsToUserEntity(String userEnt) {
        return (root, query, cb) -> cb.conjunction();
    }

    public static Specification<DigitEntity> digitHasDocNo(String docNo) {
        return (root, query, cb) ->
                docNo == null ? null : cb.equal(root.get("docNo"), docNo);
    }

    public static Specification<DigitEntity> digitHasType(String type) {
        return (root, query, cb) ->
                type == null ? null : cb.equal(root.get("type"), type);
    }

    public static Specification<DemandEntity> demandHasUser(String userNo) {
        return (root, query, cb) ->
                userNo == null ? null : cb.equal(root.get("user").get("userNo"), userNo);
    }

    public static Specification<DemandEntity> demandHasMachine(String machineNo) {
        return (root, query, cb) ->
                machineNo == null ? null : cb.equal(root.get("catalogue").get("appNo"), machineNo);
    }

    public static Specification<DemandEntity> demandHasDemandNo(String demandNo) {
        return (root, query, cb) ->
                demandNo == null ? null : cb.equal(root.get("demandNo"), demandNo);
    }

    public static Specification<DemandEntity> demandHasMachineStock(String machineStock) {
        return (root, query, cb) ->
                machineStock == null ? null : cb.like(root.get("machineStock"), "%" + machineStock + "%");
    }

    /**
     * {@code checked=2} means fulfilled in the legacy dmd_chek convention; anything else
     * (including null) means pending.
     *
     * <p>The pending branch must spell out the NULL case explicitly. SQL three-valued logic
     * makes {@code NOT(dmd_chek = 2)} evaluate to UNKNOWN — not TRUE — when {@code dmd_chek}
     * is NULL, which silently dropped never-touched rows from the "unfulfilled" view. Legacy
     * USER_INTERFACE1.frm:2770-2775 wrote the predicate as
     * {@code (dmd_chek <> 2 OR dmd_chek IS NULL)} for exactly this reason.
     */
    public static Specification<DemandEntity> demandIsFulfilled(Boolean fulfilled) {
        return (root, query, cb) -> {
            if (fulfilled == null) {
                return null;
            }
            if (fulfilled) {
                return cb.equal(root.get("checked"), 2);
            }
            return cb.or(
                    cb.notEqual(root.get("checked"), 2),
                    cb.isNull(root.get("checked")));
        };
    }

    public static Specification<DemandEntity> demandDateBetween(LocalDateTime from, LocalDateTime to) {
        return (root, query, cb) -> {
            if (from == null && to == null) {
                return null;
            }
            if (from != null && to != null) {
                return cb.between(root.get("date"), from, to);
            }
            return from != null ? cb.greaterThanOrEqualTo(root.get("date"), from) : cb.lessThanOrEqualTo(root.get("date"), to);
        };
    }

    /** Matches the description or the linked catalogue record's title — the legacy dmd_desc + mn_act_ttl free-text search. */
    public static Specification<DemandEntity> demandDescriptionOrTitleContains(String term) {
        return (root, query, cb) -> {
            if (term == null || term.isBlank()) {
                return null;
            }
            String pattern = "%" + term.toLowerCase() + "%";
            return cb.or(
                    cb.like(cb.lower(root.get("description")), pattern),
                    cb.like(cb.lower(root.get("catalogue").get("activeTitleAr")), pattern));
        };
    }

    /** legacy: "RES_DIG_NO like '%'+m_dig_dig_no.Text+'%'" / "dig_dig_no like ..." — substring, not exact. */
    public static Specification<ResultEntity> resultHasDigitNo(String digitNo) {
        return (root, query, cb) ->
                digitNo == null ? null : cb.like(cb.lower(root.get("digitNo")), "%" + digitNo.toLowerCase() + "%");
    }

    /** legacy: "RES_typ like '%'+M_DIG_TYP.Text+'%'" — substring, not exact. */
    public static Specification<ResultEntity> resultHasType(String type) {
        return (root, query, cb) ->
                type == null ? null : cb.like(cb.lower(root.get("type")), "%" + type.toLowerCase() + "%");
    }

    /** legacy: "RES_Typ1 = Mid(m_dig_typ1.BoundText,3,2)" — exact match against a DataCombo-picked code. */
    public static Specification<ResultEntity> resultHasType1(String type1) {
        return (root, query, cb) ->
                type1 == null ? null : cb.equal(root.get("type1"), type1);
    }

    /** legacy: "res_no like '%'+m_res_no.Text+'%'" — substring, not exact. */
    public static Specification<ResultEntity> resultHasResultNo(String resultNo) {
        return (root, query, cb) ->
                resultNo == null ? null : cb.like(cb.lower(root.get("resultNo")), "%" + resultNo.toLowerCase() + "%");
    }

    public static Specification<ResultEntity> resultPersonContains(String person) {
        return (root, query, cb) ->
                person == null ? null : cb.like(cb.lower(root.get("person")), "%" + person.toLowerCase() + "%");
    }

    public static Specification<ResultEntity> resultHasCote(String cote) {
        return (root, query, cb) ->
                cote == null ? null : cb.equal(root.get("cote"), cote);
    }

    public static Specification<ResultEntity> resultHasPermit(String permit) {
        return (root, query, cb) ->
                permit == null ? null : cb.equal(root.get("permit"), permit);
    }

    public static Specification<ResultEntity> resultSubjectContains(String subject) {
        return (root, query, cb) ->
                subject == null ? null : cb.like(cb.lower(root.get("subject")), "%" + subject.toLowerCase() + "%");
    }

    /** Matches the linked catalogue record's title — legacy's "كلمة من العناوين" filter on شاشة الطلبات. */
    public static Specification<ResultEntity> resultTitleContains(String title) {
        return (root, query, cb) ->
                title == null ? null : cb.like(cb.lower(root.get("catalogue").get("activeTitleAr")), "%" + title.toLowerCase() + "%");
    }

    public static Specification<ResultEntity> resultDateBetween(LocalDateTime from, LocalDateTime to) {
        return (root, query, cb) -> {
            if (from == null && to == null) {
                return null;
            }
            if (from != null && to != null) {
                return cb.between(root.get("date"), from, to);
            }
            return from != null ? cb.greaterThanOrEqualTo(root.get("date"), from) : cb.lessThanOrEqualTo(root.get("date"), to);
        };
    }
}
