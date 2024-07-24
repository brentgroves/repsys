# **[timezones](https://hoa.ro/blog/2020-12-08-draft-docker-time-timezone/)**

## Use host machine configuration

This is the simplest solution for setting the time of your containers: using the time and time zone of the host machine, the one that hosts the Docker service.

On the other hand, this solution only works if you have control of the host, and it is not applicable if you send your containers into any cloud solution.

To do this, we will mount two volumes in read-only mode on the configuration files of the host clock in our containers.

In docker run command, we add two volumes:

```bash
date
Wed Jul 24 06:17:23 PM EDT 2024
cat /etc/timezone                                               
America/Indiana/Indianapolis
# This is a binary file
cat /etc/localtime 
EST5EDT,M3.2.0,M11.1.0

docker run -d \
   -v /etc/timezone:/etc/timezone:ro \  
   -v /etc/localtime:/etc/localtime:ro \
   [...]
Or with a docker-compose.yml file:

services:
  service_name:
    volumes:
      - "/etc/timezone:/etc/timezone:ro"
      - "/etc/localtime:/etc/localtime:ro"
```

## **[timezones](https://stackoverflow.com/questions/49959601/configure-time-zone-to-mysql-docker-container)**

```mysql
mysql> SELECT @@global.time_zone, @@session.time_zone;
SELECT @@global.time_zone, @@session.time_zone;
+--------------------+---------------------+
| @@global.time_zone | @@session.time_zone |
+--------------------+---------------------+
| SYSTEM             | SYSTEM              |
+--------------------+---------------------+
1 row in set (0.00 sec)

# docker image
SELECT CURRENT_TIMESTAMP ;
+---------------------+
| CURRENT_TIMESTAMP   |
+---------------------+
| 2024-07-24 21:56:48 |
+---------------------+
1 row in set (0.01 sec)

# reports31
SELECT CURRENT_TIMESTAMP;
2024-07-24 17:57:20
# repsys11_c2_n1
SELECT CURRENT_TIMESTAMP ;
2024-07-24 17:58:35
```

```bash
cat /etc/timezone
docker exec -it mysql-mgdw bash           
bash-5.1# date
Wed Jul 24 22:12:13 UTC 2024
```
