
## Boot strapping our environment.

From within `<Project root>/devlab/`

We can take the environment through various phases. 

- If you only want to explore Apache Polaris then simply execute the run_basic stack.
This will provide you with a Polaris Catalog, backed by PostgreSQL. The process will also create a catalog called `icebergcat`. In this you can then create a namespace `fraud` or `finflow` using the API command as per `devlab/polaris/README.md`

- Our `devlab/creFlinkFlows/1.1.creCat.sql` script also provides the required command to create Paimon based catalog.
- 
- If you want, you can deploy the Apache Flink Cluster, allowing you move data across the Flink stack and additionally the accompanying PyFlink routines that will calculate vector embedding values for the accountholders and transactions. These values will be pushed as a new record into accountholder_embed and transactions_embed tables (which will be stored in either Apache Iceberg or Apache Paimon: still need to decide).

- From here we can run a Insert statement pushing the records into an Apache Fluss catalog/table, configured to Lakehouse tier down into either Apache Iceberg or Apache Paimon.

- The data movement for this tiering is executed by executing `devlab/flusss/tier*.sh` scripts inside the jobmanager container (execute `make jm` to get access to the Flink Jobmanager cli).
  
  
### Basic

`make run_basic`

This will bring up our basic Polaris Catalog and supporting PostgreSQL and MinIO service.

### Flink

`make run_flink`

This will bring up our basic Flink Cluster, Polaris Catalog and supporting PostgreSQL and MinIO service.


### Prepare Tables and catalogs

At this point read `devlab/creFlinkFlows `and execute/create our catalogs and tables.

Once you have the supporting tables. You can run the data generator. this is done by running `shadowtraffic/run_pg.sh`



