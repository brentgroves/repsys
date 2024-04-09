#!/bin/bash
app=$1
node=$2 
printf "\nsed-mysql-volume app: $app" 
printf "\nsed-mysql-volume node: $node" 

sed s/%APP%/$app/g templates/volume-template.yaml | \
sed s/%NODE%/$node/g > templates/volume.yaml

