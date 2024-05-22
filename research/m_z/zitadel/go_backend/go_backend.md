# **[ZITADEL with Go (Backend)](https://zitadel.com/docs/examples/secure-api/go)**

**[Back to Go Tutorial List](../../tutorial_list.md)**\
**[Back to Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../../../README.md)**

## references

**[Zitadel Python](../../../../../research/m_z/zitadel/zitadel_article.md)**
**[Go Web Docker](../../docker/go_web_docker/go_web_docker.md)**
**[go zit backend](../../../../../../go_zit_backend/README.md)**

This integration guide shows you how to integrate ZITADEL into your Go API. It demonstrates how to secure your API using OAuth 2 Token Introspection.

At the end of the guide you should have an API with a protected endpoint.

This documentation references our HTTP example. There's also one for GRPC. Check them out on **[GitHub](https://github.com/zitadel/zitadel-go/blob/next/example/api/http/main.go)**.

## Set up application and obtain keys

Before we begin developing our API, we need to perform a few configuration steps in the ZITADEL Console. You'll need to provide some information about your app. We recommend creating a new app to start from scratch. Navigate to your Project, then add a new application at the top of the page. Select the API application type and continue.

## Create the GitHub Repository

We’ll use **[Go mod](https://blog.golang.org/using-go-modules)**, the official module manager, to handle Go modules in a portable way without having to worry about GOPATH.

A module is a collection of Go packages stored in a file tree with a go.mod file at its root. The go.mod file defines the module’s module path, which is also the import path used for the root directory, and its dependency requirements, which are the other modules needed for a successful build. Each dependency requirement is written as a module path and a specific semantic version.

## Go to **[go_zit_backend](../../../../../go_zit_backend/README.md)**
