#!/usr/bin/env bash
set -e
destDir="/usr/local/kafka"
if [ -d "$destDir" ]; then
    echo "the '/usr/local/kafka' directory already exists"
fi

yum install wget tar java-1.8.0-openjdk -y

fileUrl="http://mirrors.hust.edu.cn/apache/kafka/1.0.0/kafka_2.11-1.0.0.tgz"
compressFileName=$(basename $fileUrl)
if [ ! -f "$compressFileName" ]; then
    wget $fileUrl
fi

fileExtName=${fileUrl##*.}
uncompressDirName=$(basename $fileUrl)

if [ ! -d "$uncompressDirName" ]; then
    tar -zxvf $compressFileName
fi

mv $uncompressDirName /usr/local/kafka
/usr/local/kafka/bin/zookeeper-server-start.sh -daemon /usr/local/kafka/config/zookeeper.properties
/usr/local/kafka/bin/kafka-server-start.sh -daemon /usr/local/kafka/config/server.properties