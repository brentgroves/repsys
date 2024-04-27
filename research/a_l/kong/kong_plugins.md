# Kong Plugins

## references

<https://docs.konghq.com/hub/plugins/overview/>

## What are plugins?

Kong Gateway is a Lua application designed to load and execute Lua or Go modules, which we commonly refer to as plugins. Kong provides a set of standard Lua plugins that get bundled with Kong Gateway. The set of plugins you have access to depends on your installation: open-source, enterprise, or either of these Kong Gateway options running on Kubernetes.

Custom plugins can also be developed by the Kong Community and are supported and maintained by the plugin creators. If they are published on the Kong Plugin Hub, they are called Community or Third-Party plugins.

## Why use plugins?

Plugins provide advanced functionality and extend the use of the Kong Gateway, which allows you to add new features to your implementation. Plugins can be configured to run in a variety of contexts, ranging from a specific route to all upstreams, and can execute actions inside Kong before or after a request has been proxied to the upstream API, as well as on any incoming responses.

## Plugin compatibility with deployment types

Kong Gateway can be deployed in a variety of ways, and not all plugins are fully compatible with each mode. See Plugin Compatibility for a comparison.

## Precedence

A single plugin instance always runs once per request. The configuration with which it runs depends on the entities it has been configured for. Plugins can be configured for various entities, combinations of entities, or even globally. This is useful, for example, when you want to configure a plugin a certain way for most requests, but make authenticated requests behave slightly differently.

Therefore, there is an order of precedence for running a plugin when it has been applied to different entities with different configurations. The amount of entities configured to a specific plugin directly correlate to its priority. The more entities configured to a plugin the higher its order of precedence is. The complete order of precedence for plugins configured to multiple entities is:

## Terminology

Plugin
An extension to the Kong Gateway.
For plugins developed and maintained by Kong, plugin versioning generally has no impact on your implementation, other than to find out which versions of Kong contain which plugin features. Kong plugins are bundled with the Kong Gateway, so compatible plugin versions are already associated with the correct version of Kong.

Kong plugin or Kong bundled plugin
A plugin developed, maintained, and supported by Kong.
Because third-party plugins are not maintained by Kong and are not bundled with the Kong Gateway, version compatibility is a bigger concern. See each individual plugin’s page for its tested compatibility.

If the versions on the plugin page are outdated, contact the maintainer directly.

Unsupported plugin
A custom plugin developed, tested, and maintained by an external developer, not by Kong. Kong does not test these plugins, or update their version compatibility.
Partner plugin
Definition TBD

## Developing custom plugins

Kong provides an entire development environment for developing plugins, including Lua and Go SDKs, database abstractions, migrations, and more.

Plugins consist of modules interacting with the request/response objects or streams via a Plugin Development Kit (or PDK) to implement arbitrary logic. Kong provides PDKs for two languages: Lua and Go. Both of these PDKs are sets of functions that a plugin can use to facilitate interactions between plugins and the core (or other components) of Kong.

To start creating your own plugins, check out the PDK documentation:

Plugin Development Guide
Plugin Development Kit reference
Other Language Support

## Next

<https://docs.konghq.com/hub/kong-inc/basic-auth/>
