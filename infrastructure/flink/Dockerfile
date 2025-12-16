FROM arm64v8/flink:1.20.1-scala_2.12-java17
SHELL ["/bin/bash", "-c"]

ENV FLINK_HOME=/opt/flink
ENV HIVE_HOME=$FLINK_HOME/conf/

ENV FLINK_VERSION_SHORT=1.20
ENV FLINK_VERSION_FULL=1.20.1
ENV ICEBERG_VERSION=1.9.1
ENV HADOOP_VERSION=3.3.4
ENV POSTGRESQL_CONNECTOR=42.7.6
ENV FLINK_CDC=3.5.0
ENV PAIMON_VERSION=1.3.1

WORKDIR $FLINK_HOME

RUN echo "--> Setup Directory Structure" && \
    mkdir -p ${FLINK_HOME}/conf/ && \
    mkdir -p ${FLINK_HOME}/checkpoints && \
    mkdir -p ${FLINK_HOME}/rocksdb 

RUN echo "--> Install JARs: Flink's S3 plugin" && \
    mkdir -p ./plugins/s3-fs-hadoop && \
    mv ./opt/flink-s3-fs-hadoop-${FLINK_VERSION_FULL}.jar ./plugins/s3-fs-hadoop/

RUN echo "-> Install JARs: Postgres ${POSTGRESQL_CONNECTOR} Driver and Flink CDC ${FLINK_CDC} Postgres connector" && \
    mkdir -p ./lib/jdbc

COPY stage/flink-sql-connector-postgres-cdc-${FLINK_CDC}.jar                        ${FLINK_HOME}/lib/jdbc/flink-sql-connector-postgres-cdc-${FLINK_CDC}.jar 
COPY stage/postgresql-${POSTGRESQL_CONNECTOR}.jar                                   ${FLINK_HOME}/lib/jdbc/postgresql-${POSTGRESQL_CONNECTOR}.jar 

RUN echo "-> Install JARs: Dependencies for Iceberg ${ICEBERG_VERSION}" && \
    mkdir -p ./lib/iceberg

    COPY stage/iceberg-flink-runtime-${FLINK_VERSION_SHORT}-${ICEBERG_VERSION}.jar  ${FLINK_HOME}/lib/iceberg/iceberg-flink-runtime-${FLINK_VERSION_SHORT}-${ICEBERG_VERSION}.jar
COPY stage/iceberg-aws-bundle-${ICEBERG_VERSION}.jar                                ${FLINK_HOME}/lib/iceberg/iceberg-aws-bundle-${ICEBERG_VERSION}.jar

RUN echo "-> Install JARs: Flink ${FLINK_VERSION_FULL} Generic" 
COPY stage/flink-sql-parquet-${FLINK_VERSION_FULL}.jar                              ${FLINK_HOME}/lib/flink-sql-parquet-${FLINK_VERSION_FULL}.jar

# RUN echo "-> Install JARs: Hadoop" && \
#     mkdir -p ./lib/hadoop 
# COPY stage/commons-configuration2-2.1.1.jar                                 ${FLINK_HOME}/lib/commons-configuration2-2.1.1.jar
# COPY stage/commons-logging-1.1.3.jar                                        ${FLINK_HOME}/lib/commons-logging-1.1.3.jar 
# COPY stage/hadoop-auth-${HADOOP_VERSION}.jar                                ${FLINK_HOME}/lib/hadoop-auth-${HADOOP_VERSION}.jar
# COPY stage/hadoop-common-${HADOOP_VERSION}.jar                              ${FLINK_HOME}/lib/hadoop-common-${HADOOP_VERSION}.jar
# COPY stage/hadoop-shaded-guava-1.1.1.jar                                    ${FLINK_HOME}/lib/hadoop-shaded-guava-1.1.1.jar
# COPY stage/stax2-api-4.2.1.jar                                              ${FLINK_HOME}/lib/stax2-api-4.2.1.jar
# COPY stage/woodstox-core-5.3.0.jar                                          ${FLINK_HOME}/lib/woodstox-core-5.3.0.jar 
# COPY stage/hadoop-hdfs-client-${HADOOP_VERSION}.jar                         ${FLINK_HOME}/lib/hadoop-hdfs-client-${HADOOP_VERSION}.jar
# COPY stage/hadoop-mapreduce-client-core-${HADOOP_VERSION}.jar               ${FLINK_HOME}/lib/hadoop-mapreduce-client-core-${HADOOP_VERSION}.jar
# COPY stage/hadoop-aws-${HADOOP_VERSION}.jar                                 ${FLINK_HOME}/lib/hadoop-aws-${HADOOP_VERSION}.jar 
# COPY stage/aws-java-sdk-bundle-1.12.262.jar                                 ${FLINK_HOME}/lib/aws-java-sdk-bundle-1.12.262.jar

# Excuse... still trying to figure out why when using the above I have errors, but when using the below it works...
RUN echo "-> Install JARs: Hadoop ${HADOOP_VERSION}" && \
    mkdir -p ./lib/hadoop && pushd $_ && \
    curl https://repo1.maven.org/maven2/org/apache/commons/commons-configuration2/2.1.1/commons-configuration2-2.1.1.jar -O && \
    curl https://repo1.maven.org/maven2/commons-logging/commons-logging/1.1.3/commons-logging-1.1.3.jar -O && \
    curl https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-auth/${HADOOP_VERSION}/hadoop-auth-${HADOOP_VERSION}.jar -O && \
    curl https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-common/${HADOOP_VERSION}/hadoop-common-${HADOOP_VERSION}.jar -O && \
    curl https://repo1.maven.org/maven2/org/apache/hadoop/thirdparty/hadoop-shaded-guava/1.1.1/hadoop-shaded-guava-1.1.1.jar -O && \
    curl https://repo1.maven.org/maven2/org/codehaus/woodstox/stax2-api/4.2.1/stax2-api-4.2.1.jar -O && \
    curl https://repo1.maven.org/maven2/com/fasterxml/woodstox/woodstox-core/5.3.0/woodstox-core-5.3.0.jar -O && \
    curl https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-hdfs-client/${HADOOP_VERSION}/hadoop-hdfs-client-${HADOOP_VERSION}.jar -O && \
    curl https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-mapreduce-client-core/${HADOOP_VERSION}/hadoop-mapreduce-client-core-${HADOOP_VERSION}.jar -O && \
    curl https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/${HADOOP_VERSION}/hadoop-aws-${HADOOP_VERSION}.jar -O && \
    curl https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.12.262/aws-java-sdk-bundle-1.12.262.jar -O && \
    popd


RUN echo "--> Install JARs: => Paimon ${PAIMON_VERSION}" && \
    mkdir -p ./lib/paimon
COPY stage/paimon-flink-${FLINK_VERSION_SHORT}-${PAIMON_VERSION}.jar        ${FLINK_HOME}/lib/paimon/paimon-flink-${FLINK_VERSION_SHORT}-${PAIMON_VERSION}.jar
COPY stage/paimon-s3-${PAIMON_VERSION}.jar                                  ${FLINK_HOME}/lib/paimon/paimon-s3-${PAIMON_VERSION}.jar

# ADD THIS NEW SECTION HERE
### TRYING EVERYTHING TO GET IT WORKING...
RUN echo "-> Create Hadoop Configuration" && \
    cat > ${FLINK_HOME}/conf/core-site.xml <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
    <property>
        <name>fs.s3a.endpoint</name>
        <value>http://minio:9000</value>
    </property>
    <property>
        <name>fs.s3a.access.key</name>
        <value>mnadmin</value>
    </property>
    <property>
        <name>fs.s3a.secret.key</name>
        <value>mnpassword</value>
    </property>
    <property>
        <name>fs.s3a.path.style.access</name>
        <value>true</value>
    </property>
    <property>
        <name>fs.s3a.connection.ssl.enabled</name>
        <value>false</value>
    </property>
    <property>
        <name>fs.s3a.impl</name>
        <value>org.apache.hadoop.fs.s3a.S3AFileSystem</value>
    </property>
    <property>
        <name>fs.s3a.aws.credentials.provider</name>
        <value>org.apache.hadoop.fs.s3a.SimpleAWSCredentialsProvider</value>
    </property>
</configuration>
EOF


RUN echo "--> Set Ownerships of /opt/flink" && \
    chown -R flink:flink $FLINK_HOME 

USER flink:flink

CMD ./bin/start-cluster.sh && sleep infinity