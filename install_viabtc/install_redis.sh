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

yum install redis -y
redis-server $basepath/redis_master.conf
redis-server $basepath/redis_sl1.conf
redis-server $basepath/redis_sl2.conf
redis-sentinel $basepath/sentinel-sy.conf