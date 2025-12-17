.DEFAULT_GOAL := help
include ../.env

FLINK_VERSION_FULL=1.20.1
FLINK_VERSION_SHORT=1.20
ICEBERG_VERSION=1.9.1
HADOOP_VERSION=3.3.4
POSTGRESQL_CONNECTOR=42.7.6
FLINK_CDC=3.5.0
PAIMON_VERSION=1.3.1
JDBC_VERSION=3.3.0

IMAGE_NAME=apacheflink-base-${FLINK_VERSION_FULL}-scala_2.12-java17
VERSION=1.0.0

define HELP

Available commands:

- pull:  Pull/wget all jar's

- build: Build this project

endef

export HELP
help:
	@echo "$$HELP"
.PHONY: help

build: 
	@echo "🔨 Building Apache Flink 1.20.1 - Iceberg 1.9.1 Docker images..."
	docker build --build-arg REPO_NAME=${REPO_NAME} -t ${REPO_NAME}/${IMAGE_NAME}:${VERSION} --file Dockerfile . --no-cache
	@echo "✅ Apache Flink Docker image built ${IMAGE_NAME}:${VERSION} successfully"


pull: paimon iceberg misc
	cd stage; wget https://repo1.maven.org/maven2/org/apache/flink/flink-sql-connector-postgres-cdc/3.5.0/flink-sql-connector-postgres-cdc-3.5.0.jar \
	cd stage; wget https://repo.maven.apache.org/maven2/org/apache/flink/flink-sql-parquet/1.20.1/flink-sql-parquet-1.20.1.jar 


paimon:
	cd stage; wget https://repo1.maven.org/maven2/org/apache/paimon/paimon-s3/1.3.1/paimon-s3-1.3.1.jar \
	cd stage; wget https://repo1.maven.org/maven2/org/apache/paimon/paimon-flink-1.20/1.3.1/paimon-flink-1.20-1.3.1.jar


iceberg:
	cd stage; wget https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-flink-runtime-1.20/1.9.1/iceberg-flink-runtime-1.20-1.9.1.jar


misc:
	cd stage; wget https://repo1.maven.org/maven2/org/apache/commons/commons-configuration2/2.1.1/commons-configuration2-2.1.1.jar \
	cd stage; wget https://repo1.maven.org/maven2/commons-logging/commons-logging/1.1.3/commons-logging-1.1.3.jar \
	cd stage; wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-auth/3.3.4/hadoop-auth-3.3.4.jar \
	cd stage; wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-common/3.3.4/hadoop-common-3.3.4.jar \
	cd stage; wget https://repo1.maven.org/maven2/org/apache/hadoop/thirdparty/hadoop-shaded-guava/1.1.1/hadoop-shaded-guava-1.1.1.jar \
	cd stage; wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.4/hadoop-aws-3.3.4.jar \
	cd stage; wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-hdfs-client/3.3.4/hadoop-hdfs-client-3.3.4.jar \
	cd stage; wget https://repo1.maven.org/maven2/org/codehaus/woodstox/stax2-api/4.2.1/stax2-api-4.2.1.jar \
	cd stage; wget https://repo1.maven.org/maven2/com/fasterxml/woodstox/woodstox-core/5.3.0/woodstox-core-5.3.0.jar \
	cd stage; wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.12.262/aws-java-sdk-bundle-1.12.262.jar \
    cd stage; wget https://repo1.maven.org/maven2/org/postgresql/postgresql/42.7.6/postgresql-42.7.6.jar 

 