#!/bin/bash

mysql -uhotbit_make -hrm-wz900j5wutr7o38di.mysql.rds.aliyuncs.com -photbit_make_20171205 -N -s information_schema -e "SELECT CONCAT('TRUNCATE TABLE d',TABLE_NAME,';') FROM TABLES WHERE TABLE_SCHEMA='hotbit_make_engine'";
