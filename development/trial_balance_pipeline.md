# Trial Balance Pipeline

## psuedo code

```psuedo_code
connect to redis
subscribe to tb_mutex
if tb_mutex up
    get next report request 
    send request to stage1 channel
end
create stage_1 channel


```

## Setup development system

### Add names of k8s services and pods to hosts file

```bash
sudo nvim /etc/hosts
127.0.0.1 redis-sentinel-master.redis-sentinel.svc.cluster.local
```

use same selector as svc/redis-sentinel-master -n redis-sentinel

### setup k8s port-forwarding with kubectl for services app needs

```bash
# To get your password run:
export REDIS_PASSWORD=$(kubectl get secret --namespace redis-sentinel redis-sentinel -o jsonpath="{.data.redis-password}" | base64 -d)

# https://kubernetes.io/docs/tasks/access-application-cluster/port-forward-access-application-cluster/
kubectl port-forward --namespace redis-sentinel svc/redis-sentinel-master 6379:6379 

REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h redis-sentinel-master.redis-sentinel.svc.cluster.local -p 6379

# or 
REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h 127.0.0.1 -p 6379

```

## use k8s go client

For secrets use the go client for development but should work for production also.

<https://github.com/kubernetes/client-go/blob/master/examples/out-of-cluster-client-configuration/README.md>

## Creating the project

```bash
pushd .
mkdir -p ~/src/repsys/volumes/go/trial_balance_pipeline/rs_tb_pl
cd ~/src/repsys/volumes/go/trial_balance_pipeline/rs_tb_pl
go mod init rs_tb_pl
pushd .
cd ~/src/repsys
go work use ./volumes/go/trial_balance_pipeline/rs_tb_pl
dirs -v
pushd +X # where X is 0 based number from the bottom of dirs -v entries
go get github.com/redis/go-redis/v9
go: added github.com/cespare/xxhash/v2 v2.2.0
go: added github.com/dgryski/go-rendezvous v0.0.0-20200823014737-9f7001d12a5f
go: added github.com/redis/go-redis/v9 v9.5.1

```
