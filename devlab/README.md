
### Boot strapping our environment.

From within `<Project root>/devlab/`

We can take the environment through various phases. 

- `make build` 

- `make run`

This will bring up our basic Flink Cluster and supporting PostgreSQL and MinIO service.
Play time now

- `make down`

### Genrate data

You can run the data generator. this is done by running `<Project Root>/shadowtraffic/run_pg.sh`


### Prepare Tables and catalogs

At this point read `devlab/creFlinkFlows `and execute/create our catalogs and tables.

To create our tables and the data movement, see `<Project Root>/devlab/creFlinkFlows/README.md`. This will list the scripts to be executed that will create our:

-  Catalogs: 

   -  `c_cdcsource`

   -  `c_iceberg_jdbc` 

   -  `c_paimon_jdbc`

-  Flink CDC Sourced tables

   - accountholders_iceberg

   - transactions_iceberg

   - accountholders_paimon

   - transactions_paimon

-  Create our Apache Iceberg and Apache Paimon Tables and the Inserts using a CTAS (Create Table <destination> as Select * from <source>)


  
