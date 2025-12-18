# **[How do pod containers communicate](https://adil.medium.com/how-do-containers-communicate-via-localhost-in-a-kubernetes-pod-d9e193844b9d)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## references

- **[microk8s ctr](https://microk8s.io/docs/command-reference#heading--microk8s-ctr)**

In my Kubernetes Core Concepts: Pod article, I stated that containers in the same Pod can access each other via localhost

## How does it work?

When you create two containers on Docker, these containers cannot communicate via localhost. Because they run in different network namespaces.

Let’s verify this statement:

```bash
root@main:~# docker run -dit - name web1 -e PORT=1111 webratio/nodejs-http-server
eca3f2e0aad53fa2955473dae2af001c358936e654f2e9757a0af81887177f17
root@main:~# docker run -dit - name web2 -e PORT=2222 webratio/nodejs-http-server
bf0bfa83d15a4bbac98af94c3ebf19d13b4f250fbf4cb3f32a016f1a7704acae

root@main:~# docker exec -it web1 bash
root@eca3f2e0aad5:/# curl -I localhost:1111
HTTP/1.1 200 OK
...
root@eca3f2e0aad5:/# curl -I localhost:2222
curl: (7) Failed to connect to localhost port 2222: Connection refused
```

I can access port 1111 from web1 container. Because the process listening on port 1111 is already running on web1 container.

But I can’t access port 2222 from web1 container. Because the process listening on port 2222 is running on web2.

Since containers are isolated from each other, they cannot communicate with each other via localhost.

I’ll try running these two containers in a Kubernetes cluster with the same configuration:

00-multiple-container-in-one-pod.yaml

```bash
apiVersion: v1
kind: Pod
metadata:
  name: adil-blog
spec:
  containers:
  - image: webratio/nodejs-http-server
    name: web1
    env:
    - name: PORT
      value: "1111"
  - image: webratio/nodejs-http-server
    name: web2
    env:
    - name: PORT
      value: "2222"
```

Apply:

```bash
➜  k8s kubectl apply -f 00-multiple-container-in-one-pod.yaml
pod/adil-blog created
```

Test connectivity between containers:

```bash
➜  ~ kubectl exec -it adil-blog --container web1 -- /bin/bash
root@adil-blog:/# curl -I localhost:1111
HTTP/1.1 200 OK
....

root@adil-blog:/# curl -I localhost:2222
HTTP/1.1 200 OK
...
```

curl localhost:2222 works fine in web1 container on Kubernetes. But why?
Let’s ssh into the Kubernetes node and see what’s going on.

List containers:

```bash
microk8s ctr c list
microk8s ctr c list
CONTAINER                                                           IMAGE                                        RUNTIME                  
222a21b082dca7032ff1f8be3a49150bcef8a29dcc534ef41f76d0e518ff52c2    registry.k8s.io/pause:3.7                    io.containerd.runc.v2    
3fb42fbc318313796e4b592cdb44b5e8d184f812cd3cf006b70920dc63307b0d    registry.k8s.io/pause:3.7                    io.containerd.runc.v2    
44a37c04debd2e3c75451d3ce9d4be86f04e54a77a83060d34a3f8923b5461ba    registry.k8s.io/pause:3.7                    io.containerd.runc.v2    
4b4387e338eca8a78490a16ca9f1751c1fe886420b817d8239d425edf880fe63    registry.k8s.io/pause:3.7                    io.containerd.runc.v2    
4d621a954093cf0509748a7702f6b322cf62b46ac2aa323d43487c591f5af3dd    docker.io/calico/kube-controllers:v3.25.1    io.containerd.runc.v2    
69dafcdf00295f99ec06f7b2ccda138ef41b74b1e4f29a970daeda297aff42a2    docker.io/calico/node:v3.25.1                io.containerd.runc.v2    
6c44c443477b15a60f27a799367226883f7f0f017d1b4f7fc27902ed4259a501    docker.io/calico/cni:v3.25.1                 io.containerd.runc.v2    
78e09a53770afc8c9440b3202783325c8b758702d9d313f7d6c1929b46bc0583    registry.k8s.io/pause:3.7                    io.containerd.runc.v2    
8966291e73931a050809c57b937d6fe3f85f38ba3f878a4a21a84ef7132eaa01    registry.k8s.io/pause:3.7                    io.containerd.runc.v2    
8e6291abec2b2cca1479a56898d376115a766e9f6a8fe91edcb0e5faee32e9d8    docker.io/calico/kube-controllers:v3.25.1    io.containerd.runc.v2    
a34d5c90136bea8e24bf95402a8b7a51123fd1b0efda710b7d2675b9b231cf7e    docker.io/coredns/coredns:1.10.1             io.containerd.runc.v2    
a762deb58078a576c80a70938d7f67bc524770929dd483d157c272b512ff0db2    docker.io/calico/cni:v3.25.1                 io.containerd.runc.v2    
bd9e22fa815cace1f716c74c785c0bd26be46726064b6074bd45784f1ee06a2a    docker.io/calico/node:v3.25.1                io.containerd.runc.v2    
ef22894322523b3b3e5178936573eaf7b65da5260a0defe86f140af39d4ccf96    docker.io/coredns/coredns:1.10.1             io.containerd.runc.v2 
```
