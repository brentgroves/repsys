# **[How to Implement TLS ft. Golang](https://medium.com/@harsha.senarath/how-to-implement-tls-ft-golang-40b380aae288)**

## references

<https://github.com/denji/golang-tls>

## Creating the project

```bash
pushd .
mkdir -p ~/src/repsys/volumes/go/tutorials/ssl/ssl_server
cd ~/src/repsys/volumes/go/tutorials/ssl/ssl_server
go mod init ssl_server
pushd .
cd ~/src/repsys
go work use ./volumes/go/tutorials/ssl/ssl_server
dirs -v
pushd +X # where X is 0 based number from the bottom of dirs -v entries
go get github.com/redis/go-redis/v9
go: added github.com/cespare/xxhash/v2 v2.2.0
go: added github.com/dgryski/go-rendezvous v0.0.0-20200823014737-9f7001d12a5f
go: added github.com/redis/go-redis/v9 v9.5.1

```

## **[Generate server certificate](../../../../../pki/gen-and-install-certs.md)**

Generate frt-kors43.linamar.com
