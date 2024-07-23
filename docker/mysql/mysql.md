# **[mysql](https://dev.mysql.com/doc/mysql-installation-excerpt/8.0/en/docker-mysql-getting-started.html)**

**[Current Status](../../development/status/weekly/current_status.md)**\
**[Back to Main](../../README.md)**

## 7.6.1 Basic Steps for MySQL Server Deployment with Docker

Warning
The MySQL Docker images maintained by the MySQL team are built specifically for Linux platforms. Other platforms are not supported, and users using these MySQL Docker images on them are doing so at their own risk. See the discussion here for some known limitations for running these containers on non-Linux operating systems.

## **[Downloading a MySQL Server Docker Image](https://dev.mysql.com/doc/mysql-installation-excerpt/8.0/en/docker-mysql-getting-started.html#docker-download-image)**

Downloading a MySQL Server Docker Image\
Important\
For users of MySQL Enterprise Edition: A subscription is required to use the Docker images for MySQL Enterprise Edition. Subscriptions work by a Bring Your Own License model; see How to Buy MySQL Products and Services for details.

Downloading the server image in a separate step is not strictly necessary; however, performing this step before you create your Docker container ensures your local image is up to date. To download the MySQL Community Edition image from the Oracle Container Registry (OCR), run this command:

<!-- https://container-registry.oracle.com/ords/ocr/ba/mysql/community-server -->
```bash
docker pull container-registry.oracle.com/mysql/community-server:tag
docker pull container-registry.oracle.com/mysql/community-server:latest
docker images                                                          
REPOSITORY                                             TAG       IMAGE ID       CREATED        SIZE
container-registry.oracle.com/mysql/community-server   latest    cac5f339794c   16 hours ago   564MB
```

The tag is the label for the image version you want to pull (for example, 5.7, 8.0, or latest). If :tag is omitted, the latest label is used, and the image for the latest GA version of MySQL Community Server is downloaded.

## Starting a MySQL Server Instance

To start a new Docker container for a MySQL Server, use the following command:

```bash
docker run --name=container_name  --restart on-failure -d image_name:tag
docker run --name=mysql-mgdw  --restart on-failure -d container-registry.oracle.com/mysql/community-server
```

image_name is the name of the image to be used to start the container; see Downloading a MySQL Server Docker Image for more information.

The --name option, for supplying a custom name for your server container, is optional; if no container name is supplied, a random one is generated.

The --restart option is for configuring the restart policy for your container; it should be set to the value on-failure, to enable support for server restart within a client session (which happens, for example, when the RESTART statement is executed by a client or during the configuration of an InnoDB cluster instance). With the support for restart enabled, issuing a restart within a client session causes the server and the container to stop and then restart. Support for server restart is available for MySQL 8.0.21 and later.

For example, to start a new Docker container for the MySQL Community Server, use this command:

```bash
docker run --name=mysql-mgdw  --restart on-failure -d container-registry.oracle.com/mysql/community-server:latest
```

If the Docker image of the specified name and tag has not been downloaded by an earlier docker pull or docker run command, the image is now downloaded. Initialization for the container begins, and the container appears in the list of running containers when you run the docker ps command. For example:

```bash
$> docker ps
CONTAINER ID   IMAGE                                                         COMMAND                  CREATED          STATUS                    PORTS                       NAMES
4cd4129b3211   container-registry.oracle.com/mysql/community-server:latest   "/entrypoint.sh mysq…"   8 seconds ago    Up 7 seconds (health: starting)   3306/tcp, 33060-33061/tcp   mysql1
```

The container initialization might take some time. When the server is ready for use, the STATUS of the container in the output of the docker ps command changes from (health: starting) to (healthy).

The -d option used in the docker run command above makes the container run in the background. Use this command to monitor the output from the container:

```bash
docker logs mysql1
```

Once initialization is finished, the command's output is going to contain the random password generated for the root user; check the password with, for example, this command:

```bash
$> docker logs mysql1 2>&1 | grep GENERATED
GENERATED ROOT PASSWORD: Axegh3kAJyDLaRuBemecis&EShOs
```

## Connecting to MySQL Server from within the Container

Once the server is ready, you can run the mysql client within the MySQL Server container you just started, and connect it to the MySQL Server. Use the docker exec -it command to start a mysql client inside the Docker container you have started, like the following:

```bash
docker exec -it mysql1 mysql -uroot -p
```

When asked, enter the generated root password (see the last step in Starting a MySQL Server Instance above on how to find the password). Because the MYSQL_ONETIME_PASSWORD option is true by default, after you have connected a mysql client to the server, you must reset the server root password by issuing this statement:

```bash
mysql> ALTER USER 'root'@'localhost' IDENTIFIED BY 'password';
Substitute password with the password of your choice. Once the password is reset, the server is ready for use
```
