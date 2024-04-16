# [Redis Go Client](https://redis.io/docs/latest/develop/connect/clients/go/)**

## Creating the project

```bash
pushd .
cd ~/src/repsys/volumes/go/tutorials/redis_standalone/
mkdir redis_standalone_test
cd redis_standalone_test
go mod init redis_standalone_test
pushd .
cd ~/src/repsys
go work use ./volumes/go/tutorials/redis_standalone/redis_standalone_test
dirs -v
pushd +X # where X is 0 based number from the bottom of dirs -v entries
go get github.com/redis/go-redis/v9
```
