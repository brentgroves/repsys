# **[use ceph with rcloen](https://www.youtube.com/watch?v=L9O9bDIvx28)**

**[](https://ceph.io/en/news/blog/2025/rgw-multisite-replication_part8/)**

## <https://github.com/rclone/rclone/issues/4954>

## **[use ceph with rcloen](https://www.youtube.com/watch?v=L9O9bDIvx28)**

<https://www.netapp.com/blog/amazon-s3-as-a-file-system/>

## AI: configure rclone to access ceph

To configure Rclone to access Ceph, which is an S3-compatible object storage, follow these steps: Start Rclone Configuration.
Open your terminal and run the command:
Code

    rclone config
This will launch the interactive configuration wizard. create a new remote.
When prompted, choose to create a "New remote" by typing n and pressing Enter. Name the Remote.
Provide a descriptive name for your Ceph remote (e.g., mycephstorage) and press Enter. Select Storage Type.
Choose s3 (Amazon S3 Compliant Storage Providers) from the list of storage types. This option includes Ceph. Select S3 Provider.
When asked for the S3 provider, select Ceph from the available options.
Enter Credentials:
Access Key ID: Enter your Ceph access key ID.
Secret Access Key: Enter your Ceph secret access key.
Specify Endpoint:
Enter the endpoint URL for your Ceph object storage. This is typically in the format http(s)://<ceph-cluster-address>:<port>.
Configure Remaining Options (Optional but Recommended):
Region: You can usually leave this blank for Ceph unless your setup requires a specific region.
Location Constraint: Similarly, this can often be left empty.
ACL: Consider setting the default Access Control List (ACL) for uploaded objects (e.g., private).
Server-Side Encryption: Choose None unless you have specific server-side encryption requirements with Ceph.
Edit Advanced Config: Unless you have specific advanced settings to configure, you can typically decline editing advanced config.
Confirm and Save:
Review the summarized configuration and confirm by typing y and pressing Enter. Then, quit the configuration by typing q and pressing Enter.
Your Rclone remote for Ceph is now configured and ready for use. You can now use Rclone commands (e.g., rclone ls mycephstorage:, rclone copy /path/to/local/file mycephstorage:/bucket/path) to interact with your Ceph object storage.
Dive deeper in AI Mode
