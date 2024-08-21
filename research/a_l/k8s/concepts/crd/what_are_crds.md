# **[What are CRDs](https://www.loft.sh/blog/kubernetes-crds-custom-resource-definitions)**

**[Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research_list.md)**\
**[Back Main](../../../../../README.md)**

## Kubernetes Custom Resource Definitions (CRDs)

Kubernetes is a powerful tool with a lot of functionality, but sometimes you might need to extend that functionality to suit your use case better. This is where Custom Resource Definitions (CRDs) come in. CRDs allow you to introduce your own resource types, which follow the same patterns set out by the first-party core resources. In this article, you will see how to define a CRD and use it to create a custom resource. You will also see some examples of use cases that are a good fit for CRDs, and some that are not a good fit.

## What Are CRDs?

In Kubernetes, a resource is essentially a collection of similar objects, accessible via the Kubernetes API. Kubernetes comes with several resources by default which you are likely familiar with, including Pods, Deployments, ReplicaSets, etc. CRDs are Kubernetes’ way of allowing you to extend the Kubernetes API to store and access your own API objects. This means you can work with them in the same way you would with its core resources.

Creating custom resources in this way has some benefits. CRDs are stored in etcd alongside core resources and can take advantage of the same functionality, such as replication and lifecycle management. This can save a lot of effort in that you don’t have to build it yourself, and you can instead rely on a well-known, stable foundation.

It is important to note that **CRDs by themselves are just data.** They do not have any logic attached to them, nor any special behavior. Alone, their primary purpose is to provide a mechanism for creating, storing, and exposing Kubernetes API objects containing data that you have deemed useful. **It is possible to bring more advanced functionality into the fold by implementing controllers or operators for these custom resources**, which allows you to extend the behavior of Kubernetes without needing to modify the underlying code. This pairs well with CRDs, and between the two, you can implement some relatively advanced features and functionality. Controllers and operators will not be covered in this article, but bear in mind that they would be the behavior aspect of many workflows involving CRDs.

Creating a CRD is done much like most things in Kubernetes, with a YAML file. Take the following basic resource definition, taken from the official documentation, for example:

```yaml
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  # name must match the spec fields below, and be in the form: <plural>.<group>
  name: crontabs.stable.example.com
spec:
  # group name to use for REST API: /apis/<group>/<version>
  group: stable.example.com
  # list of versions supported by this CustomResourceDefinition
  versions:
    - name: v1
      # Each version can be enabled/disabled by Served flag.
      served: true
      # One and only one version must be marked as the storage version.
      storage: true
      schema:
        openAPIV3Schema:
          type: object
          properties:
            spec:
              type: object
              properties:
                cronSpec:
                    type: string
                image:
                    type: string
                replicas:
                    type: integer
  # either Namespaced or Cluster
  scope: Namespaced
  names:
    # plural name to be used in the URL: /apis/<group>/<version>/<plural>
    plural: crontabs
    # singular name to be used as an alias on the CLI and for display
    singular: crontab
    # kind is normally the CamelCased singular type. Your resource manifests use this.
    kind: CronTab
    # shortNames allow shorter string to match your resource on the CLI
    shortNames:
      - ct
```

This is essentially a bare-bones CRD, with the minimum set of properties required for it to meaningfully parse. The most interesting bits here are the names and the schema. The names are strings that we will be able to use to interact with this resource, using the API or kubectl. In this case, you could say ```kubectl get crontabs``` and it would show you any custom resources of this type. Each of those resources would, in turn, contain data according to the schema specified here. Remember, without controllers or other things to make use of them, custom resources are essentially just declarative objects. So the schema is quite essential, as it will define the shape of that object. In this case, the schema contains a “cronSpec,” which denotes how often the CronJob should run, as well as an image, which the CronJob would presumably run.

If you are following along on your own, save the contents of this snippet into a file such as crd.yaml, and then run the following command: ```kubectl create -f crd.yaml.```

This will create the custom resource type on your cluster. From here, you can create resource objects using the CRD with the following YAML:

```yaml
apiVersion: "stable.example.com/v1"
kind: CronTab
metadata:
  name: my-crontab
spec:
  cronSpec: "* * * * */5"
  image: hello-world
```

Save this into a file such as cron.yaml and then run ```kubectl apply -f cron.yaml```. This will create a resource using your CRD. Again, without a controller to handle this custom resource, it is just a data object and won’t actually do anything on a schedule like traditional CronJobs. You can see the new resource you just created by running ```kubectl get crontabs```.

Because CRDs are essentially simple data objects, many use cases can employ them, but there are also many use cases where they might not be the best fit. There are multiple things to consider to determine whether or not CRDs are suitable for your use case. The main benefit of a CRD over a different mechanism is that it has natural, first-class citizenship in the Kubernetes cluster. This means it can take advantage of things like namespaces, can be interacted with via kubectl, and can be monitored with Kubernetes UI tools.

It’s important to examine if these traits would be advantageous to your use case. For example, having a resource scope to a specific namespace can be beneficial in many cases. Consider a scenario where you run the same application in multiple namespaces, perhaps a production and nonproduction namespace. Having something like the CronTab example above running in different namespaces would be advantageous. It is unlikely that you would want to mix your CronJobs between prod and non-prod. This makes it a good candidate for being a custom resource in this case.

On the other hand, you might have something that could be shared by all application instances, regardless of namespace. Take wildcard SSL certificate details, for example. While it is technically possible to store this data in a custom resource, in this case it is not the best approach. The same details are likely to be shared by multiple namespaces, so namespace scoping is not desirable.

## Using CRDs Effectively

As with any tool, there is a time and place for CRDs. CRDs offer a powerful way to integrate Kubernetes more deeply with your use case, but consideration should be given before using them for each piece of config data. As touched on previously, the most significant advantage offered by CRDs is their tight integration with the Kubernetes ecosystem, including UI tools, CLI and API clients, and support features like Finalizers. If none of these traits are advantageous to your use case, you might be better off avoiding CRDs in favor of a more traditional implementation.

When evaluating your potential use case for CRDs, it is also essential to consider complexity. Generally speaking, it is advisable to avoid complex solutions if they don’t offer good value in return. With this in mind, evaluate well-known solutions which might help you achieve what you are trying to do. While it could be entirely possible to solve your problem using CRDs, existing solutions have the benefit of being well-documented and understood. Consider a case where you might create a CRD to bundle a deployment, service, and ingress resource all into one custom resource. Ignoring the fact that you would need a custom controller or operator for this to work, this approach adds unnecessary complexity to an already solved problem. When people work with Kubernetes, they expect each of those things to be separate. Even if you did manage to combine them into a single CRD, it would be harder for newcomers on the project to understand, and it wouldn’t add anything which wasn’t already there. For this reason, this use case is probably not a great fit for CRDs.

## Conclusion

As you can see, creating CRDs is a relatively simple process. It is finding good use cases for them which can prove tricky. It is crucial to evaluate your use case to ensure that CRDs are a good solution to your problem and that you are not making things unnecessarily complex. If CRDs are a good fit for your use case, they can be very valuable in that they provide tighter integration with your Kubernetes cluster than you would otherwise be able to attain. If CRDs seem to be a good fit for you, remember that you can look further into controllers to add some custom behavior and functionality to them beyond being simple objects. Otherwise, if you are simply looking for a way to handle some of your data “the Kubernetes way,” CRDs may very well have you covered.
