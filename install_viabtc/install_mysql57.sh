#!/usr/bin/env bash
set -e
fileUrl="https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm"
filename=$(basename $fileUrl)

if  [ ! -f "$filename" ]; then
  yum install wget -y
  wget $fileUrl
fi

yum install mysql-community-client mysql-community-devel -y

echo "install and mysqlclient complate"
