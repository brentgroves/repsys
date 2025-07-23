# **[](https://www.baeldung.com/cs/blob-storage)**

In this tutorial, we’ll discuss blob storage and its applications. More specifically, we’ll focus on the popular Microsoft Azure Blob Storage to show why blob storage is an efficient option for storing unstructured big data.

2. Why Do We Need Blob Storage?
Data represents information in the form of numbers, texts, machine codes, images, videos, audio, PDF, handwriting, etc.

Large collections of data are known as big data. Companies and organizations use their big data to make important business choices. So, we need to find an efficient way of storing them.

Structured big data have a set format, making it convenient for us to use relational databases. Semi-structured big data come with a form of structure that makes it easy for us to save it in a few specific formats.

We refer to other types of data as unstructured data. These include files like letters, PDFs, images, and videos.

2.1. The Challenge of Unstructured Big Data
Because structured and semi-structured big data are in set formats, we can easily query and store them. However, extracting and storing values from unstructured data is much more challenging.

Yet, unstructured big data are essential for companies and businesses to thrive today. No company can survive if it doesn’t employ cutting-edge methods and techniques to store, maintain and query the unstructured big data it generates daily. Unfortunately, the traditional storage options couldn’t meet this demand, so we had to develop another technology to store these unstructured big data efficiently. This new storage option is what we call blob storage.

3. Blob Storage
Blob means binary large object. It’s a collection of raw binary data. Therefore, it consists of zeros and ones.

While blobs could be structured or semi-structured data, they are often large unstructured data. Examples of blobs include media files such as audio and video files, PDFs, log files, emails, images, etc.

3.1. What’s a Blob Storage?
Blob storage is an object storage solution for unstructured data (blobs).

But why do we say blob storage is an object storage solution? That’s because it keeps blobs as objects in a flat lake-like data container known as a data lake. A data lake is a large collection of unstructured data.

Traditional storage options aren’t suited for such data. For example, file storage keeps data in a hierarchical file structure of folders, directories, subdirectories, and so on. Block storage keeps data in similarly sized volumes of data called blocks. Unfortunately, file and block storages aren’t flexible and scalable enough. By contrast, blob storage enables us to store almost unlimited data.

Blobs are housed in a cloud run by companies that provide cloud services. We sometimes refer to blob storage as Azure blob storage because Microsoft Azure is a well-known cloud service supplier of this type of storage.

4. Architecture of Blob Storage
Azure Blob Storage has three levels. Those are the user storage account, containers, and blobs:

![i1](https://www.baeldung.com/wp-content/uploads/sites/4/2023/03/blob_storage_architecture-2.png)

Each user gets their storage account and a unique Universal Resource Identifier (URI) for their storage. A storage account is capable of holding an infinite number of containers. A container is an element of storage. Containers assist in organizing blobs so that users can find them more easily.

Finally, blobs are binary data we keep in containers. They have URIs as well. Users can name individual blobs, and the names can have between one and 1,024 letters.

There are three different types of blobs: block blobs, append blobs, and page blobs:

![i1](https://www.baeldung.com/wp-content/uploads/sites/4/2023/03/blob-types.png)

## 5.1. Block Blobs

Block blobs store binary data files such as media files, documents, text files, or images. They are responsible for effectively transferring enormous amounts of data.

A block blob can contain up to 50,000 blocks, each storing up to 4000 Mebibytes. As a result, a block blob has a maximum data storage capacity of 190 Tebibytes (2^40 bytes). Each block is managed and stored individually and is identified by its ID.

5.2. Append Blobs
Append Blobs are like block blobs but optimized for append operations. An append blob is tailored for adding data to a blob in chunks without changing existing content. So, every new piece of data is appended to the end of the block. Auditing and logging are examples of append operations.

When calculating the storage capacity of an append blob, only the final block is considered. An append block can have up to 4 Mebibytes, and an append blob can have up to 50,000 blocks. As a result, an append blob is slightly greater than 195 Gibibytes in size (4 Mebibytes x 50,000 blocks).

5.3. Page Blobs
Page Blobs are useful for input/output operations. They are made of 512-byte pages and store VHD (Virtual Hard Drive) files.

They can hold around 8 Tebibytes of data.

6. Advantages and Disadvantages of Blob Storage
The blob storage has many advantages:

we use it to store and access unstructured data at scale
it is very secure
blob storage is scalable, durable, and always available
it is optimized for data lakes
we use it to build powerful cloud-native applications
it has a comprehensive data management scheme
it has inbuilt support for multiple programming languages such as Python, Java, C#, JavaScript
Blobs have disadvantages too. For example, transferring large volumes of data from one cloud platform to a different or another platform can be expensive.

Also, users in some regions may experience slower data speed because they aren’t close to their blob storage location in the cloud. For example, for users of Microsoft Azure Services, South America has one cloud region, and Africa and Canada have two. So, users not close to those locations may experience lower data speeds.

7. Major Use Cases for Blob Storage
Three major use cases for blob storage are storing media files, logs, and backups.

Image, video, and audio data take large files, so they need a lot of space. However, we don’t necessarily access them often and regularly. That’s why blob storage is one of the best options for storing media files.

When it comes to logging, software continually generates logs. These data can rapidly grow in quantity, so storing them as blobs is natural.

Also, most businesses must maintain full backups, especially for recovering from ransomware attacks. Blob storage is a good choice for backing up big data sets because these data are duplicates, and we rarely access them.

8. Conclusion
In this article, we talked about blob storage. It’s cutting-edge technology for storing large volumes of data that may be completely unstructured, such as backups, logs, and media files.

First, we showed the need for blob storage in storing unstructured data. In addition, we highlighted its advantages and some of its shortcomings. Finally, we discussed the primary use cases of blob storage in the business world.
