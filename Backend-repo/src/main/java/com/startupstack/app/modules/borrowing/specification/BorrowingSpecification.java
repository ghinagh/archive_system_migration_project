package com.startupstack.app.modules.borrowing.specification;

import com.startupstack.app.modules.borrowing.entity.BorrowingEntity;
import org.springframework.data.jpa.domain.Specification;

import java.time.LocalDateTime;

public final class BorrowingSpecification {

    private BorrowingSpecification() {
    }

    /** Restricts results to borrowing records whose entity matches {@code userEnt} (IAR_ENT). No-op for admins (null). */
    public static Specification<BorrowingEntity> belongsToUserEntity(String userEnt) {
        return (root, query, cb) ->
                userEnt == null ? cb.conjunction() : cb.equal(root.get("entity"), userEnt);
    }

    public static Specification<BorrowingEntity> hasPerson(String personNo) {
        return (root, query, cb) ->
                personNo == null ? null : cb.equal(root.get("person").get("prsNo"), personNo);
    }

    public static Specification<BorrowingEntity> hasBorrowingType(Double type) {
        return (root, query, cb) ->
                type == null ? null : cb.equal(root.get("borrowingType"), type);
    }

    public static Specification<BorrowingEntity> borrowDateFrom(LocalDateTime from) {
        return (root, query, cb) ->
                from == null ? null : cb.greaterThanOrEqualTo(root.get("borrowDate"), from);
    }

    public static Specification<BorrowingEntity> borrowDateTo(LocalDateTime to) {
        return (root, query, cb) ->
                to == null ? null : cb.lessThanOrEqualTo(root.get("borrowDate"), to);
    }

    public static Specification<BorrowingEntity> notReturned() {
        return (root, query, cb) -> cb.isNull(root.get("returnDate"));
    }

    /**
     * Wilaya filtering is not directly applicable to ISTARA borrowing records.
     *
     * <p>The ISTARA table has no {@code wilaya} column.  The closest geographic
     * scope is {@code iar_ent} (the organizational entity code), which is already
     * enforced by {@link #belongsToUserEntity(String)}.  A true wilaya predicate
     * would require joining ISTARA → PERSON1 → posts → sites to reach
     * {@code sit_wly_no}, but that chain is not guaranteed to be intact for every
     * borrowing record and would introduce a costly multi-hop join on a
     * potentially large table.
     *
     * <p>This method is intentionally a no-op.  Wilaya-level access control for
     * borrowing records is documented as <em>out-of-scope</em> pending a schema
     * addition of a direct {@code iar_wly_no} column to ISTARA.
     */
    public static Specification<BorrowingEntity> hasWilaya(Integer wilayaNo) {
        return (root, query, cb) -> null; // no wilaya column on ISTARA — see Javadoc
    }
}
