
## Table/Objects Structures

### 1.1.creCat.sql

Will create the various catalogs and databases.

 - `c_cdcsource` - Generic InMemory

   - `demog`

 - `c_iceberg_jdbc` - Apache Iceberg Catalog

   - `finflow`

 - `c_paimon_jdbc` - Apache Paimon Catalog

   - `finflow`


### 2.1.creCdc.sql

This will create our transciant CDC based tables which will connect to our PostgreSQL datastore and expose data using the Flink CDC capabilities

These tables reside in the `c_cdcsource` catalog;

 - accountholders_iceberg

 - transactions _iceberg

 - accountholders_paimon

 - transactions_paimon

I found giving each it's own source table to provide a more stable deployment.


### 3.2.creTarget.sql

We create our target/desitation tables using the CTAS pattern

These tables reside in the `c_iceberg_jdbc` and `c_paimon_jdbc` catalogs;
 
 - accountholders_iceberg

 - transactions _iceberg

 - accountholders_paimon

 - transactions_paimon

