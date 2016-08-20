#!/bin/bash
HOSTNAME="127.0.0.1"  #数据库信息
PORT="3306"
USERNAME="root"
PASSWORD=""

DBNAME="costco"  #数据库名称
TYPE_TABLE_NAME="type_table" #数据库中表的名称
ITEM_TABLE_NAME="item_table"

#drop costco db
drop_costco_sql="drop database IF EXISTS ${DBNAME}"
mysql -h${HOSTNAME} -P${PORT} -u${USERNAME} -p${PASSWORD} -e "${drop_costco_sql}"

# create costco db
create_costco_sql="create database IF NOT EXISTS ${DBNAME}"
mysql -h${HOSTNAME} -P${PORT} -u${USERNAME} -p${PASSWORD} -e "${create_costco_sql}"

# create type table
create_type_table_sql="
create table IF NOT EXISTS ${TYPE_TABLE_NAME} 
(
	type_id		int NOT NULL AUTO_INCREMENT,
	type_name	varchar(20), 
	PRIMARY KEY (type_id)
) ENGINE=InnoDB;"

create_item_table_sql="
create table IF NOT EXISTS ${ITEM_TABLE_NAME} 
(
	item_id		int NOT NULL AUTO_INCREMENT,
	type_id		int,
	type_name	varchar(20), 
	price		double,
	star		int,
	PRIMARY KEY (item_id)
) ENGINE=InnoDB;"


insert_type_sql="insert into ${TYPE_TABLE_NAME} values 
( NULL, '衣服'),
( NULL, '化妆品'),
( NULL, '化妆品');"

insert_item_sql="insert into ${ITEM_TABLE_NAME} values 
( NULL, 0, '七匹狼', 12.99, 3),
( NULL, 0, '金鸳鸯', 13.99, 4),
( NULL, 0, '阿迪达斯', 14.99, 5);"

mysql -h${HOSTNAME} -P${PORT} -u${USERNAME} -p${PASSWORD} ${DBNAME} -e "${create_type_table_sql}"
mysql -h${HOSTNAME} -P${PORT} -u${USERNAME} -p${PASSWORD} ${DBNAME} -e "${create_item_table_sql}"
mysql -h${HOSTNAME} -P${PORT} -u${USERNAME} -p${PASSWORD} ${DBNAME} -e "${insert_type_sql}"
mysql -h${HOSTNAME} -P${PORT} -u${USERNAME} -p${PASSWORD} ${DBNAME} -e "${insert_item_sql}"

