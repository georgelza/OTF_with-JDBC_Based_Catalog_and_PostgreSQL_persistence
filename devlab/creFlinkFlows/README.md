
## Table/Objects Structures

### 1.1.creCat.sql

Will create the various catalogs and databases.

 - postgres_catalog - Generic InMemory
   - demog

 - c_iceberg_jdbc - Apache Iceberg Catalog
   - finflow

 - c_paimon_jdbc - Apache Paimon Catalog
   - finflow

### 2.1.creCdc.sql

This will create our transciant CDC based tables which will connect to our PostgreSQL datastore and expose data using the Flink CDC capabilities

 - accountholders_iceberg

 - accountholders_paimon

 - transactions _iceberg

 - transactions_paimon

I found giving each it's own source table to provide a more stable deployment.


### 3.2.creTarget.sql

???
s


