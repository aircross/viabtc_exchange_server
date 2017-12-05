#!/usr/bin/env bash
set -e
yum install librdkafka librdkafka-devel libcurl libcurl-devel libev libev-devel jansson jansson-devel mpdecimal mpdecimal-devel -y

cd ../depends/hiredis
make -j4 && make install
cd ../../utils
make -j4
