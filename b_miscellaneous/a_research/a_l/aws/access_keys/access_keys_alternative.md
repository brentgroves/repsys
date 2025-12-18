# **[Alternatives to long-term access keys](https://docs.aws.amazon.com/IAM/latest/UserGuide/security-creds-programmatic-access.html#security-creds-alternatives-to-long-term-access-keys)**

For many common use cases, there are alternatives to long-term access keys. To improve your account security, consider the following.

Don't embed long-term access keys and secret access keys in your application code or in a code repository – Instead, use AWS Secrets Manager, or other secrets management solution, so you don't have to hardcode keys in plaintext. The application or client can then retrieve secrets when needed. For more information, see What is AWS Secrets Manager? in the AWS **[Secrets Manager User Guide](https://docs.aws.amazon.com/secretsmanager/latest/userguide/intro.html)**.
