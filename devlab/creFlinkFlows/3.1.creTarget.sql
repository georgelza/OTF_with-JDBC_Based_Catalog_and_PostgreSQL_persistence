
SET 'execution.checkpointing.interval'   = '60s';

SET 'table.exec.sink.upsert-materialize' = 'NONE';

################################################################################################################################################

SET 'execution.checkpointing.interval'   = '60s';

SET 'pipeline.name' = 'Persist into Iceberg-JDBC: accountholders table';

CREATE OR REPLACE TABLE c_iceberg_jdbc.finflow.accountholders AS 
    SELECT * FROM c_cdcsource.demog.accountholders_iceberg;

SET 'pipeline.name' = 'Persist into Iceberg-JDBC: transactions table';

CREATE OR REPLACE TABLE c_iceberg_jdbc.finflow.transactions AS 
    SELECT * FROM c_cdcsource.demog.transactions_iceberg;

################################################################################################################################################


SET 'execution.checkpointing.interval'   = '60s';

SET 'pipeline.name' = 'Persist into Paimon-JDBC: accountholders table';

CREATE OR REPLACE TABLE c_paimon_jdbc.finflow.accountholders AS 
    SELECT * FROM c_cdcsource.demog.accountholders_paimon;

SET 'pipeline.name' = 'Persist into Paimon-JDBC: transactions table';

CREATE OR REPLACE TABLE c_paimon_jdbc.finflow.transactions AS 
    SELECT * FROM c_cdcsource.demog.transactions_paimon;