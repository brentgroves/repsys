# Azure Resources with Cost Savings

The following is in markdown format it can be viewed better from <https://markdownlivepreview.com/> by copying and pasting the contents below.

Found an article describing a way to stop the cluster when not in use which will significantly save cost.

## Players

- Adrian Wise
- Kristian Smith
- Aamir Ghaffar
- Christian Trujillo
- Brent Hall
- Kevin Young
- Jared Davis
- Dan Martin
- Heather Luttrell

## Status

The RITM0185614 configuration request has been approved by Adrian Wise. 

## **[Azure Cost Savings](https://trstringer.com/cheap-kubernetes-in-azure/)**

### Stop your cluster

AKS just recently introduced a new feature to **[stop and start a Kubernetes cluster](https://docs.microsoft.com/en-us/azure/aks/start-stop-cluster)**. Until we start running reports and we complete the the Tool Management and Tracker software, we can stop it often. 

To stop the cluster, it is as easy as running:

```bash
$ az aks stop \
    --resource-group <resource_group> \
    --name <aks>
```

![stopped cluster cost](https://trstringer.com/images/aks-cheap-off.png)

Our cluster may cost a little more but this stopped cluster only costs $4.05USD per week. That’s only $0.58USD per day!

