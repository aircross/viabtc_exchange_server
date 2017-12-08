#!/bin/bash

MYSQL_HOST="rm-wz900j5wutr7o38di.mysql.rds.aliyuncs.com"
MYSQL_USER="hotbit_make"
MYSQL_PASS="hotbit_make_20171205"
MYSQL_DB="hotbit_make_engine"
#mysql -uhotbit_make -hrm-wz900j5wutr7o38di.mysql.rds.aliyuncs.com -photbit_make_20171205 -N -s information_schema -e "SELECT CONCAT('TRUNCATE TABLE ',TABLE_NAME,';') FROM TABLES WHERE TABLE_SCHEMA='hotbit_make_engine'";


for i in `seq 0 99`
do
    echo "create table balance_history_$i"
    mysql -h$MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASS $MYSQL_DB -e "TRUNCATE TABLE balance_history_$i LIKE balance_history_example;"
done

for i in `seq 0 99`
do
    echo "create table order_history_$i"
    mysql -h$MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASS $MYSQL_DB -e "TRUNCATE TABLE order_history_$i LIKE order_history_example;"
done

for i in `seq 0 99`
do
    echo "create table order_detail_$i"
    mysql -h$MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASS $MYSQL_DB -e "TRUNCATE TABLE order_detail_$i LIKE order_detail_example;"
done

for i in `seq 0 99`
do
    echo "create table deal_history_$i"
    mysql -h$MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASS $MYSQL_DB -e "TRUNCATE TABLE deal_history_$i LIKE deal_history_example;"
done

for i in `seq 0 99`
do
    echo "create table user_deal_history_$i"
    mysql -h$MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASS $MYSQL_DB -e "TRUNCATE TABLE user_deal_history_$i LIKE user_deal_history_example;"
done
