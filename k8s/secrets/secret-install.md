# Install username/passwords/misc

<https://kubernetes.io/docs/concepts/configuration/secret/>

## Managing secrets

Note: I'm not only using these for secrets but for cluster specific environment variables that will be used in cronjobs since cron jobs have an environment of their own and do not have access to k8s deployment variables like the bash environment.

## Create a secret

A Secret can contain user credentials required by pods to access a database. For example, a database connection string consists of a username and password. You can store the username in a file ./username.txt and the password in a file ./password.txt on your local machine.

    username = 'mg.odbcalbion' 
    password = 'Mob3xalbion' 

### create text files to store name/value pairs

This seemed to work best. Can use nvim but not visual studio code.
echo "mg.odbcalbion" > ./username.txt
echo "Mob3xalbion" > ./password.txt
echo "reports51" > ./reports51.txt

This does not work because a % character is added to the file.
printf %s "mg.odbcalbion" >> ./username.txt
printf %s "Mob3xalbion" >> ./password.txt

This does not work because a % character is added to the file.
echo -n 'mg.odbcalbion' > ./username.txt
echo -n 'Mob3xalbion' > ./password.txt

### Install secret on dev system

    ```bash
pushd ~/src/reports/k8s/reports5/secrets/
// run sed to set cluster specific values
./sed-lastpass-sh.sh reports31 30031 reports32 30331 reports 1
./sed-lastpass-sh.sh reports51 30051 reports52 30351 reports 1
// copy passwords to /etc/lastpass on dev system
./lastpass.sh
// verify name/value pairs
./print-etc-lastpass.sh
    ```

### Install secret on k8s cluster

    ```bash

pushd /home/brent/src/reports/k8s/reports5/secrets/db-user-pass

// set kubectl context

scc.sh reports5.yaml microk8s

// make sure secret is not already installed

kubectl get secret db-user-pass -o jsonpath='{.data}'
Error from server (NotFound): secrets "db-user-pass" not found

kubectl create secret generic db-user-pass \
  --from-file=username=./username.txt \
  --from-file=password=./password.txt \
  --from-file=username2=./username2.txt \
  --from-file=password2=./password2.txt \
  --from-file=username3=./username3.txt \
  --from-file=password3=./password3.txt \
  --from-file=username4=./username4.txt \
  --from-file=password4=./password4.txt \
  --from-file=username5=./username5.txt \
  --from-file=password5=./password5.txt \
  --from-file=username6=./username6.txt \
  --from-file=password6=./password6.txt \
  --from-file=username7=./username7.txt \
  --from-file=password7=./password7.txt \
  --from-file=username8=./username8.txt \
  --from-file=password8=./password8.txt \
  --from-file=username9=./username9.txt \
  --from-file=password9=./password9.txt \
  --from-file=username10=./username10.txt \
  --from-file=password10=./password10.txt \
  --from-file=username11=./username11.txt \
  --from-file=password11=./password11.txt \
  --from-file=MYSQL_HOST=./reports51.txt \
  --from-file=AZURE_DW=./azure_dw_1.txt

pick 1 host for cluster
  --from-file=MYSQL_HOST=./reports03.txt \
  --from-file=MYSQL_HOST=./reports13.txt \
  --from-file=MYSQL_HOST=./reports51.txt \
  --from-file=MYSQL_HOST=./moto.txt \
  --from-file=MYSQL_PORT=./mysql_port.txt \
choose if azure dw is to be updated
  --from-file=AZURE_DW=./azure_dw_1.txt
  --from-file=AZURE_DW=./azure_dw_0.txt

    ```

### How kubectl works with file based input

kubectl reads a file and encodes the content into a base64 string.

### verify cluster secret

      ```bash
kubectl get secret db-user-pass -o jsonpath='{.data}'
kubectl get secret db-user-pass -o jsonpath='{.data.password}' | base64 --decode
      ```

## usage of db-user-pass secrets

The db-user-pass secret is mounted at /etc/foo.  To access the content you simply access the file.  In bash this could be done as so:

### from TrialBalance.sh

export username=$(</etc/db-user-pass/username)

### section from reports-cron/output/reports11-deploy.yaml

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

## Creating

## References

<https://kubernetes.io/docs/concepts/configuration/secret/>
<https://kubernetes.io/docs/tasks/configmap-secret/managing-secret-using-kubectl/>

## Misc notes

kubectl create secret generic db-user-pass \
  --from-literal=username='mg.odbcalbion' \
  --from-literal=password='Mob3xalbion'
  --from-literal=username2='mgadmin' \
  --from-literal=password2='WeDontSharePasswords1!'

kubectl delete secret db-user-pass

kubectl get secret db-user-pass -o jsonpath='{.data}'
kubectl get secret db-user-pass -o jsonpath='{.data.password}' | base64 --decode

You do not need to escape special characters in password strings that you include in a file.

You can also provide Secret data using the --from-literal=<key>=<value> tag. This tag can be specified more than once to provide multiple key-value pairs. Note that special characters such as $, \, *, =, and ! will be interpreted by your shell and require escaping.

In most shells, the easiest way to escape the password is to surround it with single quotes ('). For example, if your password is S!B\*d$zDsb=, run the following command:

kubectl create secret generic db-user-pass \
  --from-literal=username=devuser \
  --from-literal=password='S!B\*d$zDsb='
Verify the Secret
Check that the Secret was created:

kubectl get secrets

The output is similar to:

NAME                  TYPE                                  DATA      AGE
db-user-pass          Opaque                                2         51s
You can view a description of the Secret:

kubectl describe secrets/db-user-pass
The output is similar to:

Name:            db-user-pass
Namespace:       default
Labels:          <none>
Annotations:     <none>

Type:            Opaque

Data
====

password:    12 bytes
username:    5 bytes
The commands kubectl get and kubectl describe avoid showing the contents of a Secret by default. This is to protect the Secret from being exposed accidentally, or from being stored in a terminal log.

Decoding the Secret
To view the contents of the Secret you created, run the following command:

kubectl get secret db-user-pass -o jsonpath='{.data}'
The output is similar to:

{"password":"MWYyZDFlMmU2N2Rm","username":"YWRtaW4="}

Now you can decode the password data:

# This is an example for documentation purposes

# If you did things this way, the data 'MWYyZDFlMmU2N2Rm' could be stored in

# your shell history

# Someone with access to you computer could find that remembered command

# and base-64 decode the secret, perhaps without your knowledge

# It's usually better to combine the steps, as shown later in the page

echo 'MWYyZDFlMmU2N2Rm' | base64 --decode
The output is similar to:

1f2d1e2e67df
In order to avoid storing a secret encoded value in your shell history, you can run the following command:

kubectl get secret db-user-pass -o jsonpath='{.data.password}' | base64 --decode
The output shall be similar as above.
