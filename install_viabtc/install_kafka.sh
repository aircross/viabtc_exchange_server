#!/usr/bin/env bash
set -e
destDir="/usr/local/kafka"
if [ -d "$destDir" ]; then
    echo "the /usr/local/kafka directory already exists"
    exit 1
fi

echo "123343dfdd"
#yum install wget tar java-1.8.0-openjdk -y
#
#fileUrl="http://mirrors.hust.edu.cn/apache/kafka/1.0.0/kafka_2.11-1.0.0.tgz"
#filename=$(basename $fileUrl)
#if [ ! -f "$filename" ]; then
#    wget $fileUrl
#fi
#tar -zxvf $filename


#tar -zxvf kafka_2.11-1.0.0.tgz
#mv kafka_2.11-1.0.0 /usr/local/kafka
#/usr/local/kafka/bin/zookeeper-server-start.sh -daemon /usr/local/kafka/config/zookeeper.properties
#/usr/local/kafka/bin/kafka-server-start.sh -daemon /usr/local/kafka/config/server.properties