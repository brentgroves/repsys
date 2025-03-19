# **[create a debug pod](https://medium.com/@shambhand2020/create-the-various-debug-or-test-pod-inside-kubernetes-cluster-e4862c767b96)**

```bash
kubectl run -it --tty --rm debug --image=alpine --restart=Never -- sh
microk8s kubectl run -it --tty --rm debug --image=alpine --restart=Never -- sh
# If you don't see a command prompt, try pressing enter.

# ping 10.188.50.202
PING 10.188.50.202 (10.188.50.202): 56 data bytes
64 bytes from 10.188.50.202: seq=0 ttl=63 time=0.750 ms
64 bytes from 10.188.50.202: seq=1 ttl=63 time=0.387 ms
64 bytes from 10.188.50.202: seq=2 ttl=63 time=0.472 ms
^C
If you don't see a command prompt, try pressing enter.
/ # exit
pod "debug" deleted
```
