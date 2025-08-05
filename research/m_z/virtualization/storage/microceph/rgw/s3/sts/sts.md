# **[](https://docs.ceph.com/en/quincy/radosgw/STS/)**

## **[ceph sts lite](https://docs.ceph.com/en/reef/radosgw/STSLite/)**

Secure Token Service is a web service in AWS that returns a set of temporary security credentials for authenticating federated users. The link to official AWS documentation can be found here: <https://docs.aws.amazon.com/STS/latest/APIReference/Welcome.html>.

Ceph Object Gateway implements a subset of STS APIs that provide temporary credentials for identity and access management. These temporary credentials can be used to make subsequent S3 calls which will be authenticated by the STS engine in Ceph Object Gateway. Permissions of the temporary credentials can be further restricted via an IAM policy passed as a parameter to the STS APIs.
