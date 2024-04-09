# k8s secret

## Create K8s secrets

Note: I'm not only using these for secrets but for cluster specific environment variables that will be used in cronjobs since cron jobs have an environment of their own and do not have access to k8s deployment variables like the bash environment.

## references

<https://kubernetes.io/docs/tasks/configmap-secret/managing-secret-using-kubectl/>

https://devpress.csdn.net/k8s/62fd80587e6682346619261b.html

## Create a config map 

```yaml
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: db
data:
  mysql-database: database
---  
```
## Create base64 encoded yaml

This yaml should be stored privately and not in a public repo and backed up onto a usb device.

```yaml
apiVersion: v1
kind: Secret
metadata:
   name: db-credentials
type: Opaque
data:
# https://devpress.csdn.net/k8s/62fd80587e6682346619261b.html
# Test1234
  mysql-password: VGVzdDEyMzQ=
  mysql-root-password: VGVzdDEyMzQ=
  # testadm
  mysql-user: dGVzdGFkbQ==
```

## reference a configmap and secret

```yaml
      - env:
        - name: MYSQL_DATABASE
          valueFrom:
            configMapKeyRef:
              name: db
              key: mysql-database
        - name: MYSQL_ROOT_PASSWORD
          valueFrom:
            secretKeyRef:
              name: db-credentials
              key: mysql-root-password
        - name: MYSQL_USER
          valueFrom:
            secretKeyRef:
              name: db-credentials
              key: mysql-user
        - name: MYSQL_PASSWORD
          valueFrom:
            secretKeyRef:
              name: db-credentials
              key: mysql-password

```

## Creating a mount for secrets

This technique is used to export environment variables from secrets.

The db-user-pass secret is mounted at /etc/foo.  To access the content you simply access the file.  In bash this could be done as so:

### from TrialBalance.sh

```bash
export username=$(</etc/db-user-pass/username)
```

### section from reports-cron/output/reports11-deploy.yaml

```yaml
        volumeMounts:
        - name: foo
          mountPath: "/etc/foo"
          readOnly: true
      volumes:
      - name: foo
        secret:
          secretName: db-user-pass
          optional: false # default setting; "mysecret" must exist    
        # imagePullPolicy: IfNotPresent
      restartPolicy: Always  
```

