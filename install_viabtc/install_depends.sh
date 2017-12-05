#!/usr/bin/env bash
set -e
basepath=$(cd `dirname $0`; pwd)
projectpath=$(dirname $basepath)

yum install librdkafka librdkafka-devel libcurl libcurl-devel libev libev-devel jansson jansson-devel mpdecimal mpdecimal-devel -y

cd $projectpath/depends/hiredis
make -j4 && make install
cd $projectpath/network
make -j4
cd $projectpath/utils
make -j4
