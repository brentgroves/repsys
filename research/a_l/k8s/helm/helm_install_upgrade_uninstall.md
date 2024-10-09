# **[Understanding Helm Install, Upgrade, and Uninstall Actions](https://www.microfocus.com/documentation/securelogin/9.1/slae_installation_config_guide/t4fyvi485xwx.html)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

BackendTLSPolicy is a Gateway API type for specifying the TLS configuration of the connection from the Gateway to a backend pod/s via the Service API object.

## Helm Install

Use this action when you create SecureLogin server configuration for the first time. Run the following command to perform Helm installation:

```bash
helm install <name-of-the-release> <name-of-the-helm-chart> -n <namespace>
```

For example, ```helm install slserver001 SecureLogin-Server-x.x.x.x -n nsl-namespace```

where, slserver001 is the release name, SecureLogin-Server-x.x.x.x is the name of the helm chart, and nsl-namespace is the name of the namespace.

**NOTE:**\
Helm uninstall and re-install is not recommended when a configuration change is needed. This process removes all the pods and service before a new instance is deployed.

## Helm Upgrade

HELM upgrade is recommended when you make any change in the configuration of the SecureLogin server. This process upgrades the replica of server instances one after another. This approach keeps the service available during the upgrade process.

Run the following command to perform Helm upgrade:

```bash
helm upgrade <release-name> <name-of-the-helm-chart> -n <name-of-the-namespace>
```

For example:

```bash
helm upgrade slserver SecureLogin-Server-x.x.x.x -n nsl-ingress
# combine upgrade and install
# helm install <name-of-the-release> <name-of-the-helm-chart> -n <namespace>

helm upgrade --install kgo kong/gateway-operator -n kong-system --create-namespace --set image.tag=1.3

```

**NOTE:**\
If you change a value, you must change the associated secret. When the old secret name exists in the current deployment, the change does not take place after the upgrade.

If you change a value and do not change the associated secret, the change will not take place after the upgrade.

For example, if you change the database credentials in the values.yaml file, you must change its secret name for the new value of credentials to take effect.

1. List all secret values for the current deployment.

    Use the following command to list all the secrets for the current deployment:

    ```kubectl get secret -n <ingress namespace>```

2. If the DB secret name is already in use with the current deployment, modify the required DB credentials and its secret name.
3. Perform Helm upgrade.

## Helm Uninstall

Ensure that you have successfully uninstalled the helm release, before reinstalling. To list all the releases, use the following command:

```helm list -n <namespace>```

For example, ```helm list -n nsl-ingress```

![list](https://www.microfocus.com/documentation/securelogin/9.1/slae_installation_config_guide/graphics/releases.png)

To uninstall a release, use the following command:

```helm uninstall <name-of-the-release> -n <namespace>```
