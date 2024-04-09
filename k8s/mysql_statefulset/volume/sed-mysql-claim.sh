#!/bin/bash
app=$1
node=$2

printf "\nsed-mysql-claim app: $app" 
printf "\nsed-mysql-claim node: $node" 

sed s/%APP%/$app/g templates/claim-template.yaml | \
sed s/%NODE%/$node/g > templates/claim.yaml

