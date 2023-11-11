# How to retrieve any file from the original image
docker run --rm httpd:2.4 cat /usr/local/apache2/conf/extra/httpd-vhosts.conf > httpd-vhosts.conf

# Advanced configuration - step 2
From https://octopus.com/blog/using-httpd-docker-image#advanced-httpd-configuration

The standard configuration file embedded in the HTTPd image is extracted with the following command:
docker run --rm httpd:2.4 cat /usr/local/apache2/conf/httpd.conf > my-httpd.conf

To have HTTPd load additional configuration files, you add a single directive to the end of this file, which instructs HTTPd to load files in the specified directory:

# Add sites to my-httpd.con
IncludeOptional conf/sites/*.conf

# Add Health Check
Create a file called health-check.conf with the following contents. This configuration enables HTTPd to listen on port 90 and respond to requests on the /health path with a 200 OK response. This response simulates a health check of the web server that clients can use to determine if the server is up and running:

The DockerFile is then updated to create the directory /usr/local/apache2/conf/sites/, copy the health-check.conf file to the directory, and overwrite the original configuration file with our copy that includes the IncludeOptional directive:

# build step-2
pushd /home/brent/src/reports/.devcontainer/dockerfiles/httpd
cp Dockerfile-step2 Dockerfile
docker build . -t myhttpd
# find an open port
sudo netstat -plunt |grep ":80"  
sudo netstat -plunt |grep ":90"  

Run the Docker image with the command. Note that you expose a new port to provide access to the health check endpoint:

docker run -p 80:80 -p 90:90 myhttpd
curl -L http://localhost:90/health

curl -L http://localhost/index.html
# cleanup step2
docker container ls -a
docker container rm $(docker container ls -aq) 
docker images
docker rmi $(docker images -q) -f

# Add SSL - step 3
SSL/HTTPS
If you want to run your web traffic over SSL, the simplest setup is to COPY or mount (-v) your server.crt and server.key into /usr/local/apache2/conf/ and then customize the /usr/local/apache2/conf/httpd.conf by removing the comment symbol from the following lines:

...
#LoadModule socache_shmcb_module modules/mod_socache_shmcb.so
...
#LoadModule ssl_module modules/mod_ssl.so
...
#Include conf/extra/httpd-ssl.conf
...
The conf/extra/httpd-ssl.conf configuration file will use the certificate files previously added and tell the daemon to also listen on port 443. Be sure to also add something like -p 443:443 to your docker run to forward the https port.

sed -i \
		-e 's/^#\(Include .*httpd-ssl.conf\)/\1/' \
		-e 's/^#\(LoadModule .*mod_ssl.so\)/\1/' \
		-e 's/^#\(LoadModule .*mod_socache_shmcb.so\)/\1/' \
		./conf/httpd.conf

# build step-3
pushd /home/brent/src/reports/.devcontainer/dockerfiles/httpd
mv my-httpd-ssl.conf my-httpd.conf
cp Dockerfile-step3 Dockerfile
docker build . -t myhttpd
docker build . -t brentgroves/httpd:2.4

# find an open port
sudo netstat -plunt |grep ":80"  
sudo netstat -plunt |grep ":90"  
sudo netstat -plunt |grep ":443"  
Run the Docker image with the command. Note that you expose a new port to provide access to the health check endpoint:

docker run -p 80:80 -p 90:90 -p 443:443 myhttpd
docker run -p 80:80 -p 90:90 -p 443:443 brentgroves/httpd:2.4

conda deactivate
curl -L http://localhost:90/health

curl -L http://localhost/index.html
curl -L https://moto.busche-cnc.com/index.html
# cleanup step3
docker container ls -a
docker container rm $(docker container ls -aq) 
docker images
docker rmi $(docker images -q) -f

# Add directory structure in dockerfile - step 4
pushd /home/brent/src/reports/.devcontainer/dockerfiles/httpd
docker build --no-cache . -t myhttpd


docker run --rm myhttpd cat /usr/local/apache2/docs/reports-alb.busche-cnc.com/index.html > moto.index.html
docker run --rm myhttpd cat /usr/local/apache2/htdocs/index.html

docker run --rm myhttpd ls /usr/local/apache2/conf/ssl.crt
docker run --rm myhttpd ls /usr/local/apache2/conf/ssl.key
docker run --rm myhttpd cat /etc/apache2/apache2.conf

# find an open port
sudo netstat -plunt |grep ":80"  
sudo netstat -plunt |grep ":90"  
sudo netstat -plunt |grep ":443" 

Run the Docker image with the command. Note that you expose a new port to provide access to the health check endpoint:

docker run -p 80:80 -p 90:90 -p 443:443 myhttpd
conda deactivate
curl -L http://localhost:90/health

curl -L http://localhost/
# test https
curl -L https://moto.busche-cnc.com/
curl -L https://reports-alb.busche-cnc.com/
# test redirect
curl -L http://moto.busche-cnc.com/
curl -L http://reports-alb.busche-cnc.com/

# cleanup step4
docker container ls -a
docker container rm $(docker container ls -aq) 
docker images
docker rmi $(docker images -q) -f

docker run --rm myhttpd ls /etc/apache2/mods-enabled 
docker run --rm myhttpd tree /etc/apache2/sites-available/
docker run --rm myhttpd tree /etc/apache2/sites-enabled/
docker run --rm myhttpd cat /etc/apache2/sites-enabled/moto.busche-cnc.com.conf
docker run --rm myhttpd cat /etc/hosts
docker run --rm myhttpd tree /var/www/
docker run --rm myhttpd tree /usr/local/apache2/conf/ssl.crt/
docker run --rm myhttpd tree /usr/local/apache2/conf/ssl.key/
docker run --rm myhttpd apache2ctl configtest
docker run --rm myhttpd openssl version
docker run --rm myhttpd cat /var/log/apache2/error.log
docker run --rm myhttpd cat /etc/apache2/sites-available/default-ssl.conf >> default-ssl.conf

docker run --rm myhttpd cat /etc/apache2/sites-available/000-default.conf >> 000-default.conf

docker run --rm myhttpd cat /usr/local/apache2/conf/extra/httpd-ssl.conf

docker run --rm myhttpd tree /usr/local/apache2/docs/