# **[Hadoop - HDFS (Hadoop Distributed File System)

](<https://www.geeksforgeeks.org/data-engineering/hadoop-hdfs-hadoop-distributed-file-system/>)**

Last Updated : 12 Aug, 2025

Before learning about HDFS (Hadoop Distributed File System), it’s important to understand what a file system is. A file system is a way an operating system organizes and manages files on disk storage. It helps users store, maintain, and retrieve data from the disk.

Example: Windows uses file systems like NTFS (New Technology File System) and FAT32 (File Allocation Table 32). FAT32 is an older file system but is still supported on versions like Windows XP. Similarly, Linux uses file systems such as ext3 and ext4.

## Distributed File System

DFS stands for distributed file system, it is a concept of storing file in multiple nodes in a distributed manner. DFS actually provides Abstraction for a single large system whose storage is equal to the sum of storage of other nodes in a cluster.

## Why We Need DFS?

Storing very large files (e.g., 30TB) on a single system is impractical because:

- Disk capacity of one machine is limited and can only grow so much.
- Processing huge datasets on a single machine is inefficient and slow.

Distributed File Systems (DFS) overcome these issues by storing data across multiple machines, enabling faster and scalable processing.

## Example

Suppose you have a 40TB file to process. On a single machine, it might take about 4 hours to complete. However, using a Distributed File System (DFS), as shown in the image below, 40TB file is split across 4 nodes in a cluster, with each node storing 10TB. Since all nodes work simultaneously, processing time reduces to just 1 hour. This demonstrates why DFS is essential for faster and efficient big data processing.

Local File System Processing:

![i](https://media.geeksforgeeks.org/wp-content/cdn-uploads/20200728155818/Local-File-System-Processing.png)

Distributed File System Processing:

![i](https://media.geeksforgeeks.org/wp-content/cdn-uploads/20200728155848/Distributed-File-System-Processing.png)

Now we think you become familiar with the term file system so let's begin with HDFS.

## HDFS

HDFS (Hadoop Distributed File System) is the main storage system in Hadoop. It stores large files by breaking them into blocks (default 128 MB) and distributing them across multiple low-cost machines.

HDFS ensures fault-tolerance by keeping copies of data blocks on different machines. This makes it reliable, scalable and ideal for handling big data efficiently.

## Features of HDFS

- It's easy to access the files stored in HDFS.
HDFS also provides high availability and fault tolerance.
- Provides scalability to scaleup or scaledown nodes as per our requirement.
- Data is stored in distributed manner i.e. various Datanodes are responsible for storing the data.
- HDFS provides Replication because of which no fear of Data Loss.
- HDFS Provides High Reliability as it can store data in a large range of Petabytes.
- HDFS has in-built servers in Name node and Data Node that helps them to easily retrieve the cluster information.
- Provides high throughput.

## Storage Daemons in HDFS

Hadoop follows a master-slave architecture using the MapReduce algorithm. Similarly, HDFS has two main components that follow this structure:
