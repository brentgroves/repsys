#!/bin/bash
# https://gist.github.com/gitaarik/8735255
pushd .

rm -rf ~/.kube/*.yaml
cp ~/src/repsys/k8s/kubectl/all-config-files/*.yaml ~/.kube/

popd
