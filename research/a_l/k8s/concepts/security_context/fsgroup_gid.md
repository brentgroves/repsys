# **[Kubernetes, security context, fsGroup field and default user's group ID running the container](https://stackoverflow.com/questions/48023652/kubernetes-security-context-fsgroup-field-and-default-users-group-id-running)**

I'm new to Kubernetes and I'm trying to understand some security stuff.

My question is about the Group ID (= gid) of the user running the container.

I create a Pod using this official example: <https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod>

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: security-context-demo
spec:
  securityContext:
    runAsUser: 1000
    fsGroup: 2000
  volumes:
  - name: sec-ctx-vol
    emptyDir: {}
  containers:
  - name: sec-ctx-demo
    image: gcr.io/google-samples/node-hello:1.0
    volumeMounts:
    - name: sec-ctx-vol
      mountPath: /data/demo
    securityContext:
      allowPrivilegeEscalation: false
```

In the documentation, they say:

In the configuration file, the runAsUser field specifies that for any Containers in the Pod, the first process runs with user ID 1000. The fsGroup field specifies that group ID 2000 is associated with all Containers in the Pod. Group ID 2000 is also associated with the volume mounted at /data/demo and with any files created in that volume.

So, I go into the container:

```kubectl exec -it security-context-demo -- sh```

I see that the first process (i.e. with PID 1) is running with user 1000 => OK, that's the behavior I expected.

```bash
# -f     Do full-format listing.  This option can be combined with
            #   many other Unix-style options to add additional columns.
#        -p pidlist
            #   Select by PID.  This selects the processes whose process
            #   ID numbers appear in pidlist.            
 $ ps -f -p 1
 UID        PID  PPID  C STIME TTY          TIME CMD
 1000         1     0  0 13:06 ?        00:00:00 /bin/sh -c node server.js
 ```

Then, I create a file "testfile" in folder /data/demo. This file belongs to group "2000" because /data/demo has the "s" flag on group permission:

```bash
$ ls -ld /data/demo
drwxrwsrwx 3 root 2000 39 Dec 29 13:26 /data/demo
$ echo hello > /data/demo/testfile
$ ls -l /data/demo/testfile
-rw-r--r-- 1 1000 2000 6 Dec 29 13:29 /data/demo/testfile
```

Then, I create a subfolder "my-folder" and remove the "s" flag on group permission. I create a file "my-file" in this folder:

```bash
$ mkdir /data/demo/my-folder
$ ls -ld /data/demo/my-folder
drwxr-sr-x 2 1000 2000 6 Dec 29 13:26 /data/demo/my-folder
$ chmod g-s /data/demo/my-folder
$ ls -ld /data/demo/my-folder
drwxr-xr-x 2 1000 2000 6 Dec 29 13:26 /data/demo/my-folder
$ touch /data/demo/my-folder/my-file
$ ls -l /data/demo/my-folder/my-file
-rw-r--r-- 1 1000 root 0 Dec 29 13:27 /data/demo/my-folder/my-file
```

**[linux directory permission](https://stackoverflow.com/questions/54189868/linux-directory-permission-s)**

man chmod tells me that s stands for "set user or group ID on execution". What does that mean? And how come it maps onto the same chmod code? Should I worry about this on the server?

## answer

A directory that has ‘setgid’ on it will cause all files that are created in that directory to be owned by the group of the directory as opposed to the group of the owner.
