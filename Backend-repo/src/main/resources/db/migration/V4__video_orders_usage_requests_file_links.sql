CREATE TABLE video_order (
    id             UUID          NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    order_no       VARCHAR(20)   NOT NULL,
    stock_no       VARCHAR(6)    NOT NULL,
    chart_id       INT           REFERENCES "CHARIT"(auto),
    description    VARCHAR(200),
    requested_by   VARCHAR(30)   NOT NULL,
    request_date   TIMESTAMP     NOT NULL,
    status         VARCHAR(20)   NOT NULL DEFAULT 'PENDING',
    created_at     TIMESTAMP     NOT NULL DEFAULT now(),
    updated_at     TIMESTAMP     NOT NULL DEFAULT now()
);

CREATE UNIQUE INDEX idx_video_order_order_no ON video_order(order_no);
CREATE INDEX idx_video_order_status ON video_order(status);

CREATE TABLE usage_request (
    id                 UUID          NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    request_no         VARCHAR(20)   NOT NULL,
    digitization_type  VARCHAR(10),
    digitization_no    VARCHAR(20),
    permit_no          VARCHAR(20),
    requester          VARCHAR(100) NOT NULL,
    cote               VARCHAR(50),
    request_date       TIMESTAMP    NOT NULL,
    status             VARCHAR(20)  NOT NULL DEFAULT 'PENDING',
    created_at         TIMESTAMP    NOT NULL DEFAULT now(),
    updated_at         TIMESTAMP    NOT NULL DEFAULT now()
);

CREATE UNIQUE INDEX idx_usage_request_request_no ON usage_request(request_no);

CREATE TABLE file_link (
    id            UUID          NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    app_no        VARCHAR(7)    NOT NULL,
    file_path     VARCHAR(255)  NOT NULL,
    linked_by_user VARCHAR(30)  NOT NULL,
    linked_at     TIMESTAMP     NOT NULL DEFAULT now()
);

CREATE INDEX idx_file_link_app_no ON file_link(app_no);
