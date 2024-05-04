# **[Minio](https://medium.com/@martin.hodges/object-storage-in-your-kubernetes-cluster-using-minio-ad838decd9ce)**

## Access to the storage

File systems are accessed via your operating system. Depending on which operating system you are running, you will access your files in different ways. In fact, the features offered by the file system will differ for each operating system.

This means that when you are writing an application, you may have portability issues across operating systems and may have to build different versions as a result.

Object storage is accessed via a REST API call. Using POST, PUT, GET to an HTTP endpoint, you can create, read, update and delete (the famous CRUD operations) your blobs of data.

Use of REST APIs means that, regardless of the operating system you are running on, your access to your object storage is the same.

Advantages
Object Storage provides a number of advantages over a filesystem:

Storage of unstructured data in an unstructured way
Unlimited storage
^ Extremely high availability
^ High performance
Application technology independent access
Versioning
Object locking
^ These depend on the deployment architecture of your object storage.

Object storage options
Ok, if object storage is so good, why isn’t everyone using it? Well, they pretty much are. AWS S3 Buckets are probably one of the best know object storage services with almost unlimited storage, an 11 nines uptime (that is 99.999999999% uptime or a fraction of a second downtime per year on average).

Just to re-enforce that buckets are not something to be created like confetti, AWS limit the number of buckets per account but that should not matter for most applications.

Oracle, Microsoft, Google and other cloud providers also have object storage solutions.

But what if you do not want to use a public storage solution? Your Kubernetes cluster may be on premise, your data may be sensitive or you may just want to develop against an object storage system without the cost of a 3rd party supplier.

This is where MinIO comes in.
