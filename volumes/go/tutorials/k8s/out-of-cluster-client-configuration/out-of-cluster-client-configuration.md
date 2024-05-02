# **[out-of-cluster-client-configuration]**

**[Back to Go Tutorial List](../../tutorial_list.md)**\
**[Back to Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../../../README.md)**

## references

<https://github.com/kubernetes/client-go/blob/master/examples/out-of-cluster-client-configuration/README.md>

## Creating the project

```bash
pushd .
mkdir -p ~/src/repsys/volumes/go/tutorials/k8s/out-of-cluster-client-configuration
cd ~/src/repsys/volumes/go/tutorials/k8s/out-of-cluster-client-configuration
go mod init out-of-cluster-client-configuration
pushd .
cd ~/src/repsys
go work use ./volumes/go/tutorials/k8s/out-of-cluster-client-configuration
dirs -v
pushd +X # where X is 0 based number from the bottom of dirs -v entries

go get k8s.io/apimachinery/pkg/api/errors
go get k8s.io/apimachinery/pkg/apis/meta/v1
go get k8s.io/client-go/kubernetes
go get k8s.io/client-go/tools/clientcmd
go get k8s.io/client-go/util/homedir
go get github.com/redis/go-redis/v9
go: added github.com/cespare/xxhash/v2 v2.2.0
go: added github.com/dgryski/go-rendezvous v0.0.0-20200823014737-9f7001d12a5f
go: added github.com/redis/go-redis/v9 v9.5.1

```
