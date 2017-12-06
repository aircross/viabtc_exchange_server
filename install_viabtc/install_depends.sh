#!/usr/bin/env bash
set -e
basepath=$(cd `dirname $0`; pwd)
projectpath=$(dirname $basepath)

if [ ! -f "/etc/yum.repos.d/epel-7.repo" ]; then
    yum install wget -y
    wget -O /etc/yum.repos.d/epel-7.repo http://mirrors.aliyun.com/repo/epel-7.repo
    yum clean all
    yum makecache
fi

yum install librdkafka librdkafka-devel libcurl libcurl-devel libev libev-devel jansson jansson-devel mpdecimal mpdecimal-devel openssl openssl-devel -y

cd $projectpath/depends/hiredis
make -j4 && make install
cd $projectpath/network
make -j4
cd $projectpath/utils
make -j4
