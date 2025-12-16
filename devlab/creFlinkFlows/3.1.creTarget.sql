
SET 'execution.checkpointing.interval'   = '60s';

SET 'table.exec.sink.upsert-materialize' = 'NONE';

################################################################################################################################################

SET 'pipeline.name' = 'Persist into Paimon-JDBC: accountholders table';

CREATE OR REPLACE TABLE c_paimon_jdbc.finflow.accountholders WITH (
     'file.format'                       = 'parquet'
    ,'compaction.min.file-num'           = '2'
    ,'compaction.early-max.file-num'     = '50'
    ,'snapshot.time-retained'            = '1h'
    ,'snapshot.num-retained.min'         = '5'
    ,'snapshot.num-retained.max'         = '20'
    ,'table.exec.sink.upsert-materialize'= 'NONE'
) AS 
SELECT * FROM c_cdcsource.demog.accountholders;


################################################################################################################################################

SET 'execution.checkpointing.interval'   = '60s';

SET 'pipeline.name' = 'Persist into Iceberg-JDBC: accountholders table';

CREATE OR REPLACE TABLE c_iceberg_jdbc.finflow.accountholders AS 
    SELECT * FROM c_cdcsource.demog.accountholders_iceberg;

SET 'pipeline.name' = 'Persist into Paimon-JDBC: accountholders table';

CREATE OR REPLACE TABLE c_paimon_jdbc.finflow.accountholders AS 
    SELECT * FROM c_cdcsource.demog.accountholders_paimon;


CREATE OR REPLACE TABLE c_iceberg_jdbc.finflow.accountholders WITH (
     'file.format'                       = 'parquet'
    ,'compaction.min.file-num'           = '2'
    ,'compaction.early-max.file-num'     = '50'
    ,'snapshot.time-retained'            = '1h'
    ,'snapshot.num-retained.min'         = '5'
    ,'snapshot.num-retained.max'         = '20'
    ,'table.exec.sink.upsert-materialize'= 'NONE'
) AS 
SELECT * FROM c_cdcsource.demog.accountholders;


################################################################################################################################################

SET 'pipeline.name' = 'Persist into Ice-JDBC: transactions table';

CREATE OR REPLACE TABLE c_iceberg_jdbc.finflow.transactions WITH (
     'file.format'                       = 'parquet'
    ,'compaction.min.file-num'           = '2'
    ,'compaction.early-max.file-num'     = '50'
    ,'snapshot.time-retained'            = '1h'
    ,'snapshot.num-retained.min'         = '5'
    ,'snapshot.num-retained.max'         = '20'
    ,'table.exec.sink.upsert-materialize'= 'NONE'
) AS 
SELECT * FROM c_cdcsource.demog.transactions;


################################################################################################################################################

SET 'pipeline.name' = 'Persist into Iceberg: accountholders table';

CREATE OR REPLACE TABLE c_iceberg.finflow.accountholders AS 
    SELECT * FROM c_cdcsource.demog.accountholders;


CREATE OR REPLACE TABLE c_iceberg.finflow.accountholders WITH (
     'file.format'                       = 'parquet'
    ,'compaction.min.file-num'           = '2'
    ,'compaction.early-max.file-num'     = '50'
    ,'snapshot.time-retained'            = '1h'
    ,'snapshot.num-retained.min'         = '5'
    ,'snapshot.num-retained.max'         = '20'
    ,'table.exec.sink.upsert-materialize'= 'NONE'
) AS 
SELECT * FROM c_cdcsource.demog.accountholders;


################################################################################################################################################

SET 'pipeline.name' = 'Persist into Iceberg: transactions table';

CREATE OR REPLACE TABLE c_iceberg.finflow.transactions WITH (
     'file.format'                       = 'parquet'
    ,'compaction.min.file-num'           = '2'
    ,'compaction.early-max.file-num'     = '50'
    ,'snapshot.time-retained'            = '1h'
    ,'snapshot.num-retained.min'         = '5'
    ,'snapshot.num-retained.max'         = '20'
    ,'table.exec.sink.upsert-materialize'= 'NONE'
) AS 
SELECT * FROM c_cdcsource.demog.transactions;
