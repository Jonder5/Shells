#!/bin/bash

### 重命名 mysql 数据库

user='root'	# 用户名
pwd=$1 # 密码不要写在脚本里，传值进来，这里表示接受第一个传参
old_db='mh_data_new' # 旧数据库
new_db='mihui_data_new' # 新数据库

# 创建新的数据库
mysql -u${user} -p${pwd} -e "create database if not exists ${new_db}"

# 查询旧数据的所有表
list_table=$(mysql -u${user} -p${pwd} -Nse "select table_name from information_schema.TABLES where TABLE_SCHEMA = \"${old_db}\"")

# 打印出来
echo ${list_table}

# 遍历改名字
for table in $list_table ;
do
    mysql -u root -p${pwd} -e "rename table ${old_db}.${table} to $new_db.${table}"
done

# 这里千万不要搞错，不要把新数据库的名字传入进来，否则会删掉数据库，建议注释这行，等确认无误了再删除旧的数据库
# mysql -u$user -p${pwd} -e "drop database ${old_db}"
