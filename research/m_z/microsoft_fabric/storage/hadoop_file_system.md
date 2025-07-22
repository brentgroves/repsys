# **[](<https://aws.amazon.com/what-is/hadoop/#:~:text=Hadoop%20Distributed%20File%20System%20(HDFS,to%20connect%20to%20the%20NameNode>.)**

Hadoop is an open-source software framework designed for storing and processing large datasets using a distributed computing model. It's built to handle massive amounts of data across clusters of commodity hardware, enabling parallel processing and efficient data management.
Here's a more detailed breakdown:
Key Features and Components:
Distributed Storage:
Hadoop uses the Hadoop Distributed File System (HDFS), which stores data across multiple nodes in a cluster, providing high fault tolerance and supporting large datasets.
Parallel Processing:
MapReduce, a programming model within Hadoop, enables parallel processing of data across the cluster. It divides tasks into smaller, manageable parts that can be executed concurrently on different nodes.
Resource Management:
Yet Another Resource Negotiator (YARN) manages and allocates resources within the Hadoop cluster, scheduling jobs and optimizing resource utilization.
Cost-Effective:
Hadoop leverages commodity hardware, making it a cost-effective solution for big data storage and processing compared to traditional systems.
How it works:
Data Input: Applications send data to the Hadoop cluster, where it's stored in HDFS.
Task Decomposition: MapReduce breaks down the processing tasks into smaller map and reduce operations.
Parallel Execution: These tasks are executed concurrently on the nodes where the data resides.
Result Aggregation: The results from the map and reduce tasks are combined to produce the final output.
In Essence: Hadoop provides a scalable and efficient way to handle vast amounts of data by distributing storage and processing across a network of computers.
