# **[Configure RBD client cache in MicroCeph](https://canonical-microceph.readthedocs-hosted.com/en/latest/how-to/rbd-client-cfg/)**

MicroCeph supports setting, resetting, and listing client configurations which are exported to ceph.conf and are used by tools like qemu directly for configuring rbd cache. Below are the supported client configurations.

| Key                                | Description                                                                                                    |
|------------------------------------|----------------------------------------------------------------------------------------------------------------|
| rbd_cache                          | Enable caching for RADOS Block Device (RBD).                                                                   |
| rbd_cache_size                     | The RBD cache size in bytes.                                                                                   |
| rbd_cache_writethrough_until_flush | The number of seconds dirty data is in the cache before writeback starts.                                      |
| rbd_cache_max_dirty                | The dirty limit in bytes at which the cache triggers write-back. If 0, uses write-through caching.             |
| rbd_cache_target_dirty             | The dirty target before the cache begins writing data to the data storage. Does not block writes to the cache. |

Supported config keys can be configured using the ‘set’ command:

```bash
sudo microceph client config set rbd_cache true
sudo microceph client config set rbd_cache false --target alpha
sudo microceph client config set rbd_cache_size 2048MiB --target beta
```

Note

Host level configuration changes can be made by passing the relevant hostname as the –target parameter.

All the client configs can be queried using the ‘list’ command.

```bash
$ sudo microceph cluster config list
+---+----------------+---------+----------+
| # |      KEY       |  VALUE  |   HOST   |
+---+----------------+---------+----------+
| 0 | rbd_cache      | true    | beta     |
+---+----------------+---------+----------+
| 1 | rbd_cache      | false   | alpha    |
+---+----------------+---------+----------+
| 2 | rbd_cache_size | 2048MiB | beta     |
+---+----------------+---------+----------+
```

Similarly, all the client configs of a particular host can be queried using the –target parameter.

```bash
$ sudo microceph cluster config list --target beta
+---+----------------+---------+----------+
| # |      KEY       |  VALUE  |   HOST   |
+---+----------------+---------+----------+
| 0 | rbd_cache      | true    | beta     |
+---+----------------+---------+----------+
| 1 | rbd_cache_size | 2048MiB | beta     |
+---+----------------+---------+----------+
```

A particular config key can be queried for using the ‘get’ command:

```bash
$ sudo microceph cluster config list
+---+----------------+---------+----------+
| # |      KEY       |  VALUE  |   HOST   |
+---+----------------+---------+----------+
| 0 | rbd_cache      | true    | beta     |
+---+----------------+---------+----------+
| 1 | rbd_cache      | false   | alpha    |
+---+----------------+---------+----------+
```

Similarly, –target parameter can be used with get command to query for a particular config key/hostname pair.

```bash
$ sudo microceph cluster config rbd_cache --target alpha
+---+----------------+---------+----------+
| # |      KEY       |  VALUE  |   HOST   |
+---+----------------+---------+----------+
| 0 | rbd_cache      | false   | alpha    |
+---+----------------+---------+----------+
```

Resetting a config key (i.e. removing the configured key/value) can performed using the ‘reset’ command:

```bash
$ sudo microceph cluster config reset rbd_cache_size
$ sudo microceph cluster config list
 +---+----------------+---------+----------+
 | # |      KEY       |  VALUE  |   HOST   |
 +---+----------------+---------+----------+
 | 0 | rbd_cache      | true    | beta     |
 +---+----------------+---------+----------+
 | 1 | rbd_cache      | false   | alpha    |
 +---+----------------+---------+----------+
```

This operation can also be performed for a specific host as follows:

```bash
$ sudo microceph cluster config reset rbd_cache --target alpha
$ sudo microceph cluster config list
 +---+----------------+---------+----------+
 | # |      KEY       |  VALUE  |   HOST   |
 +---+----------------+---------+----------+
 | 0 | rbd_cache      | true    | beta     |
 +---+----------------+---------+----------+
```
