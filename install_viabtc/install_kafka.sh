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
    echo "have not $compressFileName and begin download from $fileUrl"
    wget $fileUrl
fi

fileExtName=${fileUrl##*.}
uncompressDirName=$(basename $fileUrl ".$fileExtName")
if [ ! -d "$uncompressDirName" ]; then
    echo "have not $uncompressDirName and begin Unzip the files $compressFileName"
    tar -zxvf $compressFileName
fi

echo "begin mv ./$uncompressDirName to /usr/local/kafka"
mv "./$uncompressDirName" /usr/local/kafka
/usr/local/kafka/bin/zookeeper-server-start.sh -daemon /usr/local/kafka/config/zookeeper.properties
/usr/local/kafka/bin/kafka-server-start.sh -daemon /usr/local/kafka/config/server.properties

echo "install and start kafka complate"