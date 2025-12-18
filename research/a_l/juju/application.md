# **[Application](https://juju.is/docs/juju/application)**

**[Back to Research List](../../research_list.md)**\
**[Back to Juju List](./juju_list.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

In Juju, an application is a running abstraction of a charm in the Juju model. It is whatever software is defined by the charm. This could correspond to a traditional software package but it could also be less or more.

An application is always hosted within a model and consists of one or more units.

Interaction between applications is handled by integrations (before Juju v.3.0, relations).

An application has can have resources, a configuration, the ability to form relations (integrations), and actions.
