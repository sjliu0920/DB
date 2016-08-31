#!/bin/bash

usage="Usage: ./`basename $0` (init|flush)"
args=$1

HOSTNAME="127.0.0.1"  #数据库信息
PORT="3306"
USERNAME="root"
PASSWORD="lsj"

DBNAME="costco"  #数据库名称
TYPE_TABLE_NAME="type_table" #数据库中表的名称
ITEM_TABLE_NAME="item_table"
USER_TABLE_NAME="user_table"

function init()
{
	#drop costco db
	drop_costco_sql="drop database IF EXISTS ${DBNAME}"
	mysql -h${HOSTNAME} -P${PORT} -u${USERNAME} -p${PASSWORD} -e "${drop_costco_sql}"

	# create costco db
	create_costco_sql="create database ${DBNAME} CHARACTER SET utf8"
	mysql -h${HOSTNAME} -P${PORT} -u${USERNAME} -p${PASSWORD} -e "${create_costco_sql}"

	# create type table
	create_type_table_sql="
	create table IF NOT EXISTS ${TYPE_TABLE_NAME} 
	(
	type_id		int NOT NULL AUTO_INCREMENT,
	type_name	varchar(20), 
	PRIMARY KEY (type_id)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8;"

	create_item_table_sql="
	create table IF NOT EXISTS ${ITEM_TABLE_NAME} 
	(
	item_id		int NOT NULL AUTO_INCREMENT,
	type_id		int,
	item_name	varchar(20), 
	price		double,
	star		int,
	PRIMARY KEY (item_id)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8;"

	create_user_table_sql="
	create table IF NOT EXISTS ${USER_TABLE_NAME} 
	(
	user_id		int NOT NULL AUTO_INCREMENT,
	account		varchar(20), 
	passwd		varchar(20), 
	PRIMARY KEY (user_id)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8;"


	insert_type_sql="insert into ${TYPE_TABLE_NAME} values 
	( NULL, '衣服'),
	( NULL, '化妆品'),
	( NULL, '化妆品');"

	insert_item_sql="insert into ${ITEM_TABLE_NAME} values 
	( NULL, 0, '七匹狼', 12.99, 3),
	( NULL, 0, '金鸳鸯', 13.99, 4),
	( NULL, 0, '阿迪达斯', 14.99, 5);"

	insert_user_sql="insert into ${USER_TABLE_NAME} values 
	( NULL, 'double', 'lsj');"

	mysql -h${HOSTNAME} -P${PORT} -u${USERNAME} -p${PASSWORD} ${DBNAME} -e "${create_type_table_sql}"
	mysql -h${HOSTNAME} -P${PORT} -u${USERNAME} -p${PASSWORD} ${DBNAME} -e "${create_item_table_sql}"
	mysql -h${HOSTNAME} -P${PORT} -u${USERNAME} -p${PASSWORD} ${DBNAME} -e "${create_user_table_sql}"
	mysql -h${HOSTNAME} -P${PORT} -u${USERNAME} -p${PASSWORD} ${DBNAME} -e "${insert_type_sql}"
	mysql -h${HOSTNAME} -P${PORT} -u${USERNAME} -p${PASSWORD} ${DBNAME} -e "${insert_item_sql}"
	mysql -h${HOSTNAME} -P${PORT} -u${USERNAME} -p${PASSWORD} ${DBNAME} -e "${insert_user_sql}"
}

function flush()
{
	HOSTNAME="127.0.0.1"  
	PORT="3306"
	USERNAME="root"
	PASSWORD="lsj"

	first="ALTER TABLE ${ITEM_TABLE_NAME} DROP item_id";
	second="ALTER TABLE ${ITEM_TABLE_NAME} ADD item_id INT( 8 ) NOT NULL FIRST";
	third="ALTER TABLE ${ITEM_TABLE_NAME} MODIFY COLUMN item_id INT( 8 ) NOT NULL AUTO_INCREMENT,ADD PRIMARY KEY(item_id)";

	mysql -h${HOSTNAME} -P${PORT} -u${USERNAME} -p${PASSWORD} ${DBNAME} -e "${first}"
	mysql -h${HOSTNAME} -P${PORT} -u${USERNAME} -p${PASSWORD} ${DBNAME} -e "${second}"
	mysql -h${HOSTNAME} -P${PORT} -u${USERNAME} -p${PASSWORD} ${DBNAME} -e "${third}"
}

case $args in
	(init)
		init
		;;
	(flush)
		flush
		;;
	(*)
		echo "$usage"
esac
