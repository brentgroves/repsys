# **[stop and delete containers](https://spacelift.io/blog/docker-stop-container)**

## How to stop a running Docker container

To stop a running container, you can use the docker stop command and provide either the container name or container ID. You can find these from the information supplied in the docker ps command.

For example, as shown above, the container ID of my running Ubuntu container is ccfac1f88d1b:

```bash
docker ps                      
CONTAINER ID   IMAGE                                                         COMMAND                  CREATED        STATUS          PORTS                       NAMES
82cd6deabaa5   container-registry.oracle.com/mysql/community-server:latest   "/entrypoint.sh mysq…"   24 hours ago   Up 54 minutes   3306/tcp, 33060-33061/tcp   mysql-mgdw
docker stop 82cd6deabaa5
```

Run docker ps again to check the container is stopped.

## How to remove the containers

If you want to remove the containers after stopping them, you can use the docker rm command in a similar manner:

```bash
docker rm $(docker ps -a -q)
```
