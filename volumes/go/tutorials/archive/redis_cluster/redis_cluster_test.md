# [Redis Go Client](https://redis.io/docs/latest/develop/connect/clients/go/)**

## Creating the project

```bash
pushd .
cd ~/src/repsys/volumes/go/tutorials/redis_cluster/
mkdir redis_cluster_test
cd redis_cluster_test
go mod init redis_cluster_test
pushd .
cd ~/src/repsys
go work use ./volumes/go/tutorials/redis_cluster/redis_cluster_test
dirs -v
pushd +X # where X is 0 based number from the bottom of dirs -v entries
go get github.com/redis/go-redis/v9
```
