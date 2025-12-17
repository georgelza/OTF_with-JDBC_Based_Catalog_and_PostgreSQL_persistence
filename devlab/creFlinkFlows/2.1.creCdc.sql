
# CDC Sources

CREATE OR REPLACE TABLE c_cdcsource.demog.accountholders_iceberg (
     _id                BIGINT                  NOT NULL
    ,nationalid         VARCHAR(16)             NOT NULL
    ,firstname          VARCHAR(100)
    ,lastname           VARCHAR(100)
    ,dob                VARCHAR(10) 
    ,gender             VARCHAR(10)
    ,children           INT
    ,emailaddress       VARCHAR(100)
    ,mobilephonenumber  VARCHAR(20)
    ,accounts           STRING
    ,created_at         TIMESTAMP_LTZ(3)
    ,WATERMARK          FOR created_at AS created_at - INTERVAL '15' SECOND
    ,PRIMARY KEY (_id) NOT ENFORCED
) WITH (
     'connector'                           = 'postgres-cdc'
    ,'hostname'                            = 'postgrescdc'
    ,'port'                                = '5432'
    ,'username'                            = 'dbadmin'
    ,'password'                            = 'dbpassword'
    ,'database-name'                       = 'demog'
    ,'schema-name'                         = 'public'
    ,'table-name'                          = 'accountholders'
    ,'slot.name'                           = 'accountholders_iceberg'
    -- experimental feature: incremental snapshot (default off)
    ,'scan.incremental.snapshot.enabled'   = 'true'               -- experimental feature: incremental snapshot (default off)
    ,'scan.startup.mode'                   = 'initial'            -- https://nightlies.apache.org/flink/flink-cdc-docs-release-3.1/docs/connectors/flink-sources/postgres-cdc/#startup-reading-position     ,'decoding.plugin.name'                = 'pgoutput'
    ,'decoding.plugin.name'                = 'pgoutput'
);

CREATE OR REPLACE TABLE c_cdcsource.demog.accountholders_paimon (
     _id                BIGINT                  NOT NULL
    ,nationalid         VARCHAR(16)             NOT NULL
    ,firstname          VARCHAR(100)
    ,lastname           VARCHAR(100)
    ,dob                VARCHAR(10) 
    ,gender             VARCHAR(10)
    ,children           INT
    ,emailaddress       VARCHAR(100)
    ,mobilephonenumber  VARCHAR(20)
    ,accounts           STRING
    ,created_at         TIMESTAMP_LTZ(3)
    ,WATERMARK          FOR created_at AS created_at - INTERVAL '15' SECOND
    ,PRIMARY KEY (_id) NOT ENFORCED
) WITH (
     'connector'                           = 'postgres-cdc'
    ,'hostname'                            = 'postgrescdc'
    ,'port'                                = '5432'
    ,'username'                            = 'dbadmin'
    ,'password'                            = 'dbpassword'
    ,'database-name'                       = 'demog'
    ,'schema-name'                         = 'public'
    ,'table-name'                          = 'accountholders'
    ,'slot.name'                           = 'accountholders_paimon'
    -- experimental feature: incremental snapshot (default off)
    ,'scan.incremental.snapshot.enabled'   = 'true'               -- experimental feature: incremental snapshot (default off)
    ,'scan.startup.mode'                   = 'initial'            -- https://nightlies.apache.org/flink/flink-cdc-docs-release-3.1/docs/connectors/flink-sources/postgres-cdc/#startup-reading-position     ,'decoding.plugin.name'                = 'pgoutput'
    ,'decoding.plugin.name'                = 'pgoutput'
);

CREATE OR REPLACE TABLE c_cdcsource.demog.transactions_iceberg (
     _id                    BIGINT              NOT NULL
    ,eventid                VARCHAR(36)         NOT NULL
    ,transactionid          VARCHAR(36)         NOT NULL
    ,eventtime              VARCHAR(30)
    ,direction              VARCHAR(8)
    ,payernationalid        VARCHAR(16)
    ,payeraccount           STRING
    ,payeenationalid        VARCHAR(16)
    ,payeeaccount           STRING
    ,amount                 STRING
    ,created_at             TIMESTAMP_LTZ(3)
    ,WATERMARK              FOR created_at AS created_at - INTERVAL '15' SECOND
    ,PRIMARY KEY (_id) NOT ENFORCED
) WITH (
     'connector'                           = 'postgres-cdc'
    ,'hostname'                            = 'postgrescdc'
    ,'port'                                = '5432'
    ,'username'                            = 'dbadmin'
    ,'password'                            = 'dbpassword'
    ,'database-name'                       = 'demog'
    ,'schema-name'                         = 'public'
    ,'table-name'                          = 'transactions'
    ,'slot.name'                           = 'transactions_iceberg'
    -- experimental feature: incremental snapshot (default off)
    ,'scan.incremental.snapshot.enabled'   = 'true'               -- experimental feature: incremental snapshot (default off)
    ,'scan.startup.mode'                   = 'initial'            -- https://nightlies.apache.org/flink/flink-cdc-docs-release-3.1/docs/connectors/flink-sources/postgres-cdc/#startup-reading-position     ,'decoding.plugin.name'                = 'pgoutput'
    ,'decoding.plugin.name'                = 'pgoutput'
);

CREATE OR REPLACE TABLE c_cdcsource.demog.transactions_paimon (
     _id                    BIGINT              NOT NULL
    ,eventid                VARCHAR(36)         NOT NULL
    ,transactionid          VARCHAR(36)         NOT NULL
    ,eventtime              VARCHAR(30)
    ,direction              VARCHAR(8)
    ,payernationalid        VARCHAR(16)
    ,payeraccount           STRING
    ,payeenationalid        VARCHAR(16)
    ,payeeaccount           STRING
    ,amount                 STRING
    ,created_at             TIMESTAMP_LTZ(3)
    ,WATERMARK              FOR created_at AS created_at - INTERVAL '15' SECOND
    ,PRIMARY KEY (_id) NOT ENFORCED
) WITH (
     'connector'                           = 'postgres-cdc'
    ,'hostname'                            = 'postgrescdc'
    ,'port'                                = '5432'
    ,'username'                            = 'dbadmin'
    ,'password'                            = 'dbpassword'
    ,'database-name'                       = 'demog'
    ,'schema-name'                         = 'public'
    ,'table-name'                          = 'transactions'
    ,'slot.name'                           = 'transactions_paimon'
    -- experimental feature: incremental snapshot (default off)
    ,'scan.incremental.snapshot.enabled'   = 'true'               -- experimental feature: incremental snapshot (default off)
    ,'scan.startup.mode'                   = 'initial'            -- https://nightlies.apache.org/flink/flink-cdc-docs-release-3.1/docs/connectors/flink-sources/postgres-cdc/#startup-reading-position     ,'decoding.plugin.name'                = 'pgoutput'
    ,'decoding.plugin.name'                = 'pgoutput'
);

################################################################################################################################################

-- now see 3.1.creTarget.sql
