CREATE TABLE retrieval_field (
    id           UUID          NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    module       VARCHAR(30)   NOT NULL,
    field_key    VARCHAR(50)   NOT NULL,
    entity_path  VARCHAR(100)  NOT NULL,
    field_type   VARCHAR(10)   NOT NULL,
    label        VARCHAR(100)  NOT NULL,
    enabled      BOOLEAN       NOT NULL DEFAULT TRUE,
    created_at   TIMESTAMP     NOT NULL DEFAULT now(),
    updated_at   TIMESTAMP     NOT NULL DEFAULT now()
);

CREATE UNIQUE INDEX idx_retrieval_field_module_key ON retrieval_field(module, field_key);
CREATE INDEX idx_retrieval_field_module ON retrieval_field(module);
