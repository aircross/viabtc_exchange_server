#!/usr/bin/env bash
set -e
yum install wget tar java-1.8.0-openjdk -y
wget https://www.apache.org/dyn/closer.cgi?path=/kafka/1.0.0/kafka_2.11-1.0.0.tgz
tar -zxvf kafka_2.11-1.0.0.tgz
mv kafka_2.11-1.0.0 /usr/local/kafka
/usr/local/kafka/bin/zookeeper-server-start.sh -daemon /usr/local/kafka/config/zookeeper.properties
/usr/local/kafka/bin/kafka-server-start.sh -daemon /usr/local/kafka/config/server.properties