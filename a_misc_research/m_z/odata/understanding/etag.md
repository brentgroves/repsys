# **[](https://community.sap.com/t5/application-development-and-automation-blog-posts/etag-in-odata/ba-p/13463768)**

This blog post will give the basic overview for beginners on the Etag topic in Odata.
Introduction

E tag is used for Data Concurrency to avoid over writing of same record at the same time by different users similar to Lock objects.

## Scenario for Etag

User  1  and user 2 will get the same record from backend  , user 1 will update the data and save the record in database , user 2 without knowing data has been already updated to the record which he supposed to update he  will update the same record and saves the data , at this time data saved by user1 will be overwritten by data of user 2 , this is  not supposed to happen , this leads to data inconsistency  to avoid this  we will go for ETag (Entity tag) .

In etag  we will have field which will uniquely  identify each updating of the record whenever its updated , this field values can be generated using hash algorithm  or a timestamp filed can be used to generate the etag value , which will prevent the unnecessary or concurrent updation of same record by different users at same time  in this blog post we will see how can achieve this by using hash algorithm .

## Procedure

Created a custom table with spfli fields along with Etag Field  DB table ZSPFLI_ETAG.

Custom Table ZSPFLI_ETAG with Etag

![i1](https://community.sap.com/legacyfs/online/storage/blog_attachments/2020/09/Zspfli_etag.png)

Here the field etag has the standard data type hash160 which stores the etag value .

At first There will Be no Etag values  in table For newly created records.

![i2](https://community.sap.com/legacyfs/online/storage/blog_attachments/2020/12/zspfli.png)
