# references
https://hub.docker.com/_/httpd
https://www.docker.com/blog/how-to-use-the-apache-httpd-docker-official-image/
https://octopus.com/blog/using-httpd-docker-image

# Home version
Server version: Apache/2.4.52 (Ubuntu)
# Set hostname on dev system for cert testing
sudo hostnamectl set-hostname reports-alb.busche-cnc.com 
sudo hostnamectl set-hostname moto.busche-cnc.com 
sudo hostnamectl set-hostname frt-kors43.busche-cnc.com 
sudo hostnamectl set-hostname devcon2.busche-cnc.com 
sudo nvim /etc/hosts
Add all FQDN found in Apache site files.
Apache virtual hosts still work if your hostname is not set with the same server name found in the ServerName directive in a sites file.

# create certs and key
go to [gen-and-install-certs](/home/brent/src/reports/volume/pki/gen-and-install-certs.md)

# Allow vscode to bind to ports under 1024
go to [unprivileged-access-to-ports-lte-1024](unprivileged-access-to-ports-lte-1024.md)

# Create a Dockerfile in your project
From https://octopus.com/blog/using-httpd-docker-image
pushd /home/brent/src/reports/.devcontainer/dockerfiles/httpd
mv Dockerfile-step1 Dockerfile
# cleanup docker objects
pushd /home/brent/src/reports/.devcontainer/dockerfiles/httpd
docker container ls -a
note: remove only httpd objects
docker container stop $(docker container ls -aq)
docker container rm $(docker container ls -aq) 
docker rmi $(docker images -q) -f
# build step1 image
docker build . -t myhttpd
# find an open port
sudo netstat -plunt |grep ":80"  
docker run -p 80:80 myhttpd
curl -L http://localhost/index.html
# cleanup step1
docker container ls -a
docker container rm $(docker container ls -aq) 
docker images
docker rmi $(docker images -q) -f

# update config files
go to [config-notes](conf/config-notes.md)


# test image 
go to [httpd-tests](httpd-tests.md.md)

# push to dockerhub
docker login
docker login --username=brentgroves --email=brent.groves@gmail.com
docker push brentgroves/httpd:2.4

# port notes 
https://containers.dev/implementors/json_reference/#general-properties
Use 'forwardPorts' to make a list of ports inside the container available locally.

An array of port numbers or "host:port" values (e.g. [3000, "db:5432"]) that should always be forwarded from inside the primary container to the local machine (including on the web). The property is most useful for forwarding ports that cannot be auto-forwarded because the related process that starts before the devcontainer.json supporting service / tool connects or for forwarding a service not in the primary container in Docker Compose scenarios (e.g. "db:5432"). Defaults to [].
https://github.com/microsoft/vscode-remote-release/issues/3025
