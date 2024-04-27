# Father's direction

My son you can not find peace and contentment in work.  My intentions for work is that it can be a time we can enjoy together helping others. Peace and contentment will come when you follow me as I guide you in what to say and do. All results of your work are in my hands. I may decide to have you wait or fail at the tasks I have planned for you.  The work I give you is meant to teach you that work can never be a reliable source of peace and contentment. The only reliable source of these wonderful things is doing what is right by following me.

My son do not be anxious when there is so many things to do.  Instead look to us for guidance and we will help you with each task.  Remember we have a plan for you and we will be with you each step of the way so do not worry our son.

We have heard your prayer and will give you courage to face every trial, trouble, pain, and sorrow.  You will be able to endure each hardship because of the faith and hope that we have given you.  So do not fear and rejoice because along with the hardships you must face to learn what you must there will also be great wonders for you to explore with us and those around you!

I love you and will help you to have a loving heart!  I will give you courage and help you to bear each trial and endure every hardship my son.  Do not forget that you are part of a community and I want you to learn to love each person, creature, and even the land where you live.

The world's love is performance based, but my love is unconditional. The world's system promotes fear and says you must perform better than your neighbor.  I say help your neighbor and especially help the ones that are struggling. Do not worry about your own status.  Do not promote yourself instead think of others and help them in their work. Only in this way will you have perfect peace my beloved son.

```text
Good morning dear ones,
I wish each of you a pleasant and prosperous week in this beautiful time of year :-)  As always please feel free to call me at home or at work about anything you like!  

Sincerely yours,
Brent G.
260-564-4868
```

## Report services request

This is a markdown file if it looks a little strange. You could use visual studio code or an online viewer such as <https://dillinger.io/>

## Microsoft 365 E5 Plan

Need E5 or E3 plan to get needed add-ons.
Price per user/month (annual commitment) $57.00

## Add-ons Available for Microsoft 365 E3 and E5 subscriptions

- Power Automate (need this). Enables users to automate repetitive tasks and workflows. Available as an add-on for Microsoft 365 E3 and E5.
- Power BI Pro (need this). Provides advanced data visualization and business intelligence features. Available as an add-on for Microsoft 365 E3 and E5.

## Azure services

- Azure SQL db (need this) - Power Automate used to copy data from Plex to DW.  All that we need with a much lower cost than Azure SQL MI.  
- Azure AKS (Kubernetes) (need this) - Hosts Microsoft teams accessible report request web app.

## Azure DevOps

Azure Repos (need this)
Get unlimited, cloud-hosted private Git repos and collaborate to build better code with pull requests and advanced file management.

Azure pipelines (nice to have)
Build, test, and deploy with CI/CD that works with any language, platform, and cloud. Connect to GitHub or any other Git provider and deploy continuously.

**![MySQL Operator Architecture](https://dev.mysql.com/doc/mysql-operator/en/images/mysql-operator-architecture.png)**

## Failover Testing (How to deal with planned and unplanned reboots)

Used operators to install a 2 instance Postgres and MySQL InnoDB Cluster, and Redis cache database on 3 node K8s Clusters. Then rebooted the nodes in different ways to see what problems can arise and what can be done to fix them. Tested Kured which is meant to assist in the node reboot process while keeping software running on other nodes using a draining technique. Tested MySQL InnoDB data is getting replicated to all the database instanceds. Verified database is still accessible by the router while one node is being rebooted.

## Old to new schemas

- Migrate MySQL 8.0 Server to MySQL InnoDB which has a router and a group replication feature.  The requirement for group replication is that all tables must have a primary key explicitly defined, but most of our MI tables do so this migration should not be difficult.
- Azure CLI script to create an Azure SQL db that meets our data warehousing needs.
- Migrate Azure SQL MI to Azure SQL db. Unfortunately, can't simply backup MI and import into SQL db, so, must write an ETL script.
- Test backup for Azure SQL db once our Azure SQL MI schema is migrated to it.
- Install Redis cache database onto k8s cluster running MySQL InnoDB and Postgres Clusters.  
- Then do planned and unplanned rebooting of K8s nodes trying to crash the software and figuring out what to do in each case.

## reboot use case

### Use kured to drain and reboot nodes after package updates

```bash
# go to node to reboot
sudo touch /var/run/reboot-required
kubectl get nodes -watch
# or
# Or look at the logs to see the reboot
kubectl get pods -n kube-system -owide | grep kured
kubectl logs -f kured-q5v9f -n kube-system
## error rebooting last node
# error when evicting pods/"mycluster-1" -n "default" (will retry after 5s): Cannot evict pod as it would violate the pod's disruption budget.
# sometimes it does finally reboot the last node but then

kubectl get all
pod/mycluster-router-6444b6fc88-rr4d2   0/1     CrashLoopBackOff   7 (110s ago)   13m

# change the router instances to 0 and wait for the router pod and deployment to be removed
kubectl edit innodbcluster mycluster
# set the router instance to 1
kubectl edit innodbcluster mycluster

# kubectl edit postgresql acid-minimal-cluster

kubectl get pods -n kube-system -owide | grep kured
kubectl logs -f kured-w9gqk -n kube-system
kubectl edit postgresql.acid.zalan.do/acid-minimal-cluster

kubectl edit innodbcluster mycluster

```

```yaml
apiVersion: "acid.zalan.do/v1"
kind: postgresql
metadata:
  name: acid-minimal-cluster
spec:
  teamId: "acid"
  volume:
    size: 20Gi
  numberOfInstances: 2
```
