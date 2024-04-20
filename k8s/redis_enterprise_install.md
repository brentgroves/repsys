<https://redis.io/docs/latest/operate/kubernetes/deployment/quick-start/>
To deploy Redis Enterprise for Kubernetes, you'll need:
<https://redis.io/docs/latest/operate/rs/installing-upgrading/>
<https://redis.io/docs/latest/operate/kubernetes/re-clusters/connect-to-admin-console/>

a Kubernetes cluster in a supported distribution
a minimum of three worker nodes
a Kubernetes client (kubectl)
access to DockerHub, RedHat Container Catalog, or a private repository that can hold the required images.

```bash
kubectl create namespace redis-enterprise
kubectl config set-context --current --namespace=redis-enterprise
VERSION=`curl --silent https://api.github.com/repos/RedisLabs/redis-enterprise-k8s-docs/releases/latest | grep tag_name | awk -F'"' '{print $4}'`
kubectl apply -f https://raw.githubusercontent.com/RedisLabs/redis-enterprise-k8s-docs/$VERSION/bundle.yaml
kubectl get deployment redis-enterprise-operator
cat <<EOF > my-rec.yaml
apiVersion: "app.redislabs.com/v1"
kind: "RedisEnterpriseCluster"
metadata:
  name: my-rec
spec:
  nodes: 3
EOF

This will request a cluster with three Redis Enterprise nodes using the default requests (i.e., 2 CPUs and 4GB of memory per node).
kubectl apply -f ./redis_enterprise/redis_enterprise_cluster.yaml
kubectl get rec
kubectl rollout status sts/my-rec

```
