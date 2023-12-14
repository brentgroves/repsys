# R Studio on Kubernetes

## references

<https://costly.medium.com/versatile-rstudio-developement-environment-on-kubernetes-de59fdde1918>

## Deploying RStudio on k8s

First, we will see how we can deploy RStudio using Kubernetes, Deploying RStudio on Kubernetes has many advantages :

Allows exploration tools like RStudio also to be in controlled and secure environments.
With combinations of blobfuse, makes sure the data never leaves the compliance boundary.
Also makes RStudio available in web browser from anywhere.
RStudio, running on cluster can have a lot more resources that can be used by for exploration by R.
With cache interval, you can automatically cache the remote data for longer time as well, for better performance.
We will create a Kubernetes deployment for RStudio. The following YAML describes our RStudio deployment. Dont worry if you don’t all the fields in the YAML, you don’t need to understand all the kubernetes concepts for now.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: rstudio
  labels:
    name: rstudio
spec:
  replicas: 1
  selector:
    matchLabels:
      name: rstudio
  template:
    metadata:
      labels:
        name: rstudio
    spec:
      containers:
      - name : rstudio
        image: rocker/rstudio 
        imagePullPolicy: "Always"
        ports:
        - containerPort: 8787
          protocol: TCP
        command:
         - "/bin/bash"
         - "-c"
         - "--"
        args :
         - 'rstudio-server start ; sleep infinity'
```

I have put these configuration files on github here **[dharmeshkakadia/rstudio-k8s](https://github.com/dharmeshkakadia/rstudio-k8s)**. You can deploy the above YAML directly from github link with:

kubectl create -f <https://raw.githubusercontent.com/dharmeshkakadia/rstudio-k8s/master/rstudio.yaml>
The above deployment doesn’t assign public end point to your RStudio deployment and you can access via local port-forwarding:

kubectl port-forward deploy/rstudio 8787:8787
That’s it! Now you are ready to use RStudio. Go to <http://localhost:8787> and use username and password as rstudio.
