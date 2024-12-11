# **[jsonpath](https://stackoverflow.com/questions/36211618/how-to-parse-json-format-output-of-kubectl-get-pods-using-jsonpath)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## reference

- **[here are the docs for jsonpath](https://kubernetes.io/docs/reference/kubectl/jsonpath/)**

## How to parse json format output of : kubectl get pods using jsonpath

How to parse the json to retrieve a field from output of

```bash
kubectl get pods -o json
```

From the command line I need to obtain the system generated container name from a google cloud cluster ... Here are the salient bits of json output from above command :

![jp](https://i.sstatic.net/ysqWI.png)

So the top most json key is an array : items[] followed by metadata.labels.name where the search critera value of that compound key is "web" (see above image green marks). On a match, I then need to retrieve field

`.items[].metadata.name`

which so happens to have value :

`web-controller-5e6ij   // I need to retrieve this value`

**[here are the docs for jsonpath](https://kubernetes.io/docs/reference/kubectl/jsonpath/)**

I want to avoid text parsing output of

```bash
kubectl get pods
NAME                     READY     STATUS    RESTARTS   AGE
mongo-controller-h714w   1/1       Running   0          12m
web-controller-5e6ij     1/1       Running   0          9m
```

Following will correctly parse this get pods command yet I feel its too fragile

```bash
kubectl get pods | tail -1 | cut -d' ' -f1
```

After much battling this one liner does retrieve the container name :

```bash
kubectl get pods -o=jsonpath='{.items[?(@.metadata.labels.name=="web")].metadata.name}'
```

Option 2:

```bash
kubectl get pods -l name=web -o=jsonpath='{.items..metadata.name}'
```
