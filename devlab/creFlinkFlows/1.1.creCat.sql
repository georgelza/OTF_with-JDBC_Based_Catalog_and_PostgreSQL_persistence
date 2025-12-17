
USE CATALOG default_catalog;
  
-- Inbound from PostgreSQL via CDC Process
CREATE CATALOG c_cdcsource WITH 
    ('type'='generic_in_memory'); 


CREATE DATABASE IF NOT EXISTS c_cdcsource.demog;  

-- Apache Iceberg based Catalog stored inside PostgreSQL database using JDBC interface
-------------------------------------------------------------------------------------------------------------------------
-- server: postgrescat
-- db: flink_catalog
-- schema: iceberg_jdbc
CREATE CATALOG c_iceberg_jdbc WITH (
   'type'                      = 'iceberg'
  ,'catalog-impl'              = 'org.apache.iceberg.jdbc.JdbcCatalog'

  -- PostgreSQL connection details
  ,'uri'                       = 'jdbc:postgresql://postgrescat:5432/flink_catalog?currentSchema=iceberg_jdbc'
  ,'jdbc.user'                 = 'dbadmin'
  ,'jdbc.password'             = 'dbpassword'
  ,'jdbc.driver'               = 'org.postgresql.Driver'

  -- Data warehouse location (can be S3, HDFS, or local)
  ,'warehouse'                 = 's3a://warehouse/iceberg_jdbc'

  -- S3 connection details / For Iceberg we need to use s3a.* in combination with specific jar files. Ask Robin Moffat re Jar files ;( 
  ,'s3a.endpoint'              = 'http://minio:9000'
  ,'s3a.access-key-id'         = 'mnadmin'
  ,'s3a.secret-access-key'     = 'mnpassword'
  ,'s3a.path-style-access'     = 'true'

  ,'table-default.file.format' = 'parquet'
);

USE CATALOG c_iceberg_jdbc;
CREATE DATABASE IF NOT EXISTS c_iceberg_jdbc.finflow;

-- Paimon based Catalog stored inside PostgreSQL database using JDBC interface
-------------------------------------------------------------------------------------------------------------------------
-- server: postgrescat
-- db: flink_catalog
-- schema: paimon_jdbc
CREATE CATALOG c_paimon_jdbc WITH (
   'type'                       = 'paimon'
  ,'metastore'                  = 'jdbc'                       -- JDBC Based Catalog

  -- PostgreSQL connection details
  ,'catalog-key'                = 'jdbc'
  ,'uri'                        = 'jdbc:postgresql://postgrescat:5432/flink_catalog?currentSchema=paimon_jdbc'
  ,'jdbc.user'                  = 'dbadmin'
  ,'jdbc.password'              = 'dbpassword'
  ,'jdbc.driver'                = 'org.postgresql.Driver'

  -- Data warehouse location (can be S3, HDFS, or local)
  ,'warehouse'                  = 's3://warehouse/paimon_jdbc'      -- bucket / datastore

  -- S3 connection details
  ,'s3.endpoint'                = 'http://minio:900'
  ,'s3.access-key-id'           = 'mnadmin'
  ,'s3.secret-access-key'       = 'mnpassword'
  ,'s3.path-style-access'       =' true'

  ,'table-default.file.format'  = 'parquet'
);

USE CATALOG c_paimon_jdbc;
CREATE DATABASE IF NOT EXISTS c_paimon_jdbc.finflow;


-- next execute 2.1

-- next execute 3.1