# **[Juju integrate](https://juju.is/docs/juju/juju-integrate)**

**[Back to Juju List](./juju_list.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

## references

<https://juju.is/docs/juju/manage-relations>

## Add a same-model relation

juju
To set up a relation between two applications on the same model, run the integrate command followed by the names of the applications. For example:

juju integrate mysql wordpress
This will satisfy WordPress’s database requirement where MySQL provides the appropriate schema and access credentials required for WordPress to run properly.

The code above however works only if there is no ambiguity in what relation the charm requires and what the related charm provides.

If the charms in question are able to establish multiple relation types, Juju may need to be supplied with more information as to how the charms should be joined. For example, if we try instead to relate the ‘mysql’ charm to the ‘mediawiki’ charm:

juju integrate mysql mediawiki
the result is an error:

error: ambiguous relation: "mediawiki mysql" could refer to
  "mediawiki:db mysql:db"; "mediawiki:slave mysql:db"
  
Integrate two applications. Integrated applications communicate over a common interface provided by the Juju controller that enables units to share information. This topology allows units to share data, without needing direct connectivity between units is restricted by firewall rules. Charms define the logic for transferring and interpreting integration data.

The most common use of ‘juju integrate’ specifies two applications that co-exist within the same model:

juju integrate <application> <application>
Occasionally, more explicit syntax is required. Juju is able to integrate units that span models, controllers and clouds, as described below.

Integrating applications in the same model

The most common case specifies two applications, adding specific endpoint name(s) when required.

juju integrate <application>[:<endpoint>] <application>[:<endpoint>]
The role and endpoint names are described by charms’ metadata.yaml file.

The order does not matter, however each side must implement complementary roles. One side implements the “provides” role and the other implements the “requires” role. Juju can always infer the role that each side is implementing, so specifying them is not necessary as command-line arguments.

<application> is the name of an application that has already been added to the model. The Applications section of ‘juju status’ provides a list of current applications.

<endpoint> is the name of an endpoint defined within the metadata.yaml of the charm for <application>. Valid endpoint names are defined within the “provides:” and “requires:” section of that file. Juju will request that you specify the <endpoint> if there is more than one possible integration between the two applications.
