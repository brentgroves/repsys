#!/bin/bash
# ./sed-mysql-stateful-set.sh mysql rephub11 3306 mysql 8.0

app=$1
node=$2
target_port=$3
target_port_name=$4
ver=$5

printf "\nsed-mysql-stateful-set app: $app" 
printf "\nsed-mysql-stateful-set node: $node" 
printf "\nsed-mysql-stateful-set target_port: $target_port" 
printf "\nsed-mysql-stateful-set target_port_name: $target_port_name" 
printf "\nsed-mysql-stateful-set ver: $ver" 

sed s/%APP%/$app/g templates/stateful-set-template.yaml | \
sed s/%NODE%/$node/g | \
sed s/%TARGET_PORT%/$target_port/g | \
sed s/%TARGET_PORT_NAME%/$target_port_name/g | \
sed s/%VER%/$ver/g > templates/stateful-set.yaml
