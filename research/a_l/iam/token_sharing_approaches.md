# **[Token Sharing Approaches](https://curity.io/resources/learn/token-sharing/)**

**[Back to Research List](../../research_list.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

Nowadays applications are complex systems consisting of many elements. Gone are the days of a simple monolith, where everything you needed to serve your users was kept in one service or one database. Currently, you will have a mesh of microservices dealing with different features, or a have monolith-like core which talks to different external services that add functions to your core which you don't want to maintain yourself. You can also have some kind of mix of these approaches. However, your solution looks like, it's very probable that, to process a request from your user, you will have to touch multiple domains and cross security boundaries.

For example, let's say you have an e-commerce site, which enables the customers to pay for orders with an installment scheme. During a request to place an order you could use the help of a few different systems. You could: verify the identity of the customer with an external ID verification system, then check with another system if the user operates from a country you allow using geolocation, then ask a credit-rating system whether the user is eligible for installments and finally query a financial institution to process the payment.

![](https://curity.io/images/resources/architect/api-security/token-sharing/mesh.svg)

If your system is high in the API security maturity model you most probably use access tokens to authorize access to your endpoints. Access tokens that your API receives are tailored for the use with the given endpoint - they will have a concrete set of scopes and claim values. But as shown above, your API most probably will talk to different services which may or may not be part of the same domain or even company. This means that the API will have to share the token it received with the other services it needs to access. There are different ways in which such token can be shared:

- The same token can be reused.
- A different token can be embedded in the original token.
- The original token can be exchanged.

## Reusing the same token

![](https://curity.io/images/resources/architect/api-security/token-sharing/share.svg)

The most straightforward approach is to use the same token that your API received and send it together with every request to upstream services. This approach is quite simple but it can be enough if your request does not go outside of your organisation.

It can start to be problematic though, when you want to call external services. You should consider whether it is a good approach if the request would cross domains in your service mesh. If you reuse the same token that was sent with the request then every service in the chain will get the same privileges as the receiving one. So, if you have a token which has a scope that allows it to place orders in your system for a given user, and you send that token to a geolocation service, then that service will be able to place orders in your system - and it's probably not something you would like to happen. If you use JWTs as Access Tokens you will also share all the data contained in the token, which can raise some privacy concerns. Moreover, this simple approach can fall short if any external services that you use would require concrete values of some claims, e.g. a client ID or scope which is not present in the original token.

In conclusion:

- Simplicity.
- Security and privacy issues may arise.
- Not usable with services which have special needs concerning Access Tokens.

## Embedding a token

![](https://curity.io/images/resources/architect/api-security/token-sharing/embed.svg)

In situations where you know upfront, that with most requests your API receives it will query another service that should receive a token with some narrower scope, or with different claim values, you can use the embedded token approach. In this approach your original token contains other tokens embedded inside (e.g. a whole JWT as a value of a claim in the original token). The embedded token can be easily extracted by the service and used to communicate with any upstream services.

In this approach the embedded token can have narrower scopes and any claim values required by the external service. Thanks to that the upstream service will be able to authorize the request but will not receive any excess privileges or data.

To use this approach though, you need to know which services your API rely on, as the token must be embedded at the time it is issued. The Token Service must have the information that any token for a given client with a given set of scopes must also contain an embedded token with another set of scopes and claims. This can become cumbersome if the dependency tree in your service mesh becomes complicated and you would need many levels of embedded tokens. Maintenance can also be an issue. Should the dependencies change - for example, you want to introduce a new external service which requires its own separate token - you have to change the settings of the Token Service to issue tokens in a new way. This also means that any such change would render all the issued tokens useless, which can cause some issues if your Access Tokens have long expiration times.

Embedding tokens will also cause the payload to become substantially bigger. As this shouldn't be a problem when passing tokens inside of a data center, it may become an issue when the traffic is sent via the Internet.

In conclusion:

- Greater security and privacy thanks to narrow scopes and limited claims.
- Harder maintenance, especially for complicated dependency trees.
- Larger token size.

## Exchanging a token

![](https://curity.io/images/resources/architect/api-security/token-sharing/exchange.svg)

In situations where you don't know beforehand which additional tokens will be needed to complement the original one, the Token Exchange approach can be used. This approach is also useful in situations where one token is used in many different requests, but only some of those requests require additional tokens.

To hold on to the previous e-commerce example - you could have a token with scopes which allow browsing the products and placing orders. Browsing products does not need any additional tokens, whereas placing an order with an installment payment requires a few. As browsing requests are much more common than placing orders, there is no need to keep all the additional tokens embedded, and Token Exchange can be used when the order is placed.

In the Token Exchange approach, the original token is used to exchange it for another one with the required scopes and claims. The originally called service makes a request to the Token Service, asking it for a new token with a different set of scopes and claims. If the Token Service deems the exchange possible, then it issues a new token and sends it back to the requesting service.

This approach allows to you keep your tokens secure as they can have narrow scopes and fine-grained sets of claims. What is more, they are only issued when actually needed, so the solution is especially helpful in settings where the dependencies can vary greatly between requests. You will still need to maintain a configuration in the Token Service that will contain the set of rules allowing for the exchange of tokens.

The exchange of course means that additional request is needed to the Token Service. In settings where latency is crucial this can pose some additional problems.

What is also important for this approach is that the Token Exchange is an OAuth standard, defined in the **[RFC 8693](https://www.rfc-editor.org/rfc/rfc8693).

In conclusion:

- Greater security and privacy thanks to narrow scopes and limited claims.
- Well established standard defined in RFC.
- Still maintenance required, but no need to keep track of the whole dependency tree.
- Additional request to the Token Service required.

## Conclusion

Sharing a token between different services in a mesh is not a straightforward task and different approaches can be implemented to achieve it. You should always take all the pros and cons into consideration when deciding on an approach. It is, of course, possible to implement more than one in a system. For example, there might be domains in your system between which the same token can be reused securely, but in some cases a different one will be needed, so token exchange could be used.

The **[Token Service](https://curity.io/product/token-service/)** of the Curity Identity Server is able to help you implement any of the approaches shown in this article.
