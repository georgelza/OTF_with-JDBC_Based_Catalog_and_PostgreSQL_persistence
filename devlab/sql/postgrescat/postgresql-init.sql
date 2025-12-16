
-- 1. Apache Flink with JDBC Catalog for Apache Paimon Datastore

GRANT ALL PRIVILEGES ON DATABASE flink_catalog TO dbadmin;

-- psql -h localhost -p 5432 -U dbadmin -d flink_catalog

-- Schema that will house our Flink / Paimon JDBC catalogs
CREATE SCHEMA IF NOT EXISTS paimon_jdbc AUTHORIZATION dbadmin;

-- Grant permissions to the catalog user
GRANT ALL PRIVILEGES ON SCHEMA paimon_jdbc TO dbadmin;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA paimon_jdbc TO dbadmin;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA paimon_jdbc TO dbadmin;

-- Set default privileges for future objects
ALTER DEFAULT PRIVILEGES IN SCHEMA paimon_jdbc GRANT ALL ON TABLES TO dbadmin;
ALTER DEFAULT PRIVILEGES IN SCHEMA paimon_jdbc GRANT ALL ON SEQUENCES TO dbadmin;

COMMENT ON SCHEMA paimon_jdbc IS 'Flink / Apache Paimon JDBC Catalog Storage';


-- 1. Apache Flink with JDBC Catalog for Apache Iceberg Datastore

GRANT ALL PRIVILEGES ON DATABASE flink_catalog TO dbadmin;

-- psql -h localhost -p 5432 -U dbadmin -d flink_catalog

-- Schema that will house our Flink / Paimon JDBC catalogs
CREATE SCHEMA IF NOT EXISTS iceberg_jdbc AUTHORIZATION dbadmin;

-- -- Grant permissions to the catalog user
GRANT ALL PRIVILEGES ON SCHEMA iceberg_jdbc TO dbadmin;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA iceberg_jdbc TO dbadmin;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA iceberg_jdbc TO dbadmin;

-- Set default privileges for future objects
ALTER DEFAULT PRIVILEGES IN SCHEMA iceberg_jdbc GRANT ALL ON TABLES TO dbadmin;
ALTER DEFAULT PRIVILEGES IN SCHEMA iceberg_jdbc GRANT ALL ON SEQUENCES TO dbadmin;

COMMENT ON SCHEMA iceberg_jdbc IS 'Flink / Apache Iceberg JDBC Catalog Storage';