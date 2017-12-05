#!/usr/bin/env bash
set -e
file="./mysql57-community-release-el7-11.noarch.rpm"

if  [ ! -f "$file" ]; then
  yum install wget -y
  wget https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
fi

var="rpm -ivh mysql57-community-release-el7-11.noarch.rpm"
echo $var
#yum install mysql-community-server mysql-community-client mysql-community-devel -y
