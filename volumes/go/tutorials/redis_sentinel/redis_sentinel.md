# **[go redis sentinel](https://redis.uptrace.dev/guide/go-redis-sentinel.html)**

## references

<https://redis.uptrace.dev/guide/go-redis-sentinel.html>
<https://medium.com/@sachin.chini/connect-to-redis-sentinel-in-golang-da35dc900798>
<https://redis.uptrace.dev/guide/go-redis.html>

## Creating the project

```bash
pushd .
cd ~/src/repsys/volumes/go/tutorials/redis_sentinel/
mkdir redis_sentinel_test
cd redis_sentinel_test
go mod init redis_sentinel_test
pushd .
cd ~/src/repsys
go work use ./volumes/go/tutorials/redis_sentinel/redis_sentinel_test
dirs -v
pushd +X # where X is 0 based number from the bottom of dirs -v entries
go get github.com/redis/go-redis/v9
go: added github.com/cespare/xxhash/v2 v2.2.0
go: added github.com/dgryski/go-rendezvous v0.0.0-20200823014737-9f7001d12a5f
go: added github.com/redis/go-redis/v9 v9.5.1

```
