package com.startupstack.app.shared.media;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Data
@ConfigurationProperties(prefix = "app.media")
public class MediaProperties {

    private String basePath = "/media";
    private String extension = "";
    private String archivePath = "./data/archive";
    private List<VolumeRange> volumes = new ArrayList<>();

    /**
     * Legacy {@code m_cnf_path_pic} — the root under which every non-video asset class lives.
     * Scans, photos, private material and audio all hang off this, not off the tape volumes.
     */
    private String picturePath = "/media/pictures";

    /**
     * Legacy {@code box_user_path} — the per-user folder Command5 writes delivery clips into.
     * On the desktop app this was a local path per workstation; here it is a server-side root
     * under which each user gets their own sub-folder, since the browser cannot be handed a
     * filesystem destination.
     */
    private String userOutputPath = "./data/output";

    /**
     * {@code DIGIT.DIG_TYP1} → sub-folder, reproducing the routing table in
     * USER_INTERFACE1.frm datagrid1_DblClick (:4858-4880). Configurable so a deployment can
     * retarget a class without a code change. Codes absent from this map (notably {@code 04})
     * are video and resolve through the tape volumes instead.
     */
    private Map<String, String> assetClassFolders = new LinkedHashMap<>(Map.of(
            "01", "scan",
            "02", "waves",
            "03", "photos",
            "05", "private"));

    @Data
    public static class VolumeRange {
        private int from;
        private int to;
        private String path;
        /**
         * Which storage tier this volume holds, in ranjpath's {@code rjp_typ} vocabulary:
         * {@code 1} = broadcast master, {@code 2} = low-res proxy. Defaults to the proxy so an
         * existing single-tier configuration keeps serving preview requests; declare a
         * {@code tier: 1} volume to make master lookups resolve on the fallback path too.
         */
        private int tier = StockTier.LOW.rjpTyp();
    }
}
