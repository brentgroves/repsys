# **[model](https://documentation.ubuntu.com/juju/3.6/reference/model/)**

The Juju application modeling tool simplifies the deployment and lifecycle management of the cluster and its components.

In Juju, a model is an abstraction that holds applications and application supporting components – machines, storage, network spaces, relations, etc.

A model is created by a user, and owned in perpetuity by that user (or a new user with the same name), though it may also be used by any other user with model access level, within the limits of their level.

A model is created on a controller. Both the model and the controller are associated with a cloud (and a cloud credential), though they do not both have to be on the same cloud (this is a scenario where you have a ‘multicloud controller’ and where you may have ‘cross-model relations (integrations)’). Any entities added to the model will use resources from that cloud.

One can deploy multiple applications to the same model. Thus, models allow the logical grouping of applications and infrastructure that work together to deliver a service or product. Moreover, one can apply common configurations to a whole model. As such, models allow the low-level storage, compute, network and software components to be reasoned about as a single entity as well.
