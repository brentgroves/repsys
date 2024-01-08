# Gateway API use cases

Gateway API covers a very wide range of use cases (which is both a strength and a weakness!). This page is emphatically not meant to be an exhaustive list of these use cases: rather, it is meant to provide some examples that can be helpful to demonstrate how the API can be used.

In all cases, it's very important to bear in mind the **[roles and personas](https://gateway-api.sigs.k8s.io/concepts/roles-and-personas)** used in Gateway API. The use cases presented here are deliberately described in terms of Ana, Chihiro, and Ian: they are the ones for whom the API must be usable. (It's also important to remember that even though these roles might be filled by the same person, especially in smaller organizations, they all have distinct concerns that we need to consider separately.)

## refererences

<https://gateway-api.sigs.k8s.io/concepts/use-cases/>

## Use Cases

The example **[use cases](https://gateway-api.sigs.k8s.io/concepts/use-cases)** show this role-oriented model at work. Its flexibility allows the API to adapt to vastly different organizational models and implementations while remaining a portable and standard API.

The use cases presented are deliberately cast in terms of the roles presented above. Ultimately Gateway API is meant for use by humans, which means that it must fit the uses to which each of Ana, Chihiro, and Ian will put it.

## The Use Cases

Basic north/south use case
Multiple applications behind a single Gateway
Basic east/west use case -- experimental
Gateway and mesh use case -- experimental
