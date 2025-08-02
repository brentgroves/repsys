# **[use ceph with rclone](https://www.youtube.com/watch?v=L9O9bDIvx28)**

**[](https://rclone.org/install/)

<https://forum.rclone.org/t/mount-bucket-as-network-drive-using-rclone-ceph-object-gateway/43825/15>

## reference

- **[](https://askubuntu.com/questions/202072/what-is-a-good-amazon-s3-client)**

2023 Follow-Up
<https://github.com/rclone/rclone> : works nearly everywhere , e.g. self hosted minio
<https://github.com/s3fs-fuse/s3fs-fuse> : works as usual with "all" backends
<https://github.com/minio/mc> : works as well with most implementations
self-signed certs might become tricky , but you could always use socat to circumvent this
dragon-disk ( <http://www.s3-client.com/download-s3-compatible-cloud-client.html> ) : deb too old for current ubuntu ( unmet dependencies), binary archive is 386 only and fails on libQtXml.so.4 ( not installable from packages )
<https://github.com/cloudlena/s3manager> → did not work with filebase
crossFTP : did not follow ssl-redirects , did not offer ssl for custom endpoint
OFFLINE: <https://www.s3fox.net/> is now a casino site
Share
Edit
Follow
edited Jun 8, 2023 at 9:57
answered Feb 28, 2023 at 23:24
Benji over_9000 'benchonaut''s user avatar
Benji over_9000 'benchonaut'
70444 silver badges1616 bronze badges
1
Thank you for the write up. It seems like there is a lot of outdated info out there. –
DeadlyChambers
 CommentedMay 20, 2023 at 18:22
s3fs was the way to go for me - FS integration so can use terminal or Files to view –
HankCa
 CommentedMar 11, 2024 at 22:35
Add a comment
8

Free version of CrossFTP has S3 support and seems to do the job: <http://www.crossftp.com> Screenshot is from their website. The free version looks the same.
