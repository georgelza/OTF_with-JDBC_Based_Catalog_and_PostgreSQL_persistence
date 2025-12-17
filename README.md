## Apache Iceberg and Apache Paimon Tables Apache Flink with JDBC based Catalog implimentation, back'd by Postgres for persistence


Just Decided, want to see whats involved to configure a Unified Catalog, or make that as close as possible, and as close as possible for me here meant One database `flink_catalog` with 2 schema's (`iceberg_jdbc` and `paimon_jdbc`), interfaced with from Apache Flink using JDBC using the `'catalog-impl' = 'org.apache.iceberg.jdbc.JdbcCatalog'` syntax as part of your catalog create sql, see `<Project Root>/devlab/creFlinkFlows/1.1creCat.sql`


### Now back to our scheduled programming:  ;)

The requirement originally started with me creating a application which created two data products using [ShadowTraffic](https://docs.shadowtraffic.io) 

- `accountholders`

- `transactions`


These data products are inserted into our Postgres database called `demog`, which is hosted by our postgrescdc docker-compse based service.

The plan is then to consume this data stream from PostgreSQL into [Apache Flink](https://flink.apache.org) using the [Apache Flink CDC framework](https://nightlies.apache.org/flink/flink-cdc-docs-stable/). This is accomplished by defining 2 tables inside Apache Flink, referncing our Postgres database/tables.

From here we can then work with this data. This would normally be via either Java based jobs, Python based jobs via PyFlink framework or using Apache Flink SQL.

The output of these processing step are records insert into a Lakehouse tables, referred to as an Open Table Formats, the most popular being:

- Apache Iceberg

- Apache Paimon

- Apache Hudi

- ...

Now, a phone book, ye I'm old enough to know what thye looked like was useless without the index at the back. That index was a sort of catalog of the records contained in the book, 

The index in the back was our "reference" of what tables/records are in our book and where to find them. 

And thats what a catalog does for us, it keeps track of our tables, their structures, storage location, access rules, other words, metadata etc. 

All this allows one user to create tables inside a database in one session and makes this available to another user in a different session to access that table and the contents, using the processing engine of choice.

In the past, I use to use [Hive Metastore (HMS)](https://hive.apache.org)/see Central Metastore Catalog. 

But lets see, I like rabit holes so decided to mix things up a bit, or was that I wanted to simplify the stack (HMS is tech heavy), and here we are, lets try and use an JDBC based Catalog with PostgreSQL providing persistence for our Apache Iceberg and Apache Paimon Open Table format Lakehouse Tables.


BLOG: [Apache Iceberg and Apache Paimon utilizing JDBC based Catalog with PostgreSQL for Persistence.](https://medium.com/@georgelza/apache-iceberg-and-apache-paimon-utilizing-jdbc-based-catalog-with-postgresql-for-persistence-8008ace4d794)


GIT REPO: [Open Table Formats (Apache Iceberg and Apache Paimon) with JDBC based Catalog backed by PostgreSQL for Persistence](https://github.com/georgelza/OTF_with-JDBC_Based_Catalog_and_PostgreSQL_persistence.git)


## About our Stack:

### Overview

The stack goes through 3 phases, if we can call it that:


- [Apache Flink 1.20.1](https://flink.apache.org) cluster, enabling us to define our catalog, create a Flink database and create tables inside our database homed inside our catalog.

- PostgreSQL Database for persistent store for the JDBC based catalogs.
  
- MinIO for object storage of our Apache Iceberg and Apache Paimon tables.

We will be utilizing [Shadowtraffic](https://docs.shadowtraffic.io) to generate our data, Shadowtraffic as configured via `<Project Root>/shadowtraffic/conf/config.json` will be creating 2 dat artifacts, accountHolders and Transactions, these willbe inserted into a PostgreSQL datastore, from whee will will utilize Apache Flink CDC to consume the data into Apache Flink.


## Building and Running the environment

You're reading this file, under this directory is our `devlab`, `infrastructure` and `shadowtraffic` sub directories.

- `devlab` contains all our code to run the projects.

- `infrastructure` is where our Dockerfile's are used to build the environment, in addition to Makefiles that can be used to pull and wget all the source docker containers and additional modules.

- `shadowtraffic` contains our data generator/config file.
  
You will also found a configuration file used to provide various environment variables as used by our Docker-compose projects in `devlab/.env`.

Our environment can be build and brough online using `devlab/Makefile`:

The first time you start the project, we need to pull and build the required containers, this can be done by:


### 1. via devlab ...

- `cd ../devlab`

- `make build`

or


### 2. via infrastructure ...

-  `cd infrastructure`
-  `make pull`
-  `make build`


At this point we can startup the minimum environment to make sure our **Postgres datastores are running** as well as our **MinIO** object store.


## Run the Stack


1. Full Environment (Flink, Postgres and MinIO), which will use `<Project Root>/devlab/docker-compose.yml`

   - cd `<Project Root>/devlab`

   - `make run`

   - cd `<Project Root>/shadowtraffic` 

   - run shadowtraffic by executing `run_pg.sh`

   - cd `<Project Root>/devlab`.

   - Create our catalogs and tables by executing the SQL contained in `<Project Root>/devlab/creFlinkFlows`
     - 1.1.creCat.sql
     - 2.1.creCdc.sql
     - 3.1.creTarget.sql

At this point you have a stream of data, source by Apache Flink CDC stack, you have 2 catalogs, based on Apache Iceberg and Apache Paimon, cataloged using JDBC interface, with PostgreSQL for persistence and a S3 based object store backing the Lakehouse tables created.


   - `make down`


### Notess

During the startup cycle of our PostgreSQL datastore's, they will go through their standard bootstrap process which happens to include creating a database. If you want to create some personal bits, modify this process then you are able to place your desired SQL inside postgresql-init.sq which is mapped/mounted into the PostgreSQL container and run at startup.

For our datastore used for Shadowtraffic, I've placed SQL in the above script to create the following 2 tables, they will be used as target tables for ShadowTraffic and also be our source tables for Apache Flink CDC (note, I could have opted to simply have ShadowTraffic create these tables itself, but I like to do things more in line with how things happen in a production realm). For now these tables are located in a database called `demog` inside the `public` schema.

- `accountholders` 

- `transactions`
  

### Management interfaces

- Flink UI: http://localhost:8084 (Console)
- MinIO API: http://localhost:9000 (Client API)
- MinIO UI: http://localhost:9001 (Console, mnadmin/mnpassword)
  

## Software/package versions

The following stack is deployed using one of the provided  `<Project Root>/devlab/docker-compose.yaml` files as per above.


- [Apache Flink 1.20.1](https://flink.apache.org)                   
  
- [Apache Flink CDC 3.5.0](https://nightlies.apache.org/flink/flink-cdc-docs-release-3.5/)

- [Apache Iceberg 1.9.1](https://iceberg.apache.org)

- [Apache Paimon 1.3.1](https://paimon.apache.orc)

- [PostgreSQL 12](https://www.postgresql.org)

- [MinIO](https://www.min.io) - Project has gone into Maintenance mode... 

- [Shadowtraffic](https://docs.shadowtraffic.io)


## By: George Leonard

- georgelza@gmail.com
- https://www.linkedin.com/in/george-leonard-945b502/
- https://medium.com/@georgelza


## Appendix

### References / Additional Reading

- [Writing to Apache Iceberg on S3 Using Flink SQL with Glue catalog](https://rmoff.net/2025/06/24/writing-to-apache-iceberg-on-s3-using-flink-sql-with-glue-catalog/#_jar_location)
    
- And as always, always good to go have a look at his examples, definitely assisted me, [Robbin Moffat Examples](https://github.com/rmoff/examples/tree/main)