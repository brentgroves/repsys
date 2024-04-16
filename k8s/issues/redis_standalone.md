# Issue

Ran the following after install and it worked fine, but ran it the next day and the first couple of set command returned nil. I could not see any errors with kubectl get all -n ot-opererators command then the 3rd or 4th time I ran kubectl exec the sets started working again.

```bash
# get command prompt if password set use -a
kubectl exec -it redis-0 -n ot-operators -- redis-cli -a password
set tony stark
set t2 t2
kubectl exec -it redis-0 -n ot-operators \
    -- redis-cli -a password -c set t2 t2
kubectl exec -it redis-0 -n ot-operators \
    -- redis-cli -a password PING


```
