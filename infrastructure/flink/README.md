## Building our Primary Flink Contaier

We have various version options that can be build, see the flink/Dockerfile for the possible variables to set. Keep in mind they need to match the Apache Flink stack.

### 1. Build combinations

You will notice in the Dockerfile I don't like to hard code versions. Once we get the stack working using variables make it easy to just change what needs to be changed and everything else will fit/fall together.

- Apache Flink 1.20.1
- Apache Iceberg 1.9.1
- Apache Paimon 1.3.1
- Apache Flink CDC 3.5.0
- PostgreSQL Connetor 42.7.6
- Hadoop S3 Libraries 2.8.3 

### 2. Container tag:

- Modify the IMAGE_NAME at the top of the Makefile

  - IMAGE_NAME=apacheflink-base-1.20.1-scala_2.12-java17

  or i.e.:

  - IMAGE_NAMEapacheflink-base-1.20.2-scala_2.12-java17


- Then modify the `image:<name>` in the `devlab/docker-compose-flink.yaml `for the jobmanager and taskmanager service

  - image:apacheflink-base-1.20.1-scala_2.12-java17

  or

  - image: apacheflink-base-1.20.2-scala_2.12-java17


### 3. Building New Apache Flink Container

- `make pull`

- `make build`