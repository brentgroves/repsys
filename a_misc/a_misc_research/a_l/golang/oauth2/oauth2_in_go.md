# OAuth2

## references

<https://www.sohamkamani.com/golang/oauth/>

## Creating an OAuth2 Client in Golang (With Full Examples)

In this post we will see how we can implement OAuth2 authentication in a Go web application.

We will create a working website that can allow a user to sign in using Github authentication.

## How OAuth2 Works

Let’s take a brief look at the OAuth protocol before we jump into implementation.

If you’ve ever seen a dialog like this, then you’ve probably used OAuth before:

![alt](https://www.sohamkamani.com/golang/oauth/oauth-example-screenshot-small.png?ezimgfmt=rs:616x700/rscb1/ng:webp/ngcb1)

Here, we are trying to login to Gitlab using Github to authenticate.

There are three parties in any OAuth mechanism:

- The client - The person, or user who is trying to log in
- The consumer - The application that the client wants to log into (which is Gitlab in this example)
- The service provider - The external application that authenticates the users identity. (which is Github in this example)

n this post, we’ll create a Go HTTP server (consumer) that uses Github’s OAuth2 API (service provider) to authenticate the user (client).

Let’s look at an overview of how this would work in practice.

![alt](https://www.sohamkamani.com/golang/oauth/golang-oauth.svg)

Let’s look at how to implement each part:

## Creating the Landing Page

Lets create the first part of the application, which is the landing page. This will be a basic HTML page, with a link that the user can click on to authenticate with Github.

We can create a new file, public/index.html:

To continue this article go to **[OAuth2 in Golang](../../../volumes/go/tutorials/http/oauth2/oauth2_in_go.md)**:
