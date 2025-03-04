# **[SSH to Multipass VM](https://dev.to/arc42/enable-ssh-access-to-multipass-vms-36p7)**

**[Back to Research List](../../../research_list.md)**\
**[Back to Current Status](../../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../../README.md)**

## references

## Enable ssh access to multipass vms

**The problem**\

- You are using multipass to create lightweight virtual (Ubuntu) machines.
- You want to ssh into those machines, because you cannot or don't want to use the standard shell command multipass shell <name-of-vm>.
- The naive approach fails with permission denied:

Permission denied, although there is a route to this virtual machine available...

```bash
[brent@repsys11 ~]# ip ro
The output is slightly different but you get exactly the same information:
default via 10.1.1.205 dev eno1 proto static
10.1.0.0/22 dev br0 proto kernel scope link src 10.1.0.126
10.1.0.0/22 dev br2 proto kernel scope link src 10.1.0.127
10.1.0.0/22 dev br3 proto kernel scope link src 10.1.0.140
10.1.0.0/22 dev eno1 proto kernel scope link src 10.1.0.125
10.13.31.0/24 dev br1 proto kernel scope link src 10.13.31.1 linkdown
10.127.233.0/24 dev mpbr0 proto kernel scope link src 10.127.233.1
ubuntu@repsys11-c2-n2:~$ ip ro
default via 10.127.233.1 dev enp5s0 proto dhcp src 10.127.233.252 metric 100 
10.1.0.0/22 dev enp6s0 proto kernel scope link src 10.1.0.142 
blackhole 10.1.41.128/26 proto 80 
10.1.41.133 dev cali104635667e0 scope link 
10.1.41.134 dev cali96e44e3d43b scope link 
10.127.233.0/24 dev enp5s0 proto kernel scope link src 10.127.233.252 metric 100 
10.127.233.1 dev enp5s0 proto dhcp scope link src 10.127.233.252 metric 100
```

## Different approaches

Two approaches have been documented elsewhere:

- Add an ssh-key to an existing virtual machine (explained by **[Josue Bustos here](https://dev.to/josuebustos/vs-code-remote-ssh-multipass-dn8)**). Downside of this approach: You have to repeat it (more or less manually) for all new VMs you create with multipass launch. Therefore, let's look at a solution that will also work for new VMs...
- Pass an ssh-key while creating a multipass VM (explained in detail by Ivan Krizsan here). In short: You generate a new ssh-key, and pass the public key into every new VM. I summarize the required steps below.

## Add SSH Host

Before we can SSH into our Multipass VM instance, you need to add a new Host in the user's SSH config file. You can directly access the file by locating the directory it's in.

```bash
cat ~/.ssh/config
Host ssh.dev.azure.com  
    User git  
    PubkeyAcceptedAlgorithms +ssh-rsa  
    HostkeyAlgorithms +ssh-rsa 

Edit the file by adding or appending these three lines:
Host repsys11-c2-n2
  HostName 10.1.0.142
  User ubuntu
```

## Example config

```bash
vi ~/.ssh/config
Host ssh.dev.azure.com  
    User git  
    PubkeyAcceptedAlgorithms +ssh-rsa  
    HostkeyAlgorithms +ssh-rsa 
Host repsys11-c2-n2
  HostName 10.1.0.142
  User ubuntu
Host repsys11-c2-n1
  HostName 10.1.0.129
  User ubuntu
Host repsys11-c2-n3
  HostName 10.1.0.141
  User ubuntu
```

## get key from Host to connect from

```bash
ssh brent@reports-alb
cat ~/.ssh/id_ed25519.pub
# copy key
```

## add key to host to connect to

```bash
multipass shell repsys11-c2-n1
vi ~/.ssh/authorized_keys
# paste key
```

## connect

```bash
ssh brent@reports-alb
ssh ubuntu@repsys11-c2-n2
```
