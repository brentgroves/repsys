# **[AWS Signature Version 4 for API requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_sigv.html)**

## Important

If you use an AWS SDK (see **[Sample Code and Libraries](https://aws.amazon.com/developer/)**) or AWS Command Line Interface (AWS CLI) tool to send API requests to AWS, you can skip the signature process, as the SDK and CLI clients authenticate your requests by using the access keys that you provide. Unless you have a good reason not to, we recommend that you always use an SDK or the CLI.

In Regions that support multiple signature versions, manually signing requests means you must specify which signature version to use. When you supply requests to Multi-Region Access Points, SDKs and the CLI automatically switch to using Signature Version 4A without additional configuration.

Authentication information that you send in a request must include a signature. AWS Signature Version 4 (SigV4) is the AWS signing protocol for adding authentication information to AWS API requests.

You don't use your secret access key to sign API requests. Instead, you use the SigV4 signing process. Signing requests involves:

1. Creating a canonical request based on the request details.
2. Calculating a signature using your AWS credentials.
3. Adding this signature to the request as an Authorization header.

AWS then replicates this process and verifies the signature, granting or denying access accordingly.

Symmetric SigV4 requires you to derive a key that is scoped to a single AWS service, in a single AWS region, on a particular day. This makes the key and calculated signature different for each region, meaning you must know the region the signature is destined for.

Asymmetric Signature Version 4 (SigV4a) is an extension that supports signing with a new algorithm, and generating individual signatures that are verifiable in more than one AWS region. With SigV4a, you can sign a request for multiple regions, with seamless routing and failover between regions. When you use the AWS SDK or AWS CLI to invoke functionality that requires multi-region signing, the signature type is automatically changed to use SigV4a. For details, see How AWS SigV4a works.

## How AWS SigV4 works

The following steps describe the general process of computing a signature with SigV4:

The string to sign depends on the request type. For example, when you use the HTTP Authorization header or the query parameters for authentication, you use a combination of request elements to create the string to sign. For an HTTP POST request, the POST policy in the request is the string you sign.

The signing key is a series of calculations, with the result of each step fed into the next. The final step is the signing key.

When an AWS service receives an authenticated request, it recreates the signature using the authentication information contained in the request. If the signatures match, the service processes the request. Otherwise, it rejects the request.

For more information, see **[Elements of an AWS API request signature](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_sigv-signing-elements.html)**.
