#!/bin/bash
# ./sed-volume.sh dev reports11 30011 1 reports11 30311 reports
build=$1
mysql_host=$2
mysql_port=$3
azure_dw=$4
mongo_host=$5
mongo_port=$6
mongo_db=$7

sleep 5
printf "\nsed_volume build: $build" 
printf "\nsed_volume mysql_host: $mysql_host" 
printf "\nsed_volume mysql_port: $mysql_port" 
printf "\nsed_volume azure_dw: $azure_dw" 
printf "\nsed_volume mongo_host: $mongo_host" 
printf "\nsed_volume mongo_port: $mongo_port" 
printf "\nsed_volume mongo_db: $mongo_db" 