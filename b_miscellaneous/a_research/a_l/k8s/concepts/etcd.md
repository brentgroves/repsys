# **[etcd](https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## references

- **[etcd-io](https://github.com/etcd-io/etcd)**

## etcd key-value store

etcd is a distributed reliable key-value store for the most critical data of a distributed system, with a focus on being:

- Simple: well-defined, user-facing API (gRPC)
- Secure: automatic TLS with optional client cert authentication
- Fast: benchmarked 10,000 writes/sec
- Reliable: properly distributed using Raft

etcd is written in Go and uses the **[Raft](https://raft.github.io/)** consensus algorithm to manage a highly-available replicated log.

etcd is used in production by many companies, and the development team stands behind it in critical deployment scenarios, where etcd is frequently teamed with applications such as Kubernetes, locksmith, vulcand, Doorman, and many others. Reliability is further ensured by rigorous robustness testing.

See **[etcdctl](https://github.com/etcd-io/etcd/tree/main/etcdctl)** for a simple command line client.

## Getting etcd

The easiest way to get etcd is to use one of the pre-built release binaries which are available for OSX, Linux, Windows, and Docker on the release page.

For more installation guides, please check out play.etcd.io and operating etcd.

## Running etcd

First start a single-member cluster of etcd.

If etcd is installed using the pre-built release binaries, run it from the installation location as below:

```/tmp/etcd-download-test/etcd```

The etcd command can be simply run as such if it is moved to the system path as below:

```bash
mv /tmp/etcd-download-test/etcd /usr/local/bin/
etcd
```

This will bring up etcd listening on port 2379 for client communication and on port 2380 for server-to-server communication.

Next, let's set a single key, and then retrieve it:

```bash
etcdctl put mykey "this is awesome"
etcdctl get mykey
```

etcd is now running and serving client requests. For more, please check out:

- **[Interactive etcd playground](http://play.etcd.io/)**
- **[Animated quick demo](https://etcd.io/docs/latest/demo)**

## etcd TCP ports

The official etcd ports are 2379 for client requests, and 2380 for peer communication.

Running a local etcd cluster
First install goreman, which manages Procfile-based applications.

Our Procfile script will set up a local example cluster. Start it with:

goreman start
This will bring up 3 etcd members infra1, infra2 and infra3 and optionally etcd grpc-proxy, which runs locally and composes a cluster.

Every cluster member and proxy accepts key value reads and key value writes.

Follow the comments in Procfile script to add a learner node to the cluster.
