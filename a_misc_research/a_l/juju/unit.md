# **[Unit](https://juju.is/docs/juju/unit)**

**[Back to Research List](../../research_list.md)**\
**[Back to Juju List](./juju_list.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

## references

<https://juju.is/docs/juju/manage-units>

In Juju, a unit is a deployed charm.

An application’s units occupy machines.

Simple applications may be deployed with a single application unit, but it is possible for an individual application to have multiple units running on different machines.

All units for a given application share the same charmed operator code, the same relations, and the same user-provided configuration but one of them called the leader unit is different and is responsible for managing the lifecycle of the application. For example, one may deploy a single MongoDB application, and specify that it should run three units (with one machine per unit) so that the replica set is resilient to failures. Internally, even though the replica set shares the same user-provided configuration, each unit may be performing different roles within the replica set, as defined by the charm. This is represented in the diagram below:

![](https://assets.ubuntu.com/v1/244e4890-juju-machine-units.png)

A unit is always named on the pattern <application>/<unit ID>, where <application> is the name of the application and the <unit ID> is its ID number or, for the leader unit, the keyword leader. For example, mysql/0 or mysql/leader. Note: the number designation is a static reference to a unique entity whereas the leader designation is a dynamic reference to whichever unit happens to be elected by Juju to be the leader .

## Show details about a unit

To see more details about a unit, use the show-unit command followed by the unit name:

```juju show-unit mysql/0```

By using various options you can also choose to get just a subset of the output, a different output format, etc.

See more: juju show-unit

List a unit’s resources

To see the resources for a unit, use the resources command followed by the unit name. For example:

```juju resources mysql/0```

## Show the status of a unit

To see the status of a unit, use the status command:

```juju status```

This will show information about the model, along with its machines, applications and units. For example:

Model           Controller           Cloud/Region        Version  SLA          Timestamp
tutorial-model  tutorial-controller  microk8s/localhost  2.9.34   unsupported  12:10:16+02:00

App             Version                         Status  Scale  Charm           Channel  Rev  Address         Exposed  Message
mattermost-k8s  .../mattermost:v6.6.0-20.04...  active      1  mattermost-k8s  stable    21  10.152.183.185  no
postgresql-k8s  .../postgresql@ed0e37f          active      1  postgresql-k8s  stable     4                  no       Pod configured

Unit               Workload  Agent  Address       Ports     Message
mattermost-k8s/0*active    idle   10.1.179.151  8065/TCP  
postgresql-k8s/0*  active    idle   10.1.179.149  5432/TCP  Pod configured
