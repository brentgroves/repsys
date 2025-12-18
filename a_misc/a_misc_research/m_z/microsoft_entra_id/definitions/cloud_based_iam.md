# Cloud IAM

## references

<https://www.techtarget.com/searchsecurity/tip/Tackle-identity-management-in-the-cloud-with-AaaS-or-IDaaS>

## Tackle identity management in the cloud with AaaS or IDaaS

Has your organization considered outsourcing cloud identity management? Learn more about the benefits of AaaS, aka IDaaS, and what to consider before settling on a particular service.

Just about every cloud application in use today requires users register or authenticate themselves as someone who is unique from other users. There are good reasons for this -- namely, because users want to be able to save work they do in an application. But this is also because HTTP is a stateless protocol, so web applications must establish a mechanism to maintain state. This mechanism keeps user sessions separate from anyone else using the application at the same time.

Identity management in the cloud has two aspects of interest to security practitioners. The first is that every application -- barring specialized outliers -- needs to manage identities in the cloud. Applications must keep track of who users are and must be able to authorize, authenticate and securely differentiate them. Secondly, identity management in the cloud matters because the consequences of not prioritizing it can be dire.

Given these two motivations, there are hundreds of authentication-related security issues that have appeared over the years. Many security experts can remember examples of these, including Dropbox, Microsoft or WordPress, to name a few. Fortunately, enterprises now have options to ease cloud identity management and security.

## AaaS and IDaaS for cloud identity management

Technological tools and services have evolved to ease identity management in the cloud. They apply the same as-a-service dynamics and properties to the challenges of managing user identity that have been applied to other aspects of the computing and application landscape -- from IaaS to SaaS. Whether it's called identity as a service (IDaaS) or authentication as a service (AaaS), the idea is the same: A service provider -- external to the application being deployed -- takes on the burden of authenticating and registering users, as well as managing their information. To facilitate identity management in the cloud, these services use well-documented and analyzed standards, such as Security Assertion Markup Language (SAML) or Open Authorization (OAuth). This enables applications to leave the implementation mechanics to the provider rather than writing them themselves.

SAML is an **[OASIS](https://www.oasis-open.org/org/)** standard that enables the creation of a security assertion, which is essentially an XML data structure that contains information about user authentication state. Historically, SAML was used to enable applications such as single sign-on (SSO). SAML enables one party to assert to another party -- for example, a service provider -- that a principal, usually the user, has been authenticated. The service provider can parse the assertion and be confident the user has been authenticated somewhere else so there is no need to do it again.

OAuth is an open standard maintained by the Internet Engineering Task Force. It enables authorization data exchange, usually over REST APIs. OAuth creates access tokens by one party that can be interpreted by another, usually using HTTP Secure as the data exchange channel. This enables the exchange of authentication state information between two stateless components.

## Benefits of outsourcing identity management in the cloud

Delegating the minutiae of account management and authentication to a service provider means a company no longer needs to keep track of these in its applications. The security advantage is it frees organizations from the responsibility that comes with keeping track of passwords, which can get compromised. Organizations can also more easily enable multifactor authentication and enjoy the peace of mind that comes with knowing identities will be well analyzed in the hands of specialists.

## Cloud identity management implementation considerations

The advantages of outsourcing cloud identity management via AaaS or IDaaS can be compelling to both security practitioners and developers. Then, the question goes from if to how. There are a few factors to consider when evaluating AaaS or IDaaS approaches.

It is critical to keep in mind the context in which AaaS or IDaaS will be used. Business leaders should identify if they need, or will need in the future, to integrate with legacy applications; existing user accounts, such as an Active Directory (AD); or SSO systems. While this advice may seem like common sense, many organizations do not account for these specialized use cases out of the gate, putting them in a position where they must piece together multiple products or, worse, purchase multiple redundant products that have the same function. With outsourced identity management, if an organization needs to integrate with non-REST applications -- such as native desktop applications or middleware -- the access to a wide array of integration options, including SAML, OAuth or OpenID Connect, can be advantageous.

Next, consider the logistics of cloud or on-premises implementation -- or both. For example, if an enterprise needs to integrate with an external-facing web app for internet resident users, there are advantages to cloud implementation since on-premises infrastructure will not be a single point of failure. That said, if there is an existing, on-premises user store or directory, understand the need for some external applications -- those not hosted in the company's infrastructure -- to gain access for the implementation to function.

Lastly, organizations must look for capability to support the authentication types desired and the existing user account directories that will be in scope. For example, it may be best to situationally add secondary or even tertiary authentication factors, such as tokens or biometrics, based on context and usage. Think through where the account information to be incorporated lives currently, and consider the hypothetical challenges of that integration. For example, a standard approach like AD is significantly easier to integrate with, as opposed to a custom-developed user database for an existing application.

As always, do the requirements gathering, architectural planning and integration-related due diligence prior to engaging vendors. This can save organizations invaluable time and energy in the long run.
