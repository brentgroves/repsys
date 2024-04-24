# read k8s secret

## references

<https://pkg.go.dev/k8s.io/kubernetes/pkg/kubelet/secret>
<https://github.com/weibeld/kubernetes-client-go-examples/blob/master/ex5-secrets/ex5-secrets.go>

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
