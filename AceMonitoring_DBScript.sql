CREATE SEQUENCE eis.ACE_EVENTS_SEQUENCE START WITH 1 INCREMENT BY 1;

CREATE TABLE eis.doc_id_entity
(
    id                NUMBER(38, 0) NOT NULL,
    created_time      TIMESTAMP DEFAULT SYSTIMESTAMP,
    msg_arrived_time  TIMESTAMP,
    message_root_name VARCHAR2(50),
    msg_flow_name     VARCHAR2(255) NOT NULL,
    interface_name    VARCHAR2(100),
    application       VARCHAR2(50),
    subflow           VARCHAR2(100),
    CONSTRAINT pk_doc_id_entity PRIMARY KEY (id)
);

ALTER TABLE eis.doc_id_entity
    ADD CONSTRAINT uc_docidentity UNIQUE (message_root_name, msg_flow_name, interface_name);
    
    CREATE TABLE eis.ace_events_names
(
    id               NUMBER(38, 0) NOT NULL,
    created_time     TIMESTAMP DEFAULT SYSTIMESTAMP,
    msg_arrived_time TIMESTAMP,
    column_1         VARCHAR2(50),
    column_2         VARCHAR2(50),
    column_3         VARCHAR2(50),
    column_4         VARCHAR2(50),
    column_5         VARCHAR2(50),
    column_6         VARCHAR2(50),
    column_7         VARCHAR2(50),
    doc_id_entity_id NUMBER(38, 0),
    CONSTRAINT pk_ace_events_names PRIMARY KEY (id)
);

ALTER TABLE eis.ace_events_names
    ADD CONSTRAINT FK_AEN_ON_DOC_ID FOREIGN KEY (doc_id_entity_id) REFERENCES eis.doc_id_entity (id);
    
    CREATE TABLE eis.ace_events_values
(
    id                NUMBER(38, 0) NOT NULL,
    created_time      TIMESTAMP DEFAULT SYSTIMESTAMP,
    msg_arrived_time  TIMESTAMP,
    column_1          NUMBER(38, 0),
    column_2          NUMBER(38, 0),
    column_3          DOUBLE PRECISION,
    column_4          TIMESTAMP,
    column_5          VARCHAR2(100),
    column_6          CLOB,
    column_7          CLOB,
    exceptionlist     CLOB,
    environment       CLOB,
    local_environment CLOB,
    doc_id_entity_id  NUMBER(38, 0),
    CONSTRAINT pk_ace_events_values PRIMARY KEY (id)
);

ALTER TABLE eis.ace_events_values
    ADD CONSTRAINT FK_AEV_ON_DOC_ID FOREIGN KEY (doc_id_entity_id) REFERENCES eis.doc_id_entity (id);
    
    CREATE TABLE eis.ace_events
(
    id                         NUMBER(38, 0) NOT NULL,
    created_time               TIMESTAMP DEFAULT SYSTIMESTAMP,
    msg_arrived_time           TIMESTAMP,
    counter                    INTEGER,
    event_name                 VARCHAR2(100),
    event_source_address       VARCHAR2(255),
    global_transaction_id      VARCHAR2(50),
    local_transaction_id       VARCHAR2(50),
    node_detail                VARCHAR2(255),
    node_label                 VARCHAR2(50),
    node_type                  VARCHAR2(50),
    parent_transaction_id      VARCHAR2(50),
    payload                    BLOB,
    status                     INTEGER   DEFAULT 0,
    integration_node           VARCHAR2(20),
    integration_server         VARCHAR2(20)  NOT NULL,
    data_ccsid                 INTEGER,
    data_encoding              INTEGER,
    host_name                  VARCHAR2(30),
    doc_id_entity_id           NUMBER(38, 0),
    business_element_values_id NUMBER(38, 0),
    CONSTRAINT pk_ace_events PRIMARY KEY (id)
);

ALTER TABLE eis.ace_events
    ADD CONSTRAINT uc_ace_events_values UNIQUE (business_element_values_id);

CREATE INDEX eis.idx_aceeventsentity ON eis.ace_events (local_transaction_id);

ALTER TABLE eis.ace_events
    ADD CONSTRAINT FK_AE_ON_BEV FOREIGN KEY (business_element_values_id) REFERENCES eis.ace_events_values (id);

ALTER TABLE eis.ace_events
    ADD CONSTRAINT FK_AE_ON_DOC_ID FOREIGN KEY (doc_id_entity_id) REFERENCES eis.doc_id_entity (id);