
## Boot strapping our environment.

From within `<Project root>/devlab/`

We can take the environment through various phases. 

- Our `devlab/creFlinkFlows/1.1.creCat.sql` script also provides the required command to create Apache Iceberg and Apache Paimon based catalog.
 
- If you want, you can deploy the Apache Flink Cluster, allowing you move data across the Flink stack and additionally the accompanying PyFlink routines that will calculate vector embedding values for the accountholders and transactions. These values will be pushed as a new record into accountholder_embed and transactions_embed tables (which will be stored in either Apache Iceberg or Apache Paimon: still need to decide).
  

`make run`

This will bring up our basic Flink Cluster and supporting PostgreSQL and MinIO service.


### Prepare Tables and catalogs

At this point read `devlab/creFlinkFlows `and execute/create our catalogs and tables.

Once you have the supporting tables. You can run the data generator. this is done by running `shadowtraffic/run_pg.sh`

