FROM kafka-start/connect-jdbc:latest

ENV KAFKA_CONNECT_JDBC_DIR=$KAFKA_CONNECT_PLUGINS_DIR/kafka-connect-jdbc

ARG KAFKA_JDBC_VERSION=5.3.1

# Deploy Kafka Connect JDBC
RUN mkdir $KAFKA_CONNECT_JDBC_DIR && cd $KAFKA_CONNECT_JDBC_DIR &&\
	curl -sO http://packages.confluent.io/maven/io/confluent/kafka-connect-jdbc/$KAFKA_JDBC_VERSION/kafka-connect-jdbc-$KAFKA_JDBC_VERSION.jar

# Instal wget to downlod mysql connector
USER root
RUN yum -y install wget

# Deploy MySQL JDBC Driver
RUN cd $KAFKA_CONNECT_JDBC_DIR && \
    wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.48.tar.gz && \
    tar -zxvf mysql-connector-java-5.1.48.tar.gz && \
    cp $KAFKA_CONNECT_JDBC_DIR/mysql-connector-java-5.1.48/mysql-connector-java-5.1.48.jar $KAFKA_CONNECT_JDBC_DIR