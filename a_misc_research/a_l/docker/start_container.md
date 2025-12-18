# **[start container](https://docs.docker.com/reference/cli/docker/container/start/)**

## docker container start

Description Start one or more stopped containers
Usage docker container start [OPTIONS] CONTAINER [CONTAINER...]
Aliases
docker start
Description
Start one or more stopped containers

Options
Option Default Description
-a, --attach  Attach STDOUT/STDERR and forward signals
--checkpoint  experimental (daemon) Restore from this checkpoint
--checkpoint-dir  experimental (daemon) Use a custom checkpoint storage directory
--detach-keys  Override the key sequence for detaching a container
-i, --interactive  Attach container's STDIN

```bash
docker start my_container
```

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
