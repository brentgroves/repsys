# Metrics Server

## References

<https://microk8s.io/docs/addons>
<https://github.com/kubernetes-sigs/metrics-server>
<https://kubernetes.io/docs/tasks/debug/debug-cluster/resource-metrics-pipeline/>

## Resource metrics pipeline

For Kubernetes, the Metrics API offers a basic set of metrics to support automatic scaling and similar use cases. This API makes information available about resource usage for node and pod, including metrics for CPU and memory. If you deploy the Metrics API into your cluster, clients of the Kubernetes API can then query for this information, and you can use Kubernetes' access control mechanisms to manage permissions to do so.

The HorizontalPodAutoscaler (HPA) and VerticalPodAutoscaler (VPA) use data from the metrics API to adjust workload replicas and resources to meet customer demand.

You can also view the resource metrics using the kubectl top command.

Note: The Metrics API, and the metrics pipeline that it enables, only offers the minimum CPU and memory metrics to enable automatic scaling using HPA and / or VPA. If you would like to provide a more complete set of metrics, you can complement the simpler Metrics API by deploying a second metrics pipeline that uses the Custom Metrics API.

## Enable Metrics Server

```bash
kubectl top nodes
error: Metrics API not available
microk8s enable metrics-server
NAME        CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%   
reports11   223m         2%     2077Mi          26%       
reports12   396m         4%     2351Mi          30%       
reports13   265m         3%     4793Mi          49%  
```
