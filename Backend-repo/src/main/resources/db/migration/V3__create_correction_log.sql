CREATE TABLE correction_log (
    id          UUID        NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    app_no      VARCHAR(7)  NOT NULL,
    corrected_at TIMESTAMP  NOT NULL,
    corrected_by_user VARCHAR(30) NOT NULL,
    field_name  VARCHAR(50) NOT NULL,
    old_value   TEXT,
    new_value   TEXT,
    correction_reason TEXT
);

CREATE INDEX idx_correction_log_app_no       ON correction_log(app_no);
CREATE INDEX idx_correction_log_corrected_at ON correction_log(corrected_at DESC);
