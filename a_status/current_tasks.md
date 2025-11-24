# Current Tasks

Team:

Christian. Trujillo, IT Structures Manager
Brent Hall, System Administrator Senior
Kevin Young, Information Systems Manager
Jared Davis, IT Manager
Hayley Rymer, IT Supervisor, Mills River
Mitch Harper, Desktop and Systems Support Technician, Mills River
Thomas.Creal, Desktop and Systems Support Technician, Mills River
Matthew Bump, Muscle Shoals, Engineering Supervisor II / IT
Carlos Morales, IT Administrator, Muscle Shoals
Sam Jackson, Information Systems Developer, Southfield
Matt Irey, Desktop and System Support Technician, Fruitport
David Maitner,  Desktop and System Support Technician, Fruitport
Carl Stangland, Desktop and System Support Technician, Indiana
Lucas Tuma, IT Administrator, Strakonice
Aleksandar Gavrilov, IT Administrator, Skopje

- **[jupyter lab](https://jupyter.org/try-jupyter/lab/)**

- **[web assembly tutorial](https://marcoselvatici.github.io/WASM_tutorial/)**

- **[charmed k8s install](../k8s/charmed_k8s/charmed_k8s.md)**

- **[Graph Theory](../research/a_l/computer_science/data_structures/graph_theory/geeksforgeeks/depth_first_search.md)**

- - **[Process Capability Analysis Cp, Cpk, Pp, Ppk - A Guide](https://www.1factory.com/quality-academy/guide-process-capability.html)**

## **[eBPF Documentation](https://ebpf.io/what-is-ebpf/)**

eBPF is a revolutionary technology with origins in the Linux kernel that can run sandboxed programs in a privileged context such as the operating system kernel. It is used to safely and efficiently extend the capabilities of the kernel without requiring to change kernel source code or load kernel modules.

### Service Mesh Features, Without the Sidecars

When people talk about a service mesh like Istio or Linkerd, they usually mean:

- mTLS for encrypting service-to-service traffic
- Traffic routing for canary or blue-green deployments
- Detailed observability of service calls

Traditionally, this requires sidecars (tiny proxies in every pod), which add complexity and overhead. Cilium does it differently. Using eBPF in the kernel, it delivers:

- Built-in mTLS
- L7-aware traffic routing (e.g., “send 20% of /checkout to v2”).
- Hubble-powered observability.

## Multi-Cluster Networking with ClusterMesh

One of **Cilium’s** most powerful features is how easily it connects multiple clusters, as if they were one.

Want your homelab to talk to your cloud Kubernetes cluster? No VPNs. No DNS hacks. Just seamless pod-to-pod communication.

## Fabric/Power BI/Notebooks/Data Lake Medallion Workflow

- make config request for data gateway
<https://www.youtube.com/watch?v=dz4bM_NzQQg>
- finished Bronze Layer and starting Silver Layer of Medallion Workflow
- receiving approval Fabric approval requests from Structures employees
- fabric gateway
  - **[lxd forwarder](../research/m_z/virtualization/hypervisor/lxd/network/forwarders/forwarders.md)** to wins22
  - connect to Plex from wins22
  - **[Integrating On-Premises Data into Microsoft Fabric Using Data Pipelines in Data Factory](../research/m_z/microsoft_fabric/data_gateway/data_gateway.md)**
  - create chat or email group to keep team informed
  - Southfield, Cody Hudson, and other Plex reports.

## Marposs gage project

- Marposs coming down soon to help
- Serial device server configured
- JT Front VLAN created
- Switch ports for JT Front VLAN configured
- 1 Network Cable ran probably need 2
- Data import to Minitab for CPK and PPK.
  - Instead of Minitab we can use a Fabric Notebook.
  - **[Process Capability Analysis Cp, Cpk, Pp, Ppk - A Guide](https://www.1factory.com/quality-academy/guide-process-capability.html)**

## Corporate IT Data Team

I wanted to share an update on the recent issue we encountered in Fabric related to latency during Lakehouse-to-SQL Endpoint synchronization, along with the steps we’ve taken so far.

## Marposs gage project

- Marposs coming down soon to help
- Serial device server configured
- JT Front VLAN created
- Switch ports for JT Front VLAN configured
- 1 Cable ran probably need 2
- Data import to minitab for CPK and PPK
Basically, what I need from you is a way to capture the data and and put it in a run chart.  
It would be great if the data and chart could show 30 day CPK and 90 day PPK.

- **[Process Capability Analysis Cp, Cpk, Pp, Ppk - A Guide](https://www.1factory.com/quality-academy/guide-process-capability.html)**

Hi Ron,
I know you have minitab but we could probably add the data from the gage to our Structures datalake, make these calcs in python, and present it in a Power BI report. Here's how **[A Comprehensive Guide to Performing Capability Analysis in Python](https://medium.com/@chenchungwai/a-comprehensive-guide-to-performing-capability-analysis-in-python-e46ac74a69b5)**

Thanks
Brent

### moxa serial device server

- db9 serial cable from gauge to moxa
- POE network cable to cell
- udp
  - udp mode broadcasts to multiple ips
  - no connections/faster/less error prone
- tcp
  - tcp mode allows multiple connections upto 8
  - connections made/slower/more error prone
- KepServerEx - OPC UA data points
  - create udp/tcp connection to moxa serial device server for trouble shooting
  - OPC UA ensures secure data exchange through encryption and certificate-based authentication, protecting the data as it travels from KEPServerEX to the client.
- Mach2
  - could connect to KepServerEx OCP UA data point or directly to Moxa Serial device server via a socket.
- Python
  - use for testing
  - could also install on gauge and send records of file through serial port with pyserial.

the ip address will be 10.188.74.11 but we must wait for corporate to setup vlan and Jared to configure edge switch

- get docs for gauge.

- <https://stackoverflow.com/questions/26803825/python-read-serial-rs-232-data-over-tcp-ip>

<https://github.com/mdavidsaver/nport-toys>

- **[backup cd/dvd to iso](https://www.youtube.com/watch?v=ZSsxaL5ZzJE)**

## **[dell usb install](https://www.youtube.com/watch?v=r-LcJ0OHYsI)**

## Reporting Work Flow

Use the easily updated "Oil adds to Machines.xlsx" spreadsheet which has one row with machine/oil_type/line and oil quantity for each day of the month to update the Structures OAM data lake table with a PySpark notebook.

Secondary goal: Document the Fabric/PowerBI/Datalake process and record it for the team.

Meeting for get data.

1. model
2. get data
    - notebooks
    - pipeline

Hi Cody. Sorry for the delay in responding. I am currently working on a Fabric/PowerBI/datalake workflow from a video describing the medallion bronze/silver/gold process and will record these steps for anyone interested. The plan is to use the process for making Plex reports. After the process is complete will install a Fabric Gateway and connect to Plex using ODBC from this Windows 22 server. I apologize for the delay and will keep you posted. **[Design MICROSOFT FABRIC Data Project with Medallion Architecture | Lakehouse + Spark + Power BI](https://www.youtube.com/watch?v=qG65DUcSjws)**

## Task Management

Jira is a project management and issue-tracking tool used by teams, especially in software development, to plan, track, and manage their work. It helps teams organize projects, track bugs and issues, and streamline their workflows through customizable boards like Kanban and Scrum, allowing them to manage tasks and monitor progress from start to finish.

Many modern project management and development tools are designed to run in containerized environments:
GitLab: A popular option that combines project management, source code management, and CI/CD pipelines and offers extensive documentation for Kubernetes deployment.
Redmine / Jira: Self-hosted instances of these tools can be containerized and deployed on K8s, often with community-maintained Helm charts available.

## Deploy Charmed K8s and gitlab

## Hearing test

- Nov 14th, at Avilla @ 4:20pm

## Dimensional Gage - Marposs

- It is constantly being used. Need one to work on.

## Oil adds

- Medallian layer tutorial at silver layer parquet file.
- Need to install Fabric Gateway to access Plex from Fabric.
- made parquet file from csv using pyspark.
- copy user friendly excel into data lake oam folder
- notebook transforms excel to easily digestable csv file format and copies rows into datalake oam table

## Next

cannon eos rebel t3/1100d
<https://en.canon-me.com/support/consumer/products/cameras/eos/eos-1000d.html?type=software&detailId=tcm:60-1309830&os=Windows%2010%20%2864-bit%29&language=&productTcmUri=tcm:60-555789>
<https://www.youtube.com/watch?v=VTLISryqbSc>

I can setup the Serial device server and help configure the Marposs dimensional guage. Jared has had previous experience working the Marposs so he is taking a look at it also.

- **[PySpark Tutorial](https://www.geeksforgeeks.org/python/pyspark-tutorial/)**

Last Updated : 18 Jul, 2025
PySpark is the Python API for Apache Spark, designed for big data processing and analytics. It lets Python developers use Spark's powerful distributed computing to efficiently process large datasets across clusters. It is widely used in data analysis, machine learning and real-time processing.

![i](https://media.geeksforgeeks.org/wp-content/uploads/20250718112356343916/statistics_key_concepts.webp)

- **[online pyspark compiler](https://www.sparkplayground.com/pyspark-online-compiler)**
- **[PySpark Tutorial for Beginners - Jupyter Notebooks](https://github.com/coder2j/pyspark-tutorial)**
- **[GraphFrames](https://medium.com/@krthiak/graph-based-data-and-graphframes-in-pyspark-day-32-of-100-days-of-data-engineering-ai-and-azure-449da4a628e7)**
- **[Resilient Distributed Datasets](https://www.tutorialspoint.com/apache_spark/apache_spark_rdd.htm)**

The main abstraction Spark provides is a resilient distributed dataset (RDD), which is a collection of elements partitioned across the nodes of the cluster that ...

- **[Tarek's update on Fabric channel:From Query to Conversation: Microsoft Fabric’s Data Agents Explained (youtube.com)](<https://www.youtube.com/watch?v=mFoSVcj6tLw>)**
- **[Building Power BI semantic models with Direct Lake in Microsoft Fabric](https://www.youtube.com/watch?v=ACbBgCwTXSg)**
- **[Create dataframe using Python Dictionaries](https://www.w3schools.com/python/python_dictionaries.asp)**
- **[Design MICROSOFT FABRIC Data Project with Medallion Architecture | Lakehouse + Spark + Power BI](https://www.youtube.com/watch?v=qG65DUcSjws)**
- **[04-Module Topic 2-Introduction to Measures and Calculated Columns(PowerBI file included)](https://www.youtube.com/watch?v=8oK2CJJ3fDg)**

- **[Master Data Modeling in Power BI - Beginner to Pro Full Course](https://www.youtube.com/watch?v=air7T8wCYkU)** get and transform data using power query using the Kimball approach.

## How much are we spending on each line

Work with Randy Albion controller.

## Setup Fabric/Data Lake/Power BI Fabric WorkFlow process training

- transcript and recording

- Data Modeling - Kimball/Star Schema

![df](https://res.cloudinary.com/dwwq4fbhq/image/upload/v1761250282/data_flow.drawio_x2btyk.png)

## Data Warehouse Structure

**[Slowly Changing Dimensions](https://www.geeksforgeeks.org/software-testing/slowly-changing-dimensions/)**

In a typical data warehouse, dimension data such as customer information, product details, or employee records can change. Managing these changes efficiently and effectively is where Slowly Changing Dimensions (SCD) come into play. There are several types of SCDs, each providing a different way to handle changes, ensuring that historical data is preserved and accurately reflected.

In conclusion, there is nothing as important in a data warehouse as Keeping Slowly Changing Dimensions (SCDs) if the organization intends to track past performance accurately, and not make analysis a herculean task. Different types of SCDs and intricate methods like the Hybrid SCDs and Temporal Tables let organizations handle all sorts of data change transactions and become data-driven. When these strategies are well designed and properly used, they result in the accuracy of the data, beyond which the results provide a means for historical review, and support the overall quality of business intelligence.

**[Master Data Modeling in Power BI - Beginner to Pro Full Course](https://www.youtube.com/watch?v=air7T8wCYkU)**

**[Basic Semantic Model](https://www.youtube.com/watch?v=uioqDxQQrfY)**
<https://learn.microsoft.com/en-us/power-bi/create-reports/service-from-excel-to-stunning-report>

## Change in ETL

- Semantic Model is needed for reusable fact calculations
- If Semantic Model uses excel files as data sources duplicates occur.
- In Tarrifs reports there are multiple excel files and if a duplicate is entered the semantic model based report fails.
- In the Excel based Oil report there is a worksheet for every month.
- Use Excel as an input of a notebook to update the data lake, warehouse, or database. Primary keys ensure no duplicates and a single table can grow as large as necessary.  
- Notebook cleans Excel data source.

## Beth Schaus

Still working on it. Cody can probably fix the problem right away, but I think we need to look at a more reliable data source for this report.  I have added you to a Fabric email that was sent out. I apologize for the delay.
Group Office Reports/Structures Group Tarrifs/

What is the semantic model

- intermediary between data source and reports

- Data Source is several Excel files.
- Errors occur when there are duplicate records.

## Goals

- Get time series data to data lake using KepServerEx
- Analyze with Notebooks
- Create PBI reports/dashboards using TS data
- Create group oriented org apps with Notebooks and PBI reports/dashboards
- Setup Fabric Gateway
- Setup MicroCloud
- Setup Charmed K8s
- Publish Fabric Process
- Collect CNC tooling data from CNC
- Create Tool Management System (TMS)

## SQL Server vs Pandas vs M Code

In SQL Server 22+ and many other SQL dialects we can now generate a time series, but when you are working with a time series Python's Pandas library is the defacto standard for financial and economic analysis.

"In essence, Pandas has become an indispensable tool in the Python data science ecosystem due to its efficiency, flexibility, and comprehensive features for handling and analyzing structured data."

M Code is a Power BI Desktop and Excel Microsoft 365 data mashup language

M Code (Power Query Language):

- Strength: Designed specifically for data extraction, transformation, and loading (ETL) within the Microsoft ecosystem (Excel, Power BI, Fabric). It excels at connecting to diverse data sources, cleaning, shaping, and merging data, often with a user-friendly graphical interface that generates M code.
- Limitations: While powerful for its intended purpose, M Code is not a general-purpose programming language. It lacks the broader capabilities of a full-blown language for tasks like advanced statistical analysis, machine learning, web development, or building complex applications.

M Code is compatible with: Power BI Service Power BI Desktop Excel Microsoft 365 and it has functions similar to Pandas such as List.Dates:

List.Dates is a Power Query M function that generates a list of date values with a specified size, starting point, and step increment. The function returns a list of date values incremented by the given duration value.

### Business Year Start anchored to April

bys_april = pd.date_range(start='2020-01-01', periods=4, freq='BYS-APR')
print("Business Year Start (BYS) - Fiscal Year ending in March:")
print(bys_april)r

### Business Year End anchored to Mach

bye_march = pd.date_range(start='2020-01-01', periods=4, freq='BYE-MAR')
print("\nBusiness Year End (BYE) - Fiscal Year ending in March:")
print(bye_march)

## next

**[Planar_Graphs](../research/m_z/virtualization/networking/graph_theory/libretexts/planar_graphs.md)**
**[Real World Applications of A Spanning Tree:](../research/m_z/virtualization/networking/graph_theory/spanning_tree.md)**

## Weekly update

- Join Structures MicroClouds Windows Server 22 Fabric Gateway VM to domain
- Windows Server 22 licensing with corporate key management server
- How to share fabric items
- org apps (preview) vs workspace apps
- can share notebooks
- data lake read only, data warehouse r/w no primary key
- need primary key so no duplicates
- AOM add date to sheet so no duplicates
- Azure SQL ETL
- Azure Power App Jared
- documented Structures MicroCloud servers and VMs for audit.
That's Structures Fabric Gateway. It has Windows Server 22. I have got a license for it yet.

- Added comments to star review. HR adds you to Oracle and sometimes they do not enter all the info needed such as manager and domain EntraId account. If this is the case you will receive
the following error: System error. "Please re-try your action. If you continue to get this error, please contact the Administrator." when clicking company single sign on button. After HR makes enters your domain user account it takes time to take effect. In my case I tried to sign in the next day.

**Might need to delete forwarding rule...**

- **[Get started with org apps (preview)](https://learn.microsoft.com/en-us/power-bi/consumer/org-app-items/org-app-items)**
- access to oracle star review
- **[fan networking](https://wiki.ubuntu.com/FanNetworking)**
- research/virtualization/hypervisor/lxd/cluster/
setup cluster with research11,12,r410 with zfs storage pool.
- [ovn setup](../research/m_z/virtualization/networking/ovn/tutorials/basic_single_node_ovn_setup.md)
- **[How to configure network forwards](res/virt/lxd/network/tut/forwarding_rules.md)**

- **[Trigonometric operations in excel file using openpyxl](https://www.geeksforgeeks.org/python/working-with-excel-spreadsheets-in-python/geeksforgeeks.org/python-trigonometric-operations-in-excel-file-using-openpyxl/)**
- **[How to copy data from one excel sheet to another](https://www.geeksforgeeks.org/python/python-how-to-copy-data-from-one-excel-sheet-to-another/)**
- **[How to Automate an Excel Sheet in Python?](https://www.geeksforgeeks.org/python/how-to-automate-an-excel-sheet-in-python/)**

**[Set up a LXD cluster on OVN](https://documentation.ubuntu.com/lxd/latest/howto/network_ovn_setup/#set-up-a-lxd-cluster-on-ovn)**

- **[share power bi reports](https://learn.microsoft.com/en-us/power-bi/collaborate-share/service-share-dashboards)**
- **[sharing microsoft fabric org app](https://www.youtube.com/watch?v=7W3_9J0emKM&t=1)**
- **[building reports in fabric](https://learn.microsoft.com/en-us/fabric/fundamentals/building-reports#:~:text=Permissions%20to%20view%20report%2C%20create,access%20on%20the%20Fabric%20item.)**
- **[sharing fabric org app](https://www.youtube.com/watch?v=7W3_9J0emKM)**
**[research/virt/net/ovs/geneva_tunnel](https://albertomolina.wordpress.com/2022/12/04/openvswitch-geneve-tunnel/)**

**[research/virt/net/ovs/basic](https://albertomolina.wordpress.com/2022/06/10/openvswitch-basic-usage/)**

**[give lxd container public ip](virtualization/hypervisor/lxd/network/public_ip)

<https://stackoverflow.com/questions/3582108/create-windows-service-from-executable>
<https://documentation.ubuntu.com/lxd/latest/howto/disaster_recovery/>
<https://www.youtube.com/watch?v=CQv9VFHPRcw>
<https://docs.ceph.com/en/reef/cephfs/ceph-dokan/#limitations>

<https://discuss.linuxcontainers.org/t/issues-with-default-instance-mtu-of-1500-on-ovn-networks/23020>

To skip network setup in Windows 11, press Shift+F10 at the "Let's connect you to a network" screen to open a Command Prompt. Type OOBE\BYPASSNRO and press Enter, then your computer will restart. After restarting, you will see an option for "I don't have internet" which you can select to continue with limited setup and create a local user account.

<https://seanblanchfield.com/2023/05/bridge-networking-in-lxd>

- can only ping containers on same host
- can only ping internet on leader.

## answer

<https://discourse.ubuntu.com/t/cannot-connect-to-lxc-container-from-host-using-microovn-network/51503>

In a clustered LXD environment with Open Virtual Network (OVN), the "uplink" is a network configuration rather than a fixed process running on a single host. For any given OVN network, one of the LXD cluster members acts as the active gateway chassis at a time, providing the ingress and egress point to the physical network.

## research

- **[installing lib in Fabric notebooks environment](https://medium.com/@grega.hren/installing-public-pypi-python-library-in-microsoft-fabric-e224ae842788)**
- **[OVS basic usage](https://albertomolina.wordpress.com/2022/06/10/openvswitch-basic-usage/)**
- **[A deep dive into Linux namespaces](https://ifeanyi.co/posts/linux-namespaces-part-1/)**
- **[How to get LXD containers obtain IP from the LAN with ipvlan networking](https://blog.simos.info/how-to-get-lxd-containers-obtain-ip-from-the-lan-with-ipvlan-networking/)**
- **[OVN inner workings](https://discuss.linuxcontainers.org/t/would-love-to-understand-the-inner-workings-of-the-ovn-network/17439)**
- **[create windows image for MicroCloud](https://www.youtube.com/watch?v=DVxzGm5jIEI)**

--console=vga unshare: write failed /proc/self/uid_map: Operation not permitted
The error unshare: write failed /proc/self/uid_map: Operation not permitted indicates a failure to create a new user namespace with a User ID (UID) mapping. The unshare command is used to create new namespaces (like user, PID, network, etc.) for isolation, which is a core component of containerization.
The uid_map is a file in the /proc filesystem that defines the mapping of user IDs inside a new user namespace to user IDs on the host system. The "Operation not permitted" error is a security-related problem where the process lacks the necessary permissions to perform this operation.

1. AppArmor or SELinux restrictions
On systems like Ubuntu, security features such as AppArmor can block the creation of unprivileged user namespaces and the writing to uid_map.
Cause: A recent system update (e.g., to Ubuntu 24.04 "Noble") may have tightened security policies.
Solution: You can disable the relevant AppArmor restrictions, though this may decrease security.
sh
sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=0

<brent.groves@linamar.com>
<https://accounts.sap.com/ui/onbehalfupdate/submit>

- charmed kubernetes  <https://ubuntu.com/kubernetes/charmed-k8s/docs/install-local>
- <https://ubuntu.com/kubernetes/charmed-k8s/docs/quickstart>
- Encryption with Ceph/Bitlocker

## Sept

## Describe admin tasks

As an admin, you might be responsible for a wide range of tasks to keep the Fabric platform running smoothly. These tasks include:

**Security and access control:** One of the most important aspects of Fabric administration is managing security and access control to ensure that only authorized users can access sensitive data. You can use role-based access control (RBAC) to:

- Define who can view and edit content.
- Set up data gateways to securely connect to on-premises data sources.
- Manage user access with Microsoft Entra ID.

## Aug 25th

- Setup Fabric Gateway for data sources not accessible from Fabric directly.
- Research managing/publishing Power BI reports.
- HA Storage to include object storage.
-

## Aug 16th

- If you filter columns and records in CTEs prior to the final select statement no noticable change in run time is noticed.  If you run queries several times a huge performance increase occurs.
- Foriegn key constraints prevent records from being deleted that are referenced in tables. Many foriegn key constraints are missing in Plex, so be careful to use outer joins so you do not drop records.
- Using a virtual router using the VRRP protocol allows us to keep network sessions alive during reboots of storage clusters and microservices.

## Aug 4th

- Setup Fabric Gateway Windows Server with 64GB ram with ODBC connection to Plex.
- Fabric Directory Structure

## July 31

Check if Plex supports **[OData](https://www.odata.org/)**
developers.plex.com
email,password

## July 23

Check if Plex supports **[OData](https://www.odata.org/)**
developers.plex.com
email,password

Semantic models hide the complex technical details behind reports so that both technical and non-technical users can concentrate on analyzing the data and answering business questions. Sharing and reusability are two stand-out features of semantic models.

## What Makes Up a Semantic Model?

Semantic models consist of several different elements:

Data connections to one or more data sources, either imported, through DirectQuery, or as part of a composite model.
Transformations that clean and prepare the data for reporting.
Defined calculations and metrics based on business rules to ensure consistent reports built from the semantic model. This ensures clarity and avoids discrepancies between analyses and reports.
Defined relationships between tables allow users to focus on designing reports without knowing the underlying database structures and data models beforehand.

## power bi semantic models with stored procedures

**[stored procedures](https://www.youtube.com/watch?v=N1En6_NB_dY)**
**[call sprocs from power bi](https://www.youtube.com/watch?v=-GS3Kxvxm7A&t=247s)**
Options:

1. Allow the ETL system call stored procedures to load and transform you data and use Power BI to connect to the ETL systems result sets and use **[star schema best practices](https://www.owox.com/blog/articles/star-schema-explained)**
2. Use Power BI direct query mode to retrieve only data needed for complete transformation. Don't know if this mode is compatible with Power Query M language and DAX functions

## DirectQuery and Dynamic Parameters

When you need to pass dynamic parameters (user inputs) to a stored procedure, DirectQuery mode is typically required.
This allows for interactive reports where user selections in the report UI are passed as parameters to the stored procedure in the database.
Example: You might have a stored procedure that filters data based on a date range selected by the user in the report.

## Links

- The **[Fabric Analyst in a Day (FAIAD)](https://aka.ms/LearnFAIAD)**
- **[Fabric user panel](https://learn.microsoft.com/en-us/fabric/fundamentals/feedback#fabric-user-panel)**
- **[SQL database in Microsoft Fabric (Preview)](https://learn.microsoft.com/en-us/fabric/database/sql/overview)**

The **[Fabric Analyst in a Day (FAIAD)](https://aka.ms/LearnFAIAD)** workshop is a free, hands-on training designed for analysts working with Power BI and Microsoft Fabric. You can get hands-on experience on how to analyze data, build reports, using Fabric. It covers key concepts like working with lakehouses, creating reports, and analyzing data in the Fabric environment.

Join our new Microsoft Fabric user panel to share your feedback and help shape Fabric and Power BI. Participate in surveys and 1:1 sessions with the product team. Learn more and sign up **[Fabric user panel](https://learn.microsoft.com/en-us/fabric/fundamentals/feedback#fabric-user-panel)**.

- Help access APIs from Plex
  - <https://plex.my.site.com/community/s/question/0D52T00005b6l1YSAQ/calling-a-plex-http-api-from-powerbi-pure-mquery>
  - <https://plex.my.site.com/community/s/question/0D52T00005wznVcSAI/how-to-integrate-plex-with-power-bi>

- **[Data Pipeline](https://cloud.google.com/dataflow/docs/quickstarts/create-pipeline-go)**
  - Go's best feature is handling concurency. Use it to manage our Python ETL scripts.

- **[Real-time data warehousing with Apache Spark and Delta Lake](https://www.sigmoid.com/blogs/near-real-time-finance-data-warehousing-using-apache-spark-and-delta-lake/)**
  - Reporting values over time

1. collect data periodically
2. Make quantity used set by calculating difference between consecutive values of periodic data.
3. Make quantity used change per period set by calculating difference between consecutive quantity used values.

In data analysis, "direction fields" (also called slope fields) are a visual representation of the solutions to a differential equation. They help understand the behavior of the equation by showing the direction (slope) of the solutions at various points on a graph.
OData
<https://stackoverflow.com/questions/9084761/how-to-calculate-the-slope-in-sql>

```sql
SELECT
    Scores.Date, Scores.Keyword, Scores.Score,
    (N * Sum_XY - Sum_X * Sum_Y)/(N * Sum_X2 - Sum_X * Sum_X) AS Slope
FROM Scores
INNER JOIN (
    SELECT
        Keyword,
        COUNT(*) AS N,
        SUM(CAST(Date as float)) AS Sum_X,
        SUM(CAST(Date as float) * CAST(Date as float)) AS Sum_X2,
        SUM(Score) AS Sum_Y,
        SUM(CAST(Date as float) * Score) AS Sum_XY
    FROM Scores
    GROUP BY Keyword
) G ON G.Keyword = Scores.Keyword;
It uses Simple Linear Regression to calculate the slope.

Result:

Date         Keyword        Score         Slope
2012-01-22   water bottle   0,010885442   0,000334784345222076
2012-01-23   water bottle   0,011203949   0,000334784345222076
2012-01-24   water bottle   0,008460835   0,000334784345222076
2012-01-25   water bottle   0,010363991   0,000334784345222076
2012-01-26   water bottle   0,011800716   0,000334784345222076
2012-01-27   water bottle   0,012948411   0,000334784345222076
2012-01-28   water bottle   0,012732459   0,000334784345222076
2012-01-29   water bottle   0,011682568   0,000334784345222076
Every database system seems to have a different approach to converting dates to numbers:

MySQL: TO_SECONDS(date) or TO_DAYS(date)
Oracle: TO_NUMBER(TO_CHAR(date, 'J')) or date - TO_DATE('1','yyyy')
MS SQL Server: CAST(date AS float) (or equivalent CONVERT)
```

- EntraID access to Azure SQL db for Sam.
- Python uv ODBC test. Don't know the ODBC state of the laptop before I started. I know 32-bit libraries had not been installed because ./rcshell reported unknown file but I could have just removed them after the last install. Create a Python self-installing file with pyodbc in the top dependancies section.

- Providing support to Jared EikenBerry in Fruitport for running ETL scripts for Power BI. His scripts will be automated by the ETL report system.
- Jared EikenBerry Admin privileges.

- Create InnoDB scripts
  - make Reporting4 from Reporting which has the mysql and azure sql scripts.
  - Install IAzure Data Studio officially retires on February 28, 2026. You should migrate to Visual Studio Code. This change aims to consolidate SQL development tools and provide a more robust and feature-rich environment for the developer community.nnoDB on K8s
  - Create InnoDB Schema from Mysql schema
  - populate InnoDB database with records from Mysql.
- SystemD socket activation unit listens for connection and then start a one-shot unit. The one-shot unit runs many tasks consequatively such as those in an ETL pipeline. Test it on Linamar Azure SQL TB.
- Suggested Mach2 Linux GW on server VLAN using Netfilter port forwarding and Natting features. mTLS option requires proxy.
- Run TB script from **[Linamar Azure SQL DB](./b_platform_engineering/database/azuresqldb/run_tb_from_azure_sql_db.md)** tennant.
- SystemD vs Kubernetes
  - SystemD is better at starting programs after other programs.
  - Kubernetes uses yaml SystemD used TOML.
  - Kubernetes manages scalability of services.
  
- Make GoLang and Python dev container to create base docker image for ETL scripts.
- Compare mail service options.
  You might wonder, “Why go through the effort when third-party services exist?” The answer lies in control. Self-hosting lets you tailor spam filters, encrypt communications your way, and ensure compliance with regional data laws.

  - Postfix with public key security and Amazon programmatic DNS txt record creation.
  - Mailtrap service.

## info

- Azure Data Studio officially retires on February 28, 2026. You should migrate to Visual Studio Code. This change aims to consolidate SQL development tools and provide a more robust and feature-rich environment for the developer community.
- was able to access plex without config request from desktop server vlan.
- All the knowledge of programmers who made the software in the lifecycle API.
- OpenStack uses JuJu.
- Does Nutanix use OpenStack?

Yes, Nutanix integrates with OpenStack. Nutanix provides drivers for core OpenStack services like Nova, Cinder, Glance, and Neutron, allowing users to easily connect their Nutanix infrastructure to OpenStack. This integration enables organizations to leverage the benefits of both platforms, including Nutanix's hyperconverged infrastructure and OpenStack's cloud management capabilities?

- **[file descriptors](https://copyconstruct.medium.com/bash-redirection-fun-with-descriptors-e799ec5a3c16)**

## Misc

- Migrate from MSC to new vending machines.
- Muscle Shoals thin client certificates.
- Use cloud.plex.com to locate new accounts for TB web services such as account_nos_gets and account_nos_picker_get.

## Questions

- Can setup HyperV Ubuntu 24.04 server VM in 50 and 1220 VLans on core server. To access Albion subnets from R620s using port forwarding.
- Ask for Plex web service account from Sam or Kevin
- Does any location besides Indiana have vending machines?

## **[Research](../research/research_list.md)**

- port forwarding with OVS
- Use cloud.plex.com to locate new accounts for TB web services such as account_nos_gets and account_nos_picker_get.

## **[Data Analysis](./a_data_analysis/is_data_analysis.md)**

- days on hand formula

## **[Automated Certificate Management System](./a_certificate_management/certificate_management_status.md)**

- Add Nancy Swank and Jamie Pyle computers to PKI GPO.

## Automated ETL and Report System

- Python base data source docker image.
- Move schema and ETL scripts from Mobex Azure SQL MI to the Linamar Azure SQL DB and Avilla K8s servers.
- Write scripts to compare Mobex Azure SQL result sets to Linamar Azure SQL DB result set.

## Tool Management System

- Access to vending machine schema

## Structures Information Systems, Kubernetes, or K8s, Platform Engineering Support

- Jared made config request to move Dell R620s to core server using link aggregation and 10 GP SPF+ modules.
- **[Access VLAN 1220](../research/m_z/virtualization/networking/linamar/avilla/isdev/vlan1220/edge/try2.md)** to check Albion Mach2 certificate chain.
