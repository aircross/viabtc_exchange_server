#!/usr/bin/env bash
set -e
fileUrl="https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm"
filename=$(basename $fileUrl)

if  [ ! -f "$filename" ]; then
  yum install wget -y
  wget $fileUrl
fi

yum localinstall mysql57-community-release-el7-11.noarch.rpm -y
yum install mysql-community-client mysql-community-devel -y

mysqlclient="/usr/lib64/libmysqlclient.so"
if  [ ! -f "$mysqlclient" ]; then
    ln -s /usr/lib64/mysql/libmysqlclient.so $mysqlclient
fi

echo "install and mysqlclient complate"
