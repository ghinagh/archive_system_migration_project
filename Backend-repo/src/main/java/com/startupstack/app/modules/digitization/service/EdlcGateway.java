package com.startupstack.app.modules.digitization.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

/**
 * The hand-off to the external EDLC system.
 *
 * <p>Legacy USER_INTERFACE1.frm Command5_Click (:4380-4400) closes each delivery by calling
 * {@code INSERT_TBL_FILES} on {@code cn1} — a <em>second</em> ADO connection, pointing at a
 * database outside the catalogue schema:
 *
 * <pre>
 * sql = "execute INSERT_TBL_FILES '" &amp; v_name1 &amp; "','" &amp; m_titles &amp; "','" &amp; m_finch &amp; "','"
 *        &amp; m_finch &amp; "','" &amp; m_titles &amp; "','" &amp; time_code3 &amp; "','" &amp; m_user_name &amp; "','" &amp; m_id &amp; "'"
 * cn1.Execute sql, rdExecDirect
 * </pre>
 *
 * The eight arguments, in order, are: filename, title, finished flag, finished flag again,
 * title again, duration timecode, user name, and the constant id 9.
 *
 * <p>Legacy wraps the whole handler in {@code On Error Resume Next} (:4096), so an EDLC
 * outage never rolled back the local {@code dmd_chek = 2}. That tolerance is preserved here:
 * a failed hand-off is reported and logged, and the local delivery still stands.
 */
@Service
public class EdlcGateway {

    private static final Logger log = LoggerFactory.getLogger(EdlcGateway.class);

    /** Legacy passes this as a literal in every INSERT_TBL_FILES call. */
    private static final int LEGACY_CONSTANT_ID = 9;

    /**
     * Registers a delivered clip with the external EDLC system.
     *
     * @return {@code true} when the clip was registered; {@code false} when the hand-off could
     *         not be performed, which the caller reports without failing the delivery
     */
    public boolean registerDeliveredFile(String fileName, String title, String durationTimecode, String userName) {
        // TODO: needs external EDLC database connection details.
        //
        // Blocked on the client supplying: the EDLC server/database, credentials, and the real
        // table and column names behind the INSERT_TBL_FILES procedure. Once known, add a
        // profile-guarded `spring.datasource.edlc.*` secondary DataSource with its own
        // JdbcTemplate and issue the eight-argument insert documented on this class, using
        // LEGACY_CONSTANT_ID for the trailing id.
        //
        // Until then this is a no-op that records the intent, so the rest of the pipeline —
        // transcode, poster frame, and the two local status writes — is complete and testable.
        log.warn("EDLC hand-off skipped (connection details not configured): file={}, title={}, duration={}, user={}, id={}",
                fileName, title, durationTimecode, userName, LEGACY_CONSTANT_ID);
        return false;
    }
}
