# **[subpath](https://kubernetes.io/docs/concepts/storage/volumes/#using-subpath)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## Using subPath

Sometimes, it is useful to share one volume for multiple uses in a single pod. The volumeMounts[*].subPath property specifies a sub-path inside the referenced volume instead of its root.

The following example shows how to configure a Pod with a LAMP stack (Linux Apache MySQL PHP) using a single, shared volume. This sample subPath configuration is not recommended for production use.

The PHP application's code and assets map to the volume's html folder and the MySQL database is stored in the volume's mysql folder. For example:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-lamp-site
spec:
    containers:
    - name: mysql
      image: mysql
      env:
      - name: MYSQL_ROOT_PASSWORD
        value: "rootpasswd"
      volumeMounts:
      - mountPath: /var/lib/mysql
        name: site-data
        subPath: mysql
    - name: php
      image: php:7.0-apache
      volumeMounts:
      - mountPath: /var/www/html
        name: site-data
        subPath: html
    volumes:
    - name: site-data
      persistentVolumeClaim:
        claimName: my-lamp-site-data
```

## Using subPath with expanded environment variables

FEATURE STATE: Kubernetes v1.17 [stable]
Use the subPathExpr field to construct subPath directory names from downward API environment variables. The subPath and subPathExpr properties are mutually exclusive.

In this example, a Pod uses subPathExpr to create a directory pod1 within the hostPath volume /var/log/pods. The hostPath volume takes the Pod name from the downwardAPI. The host directory /var/log/pods/pod1 is mounted at /logs in the container.

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pod1
spec:
  containers:
  - name: container1
    env:
    - name: POD_NAME
      valueFrom:
        fieldRef:
          apiVersion: v1
          fieldPath: metadata.name
    image: busybox:1.28
    command: [ "sh", "-c", "while [ true ]; do echo 'Hello'; sleep 10; done | tee -a /logs/hello.txt" ]
    volumeMounts:
    - name: workdir1
      mountPath: /logs
      # The variable expansion uses round brackets (not curly brackets).
      subPathExpr: $(POD_NAME)
  restartPolicy: Never
  volumes:
  - name: workdir1
    hostPath:
      path: /var/log/pods
```

## Resources

The storage media (such as Disk or SSD) of an emptyDir volume is determined by the medium of the filesystem holding the kubelet root dir (typically /var/lib/kubelet). There is no limit on how much space an emptyDir or hostPath volume can consume, and no isolation between containers or between pods.

To learn about requesting space using a resource specification, see **[how to manage resources](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/)**.
