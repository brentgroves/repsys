namespace/stackgres created
customresourcedefinition.apiextensions.k8s.io/sgbackups.stackgres.io created
customresourcedefinition.apiextensions.k8s.io/sgbackupconfigs.stackgres.io created
customresourcedefinition.apiextensions.k8s.io/sgdbops.stackgres.io created
customresourcedefinition.apiextensions.k8s.io/sgdistributedlogs.stackgres.io created
customresourcedefinition.apiextensions.k8s.io/sginstanceprofiles.stackgres.io created
customresourcedefinition.apiextensions.k8s.io/sgobjectstorages.stackgres.io created
customresourcedefinition.apiextensions.k8s.io/sgpoolconfigs.stackgres.io created
customresourcedefinition.apiextensions.k8s.io/sgpgconfigs.stackgres.io created
customresourcedefinition.apiextensions.k8s.io/sgscripts.stackgres.io created
clusterrolebinding.rbac.authorization.k8s.io/stackgres-restapi-admin created
clusterrolebinding.rbac.authorization.k8s.io/stackgres-restapi created
service/stackgres-operator created
service/stackgres-restapi created
deployment.apps/stackgres-operator created
deployment.apps/stackgres-restapi created
serviceaccount/stackgres-operator-init created
clusterrolebinding.rbac.authorization.k8s.io/stackgres-operator-init created
job.batch/stackgres-operator-cr-updater created
serviceaccount/stackgres-operator created
job.batch/stackgres-operator-crd-upgrade created
job.batch/stackgres-operator-conversion-webhooks created
job.batch/stackgres-operator-create-certificate created
job.batch/stackgres-operator-set-crd-version created
job.batch/stackgres-operator-wait created
serviceaccount/stackgres-restapi created
secret/stackgres-restapi created
configmap/stackgres-operator-grafana-dashboard created
configmap/stackgres-restapi-nginx created
clusterrole.rbac.authorization.k8s.io/stackgres-operator created
clusterrole.rbac.authorization.k8s.io/stackgres-restapi created
clusterrolebinding.rbac.authorization.k8s.io/stackgres-operator created
Error from server (Invalid): error when creating "<https://stackgres.io/downloads/stackgres-k8s/stackgres/1.5.0/stackgres-operator-demo.yml>": CustomResourceDefinition.apiextensions.k8s.io "sgclusters.stackgres.io" is invalid: metadata.annotations: Too long: must have at most 262144 bytes
Error from server (Invalid): error when creating "<https://stackgres.io/downloads/stackgres-k8s/stackgres/1.5.0/stackgres-operator-demo.yml>": CustomResourceDefinition.apiextensions.k8s.io "sgshardedclusters.stackgres.io" is invalid: metadata.annotations: Too long: must have at most 262144 bytes
(
