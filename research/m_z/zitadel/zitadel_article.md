# **[Zitadel](https://duckster.medium.com/breaking-down-complex-authorization-beyond-login-with-zitadel-0c1f6347cb90)**

## references

**[Code](../../../../example-fine-grained-authorization/README.md)**

ZITADEL is an open source, cloud-native Identity and Access Management solution (IAM) that provides various security mechanisms to secure applications and services. It uses a range of different authorization strategies, including Role-Based Access Control (RBAC) and Delegated Access.

![](https://miro.medium.com/v2/resize:fit:720/format:webp/0*neL7L1iYFPpu7C0d)

## References

<https://duckster.medium.com/breaking-down-complex-authorization-beyond-login-with-zitadel-0c1f6347cb90>

<https://github.com/zitadel/zitadel/tree/main>

<https://zitadel.com/pricing/detail>

<https://zitadel.com/docs/guides/start/quickstart>

## Article

As we move towards a zero-trust mindset, the limitation of coarse-grained security measures like the traditional RBAC system become clear. An essential part of the shift to zero trust that often goes undiscussed is the move from coarse-grained to fine-grained security. Fine-grained authorization addresses this by basing access on attributes like user roles, actions, and even context like time or location, and such detailed access control is vital for contemporary applications.

This article discusses how ZITADEL caters to the need for such nuanced authorization. With ZITADEL’s features like roles, meta-data, and actions, users can obtain highly detailed access control suited for a zero-trust setting. Additionally, ZITADEL can work with external authorization services.

## Authorization Mechanisms Offered by ZITADEL

![](https://miro.medium.com/v2/resize:fit:720/format:webp/0*-dtOIUsOzxhmjSxo.jpg)

ZITADEL is an open source, cloud-native Identity and Access Management solution (IAM) that provides various security mechanisms to secure applications and services. It uses a range of different authorization strategies, including Role-Based Access Control (RBAC) and Delegated Access.

## Role-Based Access Control (RBAC) and Delegated Access

ZITADEL uses RBAC to manage user permissions, where permissions are tied to roles and users are allocated these roles. This simplifies user access management based on their organizational roles. An additional feature allows roles to be delegated to other organizations, facilitating permissions sharing with external entities. This is especially valuable for interconnected or hierarchical organizations. While these capabilities offer robust access control, they might not be enough for intricate authorization needs, hence the importance of exploring fine-grained authorization in ZITADEL.

## The Actions Feature, Custom Metadata, and Claims for Attribute-based Access Control (ABAC)

ZITADEL enhances the traditional RBAC by introducing its dynamic Actions feature for attribute-based access control (ABAC). Unlike RBAC, which grants access based on user roles, ABAC is more versatile, assessing attributes linked to the user, action, and resource during access requests. With ZITADEL’s Actions, post-authentication scripts can be created to analyze specific user attributes and block access when necessary.

Actions can also establish custom claims to boost the ABAC system, enabling advanced authorization models that restrict access based on attributes like location, time, or any definable factor. ZITADEL lets administrators or permitted developers add custom metadata to users and organizations, amplifying fine-grained access control possibilities. It supports aggregated claims by gathering extra data from external systems like CRM or HR tools. ZITADEL can also manage unique resources, such as shipping orders or IoT devices, and determine access based on attributes like User-Sub, Roles, Claims, IP, and more.

Customer relationship management,CRM, is a process in which a business or other organization administers its interactions with customers, typically using data analysis to study large amounts of information.

Extending ZITADEL’s Existing Capabilities for Fine-Grained Access Control
Despite the comprehensive features that come with ZITADEL, there may be instances where a more customized or fine-grained approach is needed. Currently, the most effective way to implement fine-grained authorization in ZITADEL is by using custom application logic for smaller projects, or for larger scale projects, leveraging an available third-party tool such as warrant.dev, cerbos.dev, etc. These tools can integrate with ZITADEL, further enhancing your capacity for nuanced, fine-grained authorization.

Warrant is an application authorization & access control platform built for developers and product teams. It's designed to abstract away the complexity of implementing and managing authorization & access control so teams can focus on building their core products.

Teams use Warrant to implement application authorization & access control models like role based access control (RBAC), relationship based access control (ReBAC), attribute based access control (ABAC) and other custom access models in their apps.

Cerbos helps you super-charge your authorization implementation by writing context-aware access control policies for your application resources. Author access rules using an intuitive YAML configuration language, use your Git-ops infrastructure to test and deploy them and, make simple API requests to the Cerbos PDP to evaluate the policies and make dynamic access decisions.

## A Practical Example

Let’s say there’s a hypothetical Newsroom Application in a media company, which talks to a back-end API. Journalists use it to write, while editors edit and publish these articles. This API, written in Python Flask in this example, has specific endpoints and access to these endpoints depends on the user’s role and how experienced they are.

The endpoints:

- write_article: Only for journalists to write.

- edit_article: Just for editors to edit articles.

- review_articles: For senior journalists, and intermediate and senior editors to review articles.

- publish_article: For intermediate and senior journalists, and senior editors to publish.

Internally, the API uses a JWT issued by ZITADEL for checking who’s making requests. Users need to send a valid JWT in their request’s header. This JWT was obtained when the user logged in. The JWT contains info about the user, like their role and experience. This info, contained within custom claims, is key to this use case. The backend decides if the user can access the requested resource based on this information.

The Application Logic

![](https://miro.medium.com/v2/resize:fit:720/format:webp/0*neL7L1iYFPpu7C0d)

# JSON Web Key Sets

The JSON Web Key Set (JWKS) is a set of keys containing the public keys used to verify any JSON Web Token (JWT) issued by the Authorization Server and signed using the RS256 signing algorithm.

When creating applications and APIs in Auth0, two algorithms are supported for signing JWTs: RS256 and HS256. RS256 generates an asymmetric signature, which means a private key must be used to sign the JWT and a different public key must be used to verify the signature.

**User Onboarding:** During the user onboarding process, each user gets a role, e.g. journalist or editor. This is key since it sets who gets what access in our setup.

**Managing Experience/Seniority:** Besides roles, a user’s experience (like junior, intermediate, and senior in our example) is tracked. If a user’s experience changes, ZITADEL updates it as metadata. If there’s no experience level mentioned when a user onboards ZITADEL, the system just assumes it’s junior.

**User Login:** A user must first login to access the API. Upon successful login, ZITADEL returns a token with the user’s information.

**Token Validation:** When a request from a user hits the API, the API validates the token by calling ZITADEL’s token introspection endpoint. Although JWTs can be validated locally using JWKS, we went with ZITADEL’s method to inspect tokens for better security and instant token checks. This way, we can revoke tokens instantly, manage them from one place, and have fewer security issues. It keeps our API’s login and access controls strong and up-to-date with the server.

**Fine-Grained Access Control:** The application is responsible for authorizing access to resources based on a user’s role and experience level. It uses a predefined access control list that maps each resource endpoint to the user roles and experience levels authorized to access them. This list serves as the rulebook for granting or denying access to resources.

**Separation of Concerns:** In the design of this API, special attention was given to ensuring that business logic and access control rules are cleanly separated. This is crucial for the maintainability and scalability of the application. By keeping business logic and access rules separate, we get a cleaner, modular design. This lets us update business actions and access rules without affecting each other. This increases the maintainability of the code and makes it easier to manage as the application scales. Additionally, this design makes the system more secure as access rules are abstracted away from the main business logic, reducing the risk of accidentally introducing security vulnerabilities when modifying the business logic.

## Try out the Code: Configure ZITADEL and Create the API

- First set up ZITADEL for this use case as explained in the **[Set up ZITADEL section](https://github.com/zitadel/example-fine-grained-authorization#1)**.
- Next, set up the API as explained in the **[Set up the API Project section](https://github.com/zitadel/example-fine-grained-authorization#2)**.
- Finally, test the API as explained in the **[Run and Test the API section.](https://github.com/zitadel/example-fine-grained-authorization#3)**
You can find all source files and instructions here.

## Integrate with an External Authorization Service

ZITADEL allows integration with external authorization services such as warrant.dev, cerbos.dev, or essentially any service that can consume ZITADEL’s users and roles. By using an external authorization service, you have the flexibility to create a fine-tuned authorization strategy that precisely meets your organization’s needs. This could involve creating complex policies that dictate access based on a variety of user attributes and conditions, extending far beyond the traditional roles used in RBAC.

Instead of enforcing a one-size-fits-all solution, ZITADEL believes in giving users the tools and options to construct an access control framework that perfectly suits their organization’s unique needs and challenges. This emphasis on flexibility ensures that as those needs evolve, the access control strategy can adapt seamlessly.

## Set up ZITADEL

1/ Create Media House Organization (Repsys instead), Newsroom Project and Article API
Create the Media House organization and go to Projects and create a new project called Newsroom.

1. Create the Media House organization (Repsys instead) and go to Projects and create a new project called Newsroom.

![](https://github.com/zitadel/example-fine-grained-authorization/raw/main/screenshots/1%20-%20New%20Org.png)

2. In the Newsroom project, click the New button to create a new application.

![](https://github.com/zitadel/example-fine-grained-authorization/raw/main/screenshots/2%20-%20New%20Project.png)

3. Add a name and select type API.

Article API

![](https://github.com/zitadel/example-fine-grained-authorization/raw/main/screenshots/3%20-%20New%20API.png)

4. Select Basic as the authentication method and click Continue.

![](https://github.com/zitadel/example-fine-grained-authorization/raw/main/screenshots/4%20-%20New%20API.png)

5. Now review your configuration and click Create.

![](https://github.com/zitadel/example-fine-grained-authorization/raw/main/screenshots/5%20-%20New%20API.png)

6. You will now see the API’s Client ID and the Client Secret. Copy them and save them. Click Close.

![](https://github.com/zitadel/example-fine-grained-authorization/raw/main/screenshots/7%20-%20API%20Client%20ID%20and%20Secret.png)

**[Article API Secret](../../../../secrets/zitadel.md)**

7. When you click URLs on the left, you will see the relevant OIDC URLs. Note down the issuer URL, token_endpoint and introspection_endpoint.

```json
  "issuer": "https://repsys-dev-4panhw.zitadel.cloud",
  "authorization_endpoint": "https://repsys-dev-4panhw.zitadel.cloud/oauth/v2/authorize",
  "token_endpoint": "https://repsys-dev-4panhw.zitadel.cloud/oauth/v2/token",
  "introspection_endpoint": "https://repsys-dev-4panhw.zitadel.cloud/oauth/v2/introspect",
  "userinfo_endpoint": "https://repsys-dev-4panhw.zitadel.cloud/oidc/v1/userinfo",
  "revocation_endpoint": "https://repsys-dev-4panhw.zitadel.cloud/oauth/v2/revoke",
  "end_session_endpoint": "https://repsys-dev-4panhw.zitadel.cloud/oidc/v1/end_session",
  "device_authorization_endpoint": "https://repsys-dev-4panhw.zitadel.cloud/oauth/v2/device_authorization",
  "jwks_uri": "https://repsys-dev-4panhw.zitadel.cloud/oauth/v2/keys",
```

## 2/ Create Roles in the Newsroom Project

1. Also note down the Resource ID of your project (go to the project and copy the Resource ID)

![](https://github.com/zitadel/example-fine-grained-authorization/raw/main/screenshots/9%20-%20Create%20Roles.png)

Resource Id: 268002042629380594

2. Select the Assert Roles on Authentication checkbox on the project dashboard and click Save.

![](https://github.com/zitadel/example-fine-grained-authorization/raw/main/screenshots/2.1%20-%20Tick%20the%20box.png)

3. Go to Roles (from the left menu) and click New to add new roles.

![](https://github.com/zitadel/example-fine-grained-authorization/blob/main/screenshots/10%20-%20Create%20Roles.png)

4. Enter the roles editor and journalist as shown below and click Save.

![](https://github.com/zitadel/example-fine-grained-authorization/raw/main/screenshots/11%20-%20Create%20Roles.png)

5. You will now see the created roles.

![](https://github.com/zitadel/example-fine-grained-authorization/raw/main/screenshots/12%20-%20Create%20Roles.png)

3/ Create Users in the Newsroom Project

1. Go to the Users tab in your organization as shown below and go to the Service Users tab. We will be creating service users in this demo. To add a service user, click the New button.

![](https://github.com/zitadel/example-fine-grained-authorization/raw/main/screenshots/14%20-%20Create%20Service%20User.png)

2. Next, add the details of the service user and select JWT for Access Token Type and click Create.

![](https://github.com/zitadel/example-fine-grained-authorization/raw/main/screenshots/15%20-%20Create%20Service%20User%201.png)

3. Click the Actions button on the top right corner. Select Generate Client Secret from the drop-down menu.

![](https://github.com/zitadel/example-fine-grained-authorization/raw/main/screenshots/16%20-%20Create%20Service%20User%20and%20Generate%20CC.png)

**[service user](../../../../secrets/zitadel.md)**

4. Copy your Client ID and Client Secret. Click Close.

![](https://github.com/zitadel/example-fine-grained-authorization/raw/main/screenshots/17%20-%20Service%20user%20CC.png)

5. Now you have a service user, along with their client credentials.

4/ Add Authorizations for the Users

1. Go to Authorizations. Click New.

![](https://github.com/zitadel/example-fine-grained-authorization/raw/main/screenshots/19%20-%20Service%20user%20authorizations.png)

2. Select the user and the project for which the authorization must be created. Click Continue.

![](https://github.com/zitadel/example-fine-grained-authorization/raw/main/screenshots/20%20-%20SU%20auhorization.png)

3. You can select a role here. Select the role journalist for the current user. Click Save.

![](https://github.com/zitadel/example-fine-grained-authorization/raw/main/screenshots/21%20-%20SU%20authorization%20.png)

4. You can see the service user Lois Lane now has the role journalist in the Newsroom project.

![](https://github.com/zitadel/example-fine-grained-authorization/raw/main/screenshots/22%20-%20SU%20authorization.png)

5/ Add Metadata to the Users
Now, let's add metadata to the user profile to indicate their level of seniority. Use 'experience_level' as the key, and for its value, choose from 'junior', 'intermediate', or 'senior'. Although we can typically assume this metadata is set through an API call made by the HR application, for simplicity and ease of understanding, we will set the metadata directly in the console.

1. Go to Metadata. Click Edit.

![](https://github.com/zitadel/example-fine-grained-authorization/raw/main/screenshots/23%20-%20SU%20metadata.png)

2. Provide experience_level as the key and senior as the value. Click the save icon and click the Close button.

![](https://github.com/zitadel/example-fine-grained-authorization/raw/main/screenshots/24%20-%20SU%20metadata.png)

3. The user now has the required metadata associated with their account.

![](https://github.com/zitadel/example-fine-grained-authorization/raw/main/screenshots/25%20-%20SU%20metadata.png)

You can also add a few more service users with different roles and experience_levels (using metadata) to test the demo using the previous steps.

![](https://github.com/zitadel/example-fine-grained-authorization/raw/main/screenshots/26%20-%20Users%20and%20roles%20list.png)

6/ Create an Action to Capture Role and Metadata in Custom Claim

1. Click on Actions. Click New to create a new action.

![](https://github.com/zitadel/example-fine-grained-authorization/raw/main/screenshots/27%20-%20Action.png)

2. In the Create an Action section, give the action the same name as the function name, i.e., assignRoleAndExperienceClaims. In the script field, copy/paste the code in **[assignRoleAndExperienceClaims.js](https://github.com/zitadel/example-fine-grained-authorization/blob/main/zitadel_actions/assignRoleAndExperienceClaims.js). Click Add.

![](https://github.com/zitadel/example-fine-grained-authorization/raw/main/screenshots/28%20-%20Action.png)

3. The assignRoleAndExperienceClaims will now be listed as an action.

![](https://github.com/zitadel/example-fine-grained-authorization/raw/main/screenshots/29%20-%20Action.png)

4. Next, we must select a Flow Type. Go to the Flows section below. Select Complement Token from the dropdown.

![](https://github.com/zitadel/example-fine-grained-authorization/raw/main/screenshots/30%20-%20Action.png)

5. Now, you must choose a trigger. Click Add trigger. Select Pre access token creation as the trigger type and select assignRoleAndExperienceClaims as the associated action.

![](https://github.com/zitadel/example-fine-grained-authorization/raw/main/screenshots/31%20-%20Action.png)

6. And now you will see the trigger listed.

![](https://github.com/zitadel/example-fine-grained-authorization/raw/main/screenshots/32%20-%20Action.png)

Now, when a user requests an access token, the action will be executed, transforming the user roles and metadata into the required format and adding them as a custom claim to the token. This custom claim can then be used by third-party applications to manage fine-grained user access.

2. Set up the API Project
Clone the Project from GitHub:

Run the command below to clone the project from this GitHub repository:

```bash
pushd .
cd src 
git clone git@github.com:brentgroves/example-fine-grained-authorization.git
cd example-fine-grained-authorization.
```

Setup a Python Environment:

Ensure you have Python 3 and pip installed. You can check this by running

```bash
conda deactivate
python3 --version and
pip3 --version
```

in your terminal. If you don't have Python or pip installed, you will need to install them.

Next, create a new virtual environment for this project by running

```bash
cd ~/src/example-fine-grained-authorization.

python3 -m venv env .
Activate the environment by running:
source env/bin/activate
```

After running this command, your terminal should indicate that you are now working inside the env virtual environment.

Install Dependencies:

With the terminal at the project directory (the one containing requirements.txt), run

```bash
pip3 install -r requirements.txt
Installing collected packages: urllib3, python-dotenv, PyJWT, pycparser, MarkupSafe, itsdangerous, idna, click, charset-normalizer, certifi, Werkzeug, requests, Jinja2, cffi, Flask, cryptography, Authlib
Successfully installed Authlib-1.2.0 Flask-2.2.2 Jinja2-3.1.4 MarkupSafe-2.1.5 PyJWT-2.7.0 Werkzeug-3.0.3 certifi-2024.2.2 cffi-1.16.0 charset-normalizer-3.3.2 click-8.1.7 cryptography-42.0.7 idna-3.7 itsdangerous-2.2.0 pycparser-2.22 python-dotenv-0.21.0 requests-2.28.2 urllib3-1.26.18
```

**[Code](../../../../example-fine-grained-authorization/README.md)**

to install the necessary dependencies.

Configure Environment Variables:

The project requires certain environment variables. Fill in the .env file with the values we retrieved from ZITADEL.

Run the Application:

The Flask API (in **[app.py](https://github.com/zitadel/example-fine-grained-authorization/blob/main/app.py)**) uses JWT tokens and custom claims for fine-grained access control. It checks the custom claim experience_level for the roles journalist and editor on every request, using this information to decide if the authenticated user can access the requested endpoint. Run the Flask application by executing:

```bash
cd ~/src/example-fine-grained-authorization
python3 app.py

Traceback (most recent call last):
  File "/home/brent/src/example-fine-grained-authorization/app.py", line 1, in <module>
    from flask import Flask, jsonify
  File "/home/brent/src/example-fine-grained-authorization/env/lib/python3.10/site-packages/flask/__init__.py", line 5, in <module>
    from .app import Flask as Flask
  File "/home/brent/src/example-fine-grained-authorization/env/lib/python3.10/site-packages/flask/app.py", line 30, in <module>
    from werkzeug.urls import url_quote
ImportError: cannot import name 'url_quote' from 'werkzeug.urls' (/home/brent/src/example-fine-grained-authorization/env/lib/python3.10/site-packages/werkzeug/urls.py)
```
