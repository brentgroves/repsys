# mytest1 service

## Test unit file

```bash
pushd .
cd ~/src/repsys/research/m_z/systemd/logging/iptables
sudo mkdir /etc/mytests
sudo chmod 777 /etc/mytests
# copy contents
cp ./*.sh /etc/myiptables/
# verify
ls -alh /etc/myiptables
total 24K
drwxrwxrwx   2 root  root  4.0K May  1 15:47 .
drwxr-xr-x 148 root  root   12K May  1 15:34 ..
-rwxrwxr-x   1 brent brent 2.0K May  1 15:47 delete_myrules.sh
-rwxrwxr-x   1 brent brent 2.3K May  1 15:47 recreate_myrules.sh

```

## manually test scripts without systemd

```bash
iptables -S
iptables -t nat -S
/etc/myiptables/recreate_rules.sh
/etc/myiptables/delete_rules.sh
```
