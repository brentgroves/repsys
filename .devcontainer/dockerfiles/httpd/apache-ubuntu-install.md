https://github.com/FiloSottile/mkcert
mkcert does not support chrome now only firefox
# home
conda deactivate
openssl version                                                
OpenSSL 3.0.2 15 Mar 2022 (Library: OpenSSL 3.0.2 15 Mar 2022)

# Home version
Server version: Apache/2.4.52 (Ubuntu)
# Set hostname on dev system for cert testing
sudo hostnamectl set-hostname moto.busche-cnc.com 
sudo hostnamectl set-hostname frt-kors43.busche-cnc.com 
sudo hostnamectl set-hostname devcon2.busche-cnc.com 
sudo nvim /etc/hosts
Add all FQDN found in Apache site files.
Apache virtual hosts still work if your hostname is not set with the same server name found in the ServerName directive in a sites file.
# Ubuntu Install
https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-apache-in-ubuntu-22-04
Before starting this tutorial, you’ll need the following:
Access to a Ubuntu 22.04 server with a non-root, sudo-enabled user. Our Initial Server Setup with Ubuntu 22.04 guide can show you how to create this account.
You will also need to have Apache installed. You can install Apache using apt. First, update the local package index to reflect the latest upstream changes:
sudo apt update
Then, install the apache2 package:
sudo apt install apache2
And finally, if you have a ufw firewall set up, open up the http and https ports:
# i skipped this step
sudo ufw allow "Apache Full"
Step 1 — Enabling mod_ssl
Before you can use any TLS certificates, you’ll need to first enable mod_ssl, an Apache module that provides support for SSL encryption.
Enable mod_ssl with the a2enmod command:
sudo a2enmod ssl
See /usr/share/doc/apache2/README.Debian.gz on how to configure SSL and create self-signed certificates.
To activate the new configuration, you need to run:
systemctl restart apache2

# Restart Apache to activate the module:
sudo systemctl restart apache2

Now that Apache is ready to use encryption, we can move on to generating a new TLS certificate. The certificate will store some basic information about your site, and will be accompanied by a key file that allows the server to securely handle encrypted data.

We can create the TLS key and certificate files with the openssl command:

# create certs and key
go to [gen-and-install-certs](/home/brent/src/reports/volume/pki/gen-and-install-certs.md)
-or-
https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-apache-in-ubuntu-22-04

# create config for virtual host
Open a new file in the /etc/apache2/sites-available directory:
sudo nvim /etc/apache2/sites-available/moto.busche-cnc.com.conf
sudo nvim /etc/apache2/sites-available/frt-kors43.busche-cnc.com.conf

Home and moto at work system:
<VirtualHost moto.busche-cnc.com:443>
   ServerName moto.busche-cnc.com
   DocumentRoot /var/www/moto.busche-cnc.com

   SSLEngine on
   SSLCertificateFile /usr/local/apache2/conf/ssl.crt/moto.busche-cnc.com.san.cert.pem
   SSLCertificateChainFile /usr/local/apache2/conf/ssl.crt/ca-chain-bundle.cert.pem
   SSLCertificateKeyFile /usr/local/apache2/conf/ssl.key/moto.busche-cnc.com.san.key.pem
</VirtualHost>
<VirtualHost moto.busche-cnc.com:80>
	ServerName moto.busche-cnc.com
	Redirect / https://moto.busche-cnc.com/
</VirtualHost>
ls -al /usr/local/apache2/conf/ssl.crt/moto.busche-cnc.com.san.cert.pem
ls -al /usr/local/apache2/conf/ssl.crt/ca-chain-bundle.cert.pem
ls -al /usr/local/apache2/conf/ssl.key/moto.busche-cnc.com.san.key.pem

sudo nvim /etc/apache2/sites-available/devcon2.busche-cnc.com.conf
# devcon
<VirtualHost devcon2.busche-cnc.com:443>
   ServerName devcon2.busche-cnc.com
   DocumentRoot /var/www/devcon2.busche-cnc.com

   SSLEngine on
   SSLCertificateFile /usr/local/apache2/conf/ssl.crt/devcon2.busche-cnc.com.san.cert.pem
   SSLCertificateChainFile /usr/local/apache2/conf/ssl.crt/ca-chain-bundle.cert.pem
   SSLCertificateKeyFile /usr/local/apache2/conf/ssl.key/devcon2.busche-cnc.com.san.key.pem
</VirtualHost>
<VirtualHost devcon2.busche-cnc.com:80>
	ServerName devcon2.busche-cnc.com
	Redirect / https://devcon2.busche-cnc.com/
</VirtualHost>

# frt-kors43
<VirtualHost frt-kors43.busche-cnc.com:443>
   ServerName frt-kors43.busche-cnc.com
   DocumentRoot /var/www/frt-kors43.busche-cnc.com

   SSLEngine on
   SSLCertificateFile /usr/local/apache2/conf/ssl.crt/frt-kors43.busche-cnc.com.san.cert.pem
   SSLCertificateChainFile /usr/local/apache2/conf/ssl.crt/ca-chain-bundle.cert.pem
   SSLCertificateKeyFile /usr/local/apache2/conf/ssl.key/frt-kors43.busche-cnc.com.san.key.pem
</VirtualHost>
<VirtualHost frt-kors43.busche-cnc.com:80>
	ServerName frt-kors43.busche-cnc.com
	Redirect / https://frt-kors43.busche-cnc.com/
</VirtualHost>
- note
the following file has <VirtualHost *:80>
/etc/apache2/sites-available/000-default.conf
so if we want a specific config file to be used we can add <VirtualHost ip-address:80> to our site config.

# create document root
Now let’s create our DocumentRoot and put an HTML file in it just for testing purposes:
sudo mkdir /var/www/moto.busche-cnc.com

Open a new index.html file with your text editor:
sudo nvim /var/www/devcon2.busche-cnc.com/index.html
Paste the following into the blank file:
<html>
    <head>
        <title>Welcome to devcon2.busche-cnc.com!</title>
    </head>
    <body>
        <h1>Success!  The devcon2.busche-cnc.com virtual host is working!</h1>
    </body>
</html>

cat /var/www/moto.busche-cnc.com/index.html

# enable sites
Save and close the file Next, we need to enable the configuration file with the a2ensite tool:
sudo a2ensite 000-default.conf
sudo a2ensite moto.busche-cnc.com.conf
sudo a2ensite devcon2.busche-cnc.com.conf
sudo a2ensite frt-kors43.busche-cnc.com.conf

sudo ls /etc/apache2/sites-enabled                         
000-default.conf  moto.busche-cnc.com.conf

# update /etc/apache2/apache2.conf
This may not be necessary since eache site file has a ServerName directive
sudo nvim /etc/apache2/apache2.conf
ServerName moto.busche-cnc.com
# verify server name 
hostnamectl 
it's ok to not be the hostname your testing if /etc/hosts has an entry.
# verify ports.conf
# If you just change the port or add more ports here, you will likely also
# have to change the VirtualHost statement in
# /etc/apache2/sites-enabled/000-default.conf

Listen 80

<IfModule ssl_module>
	Listen 443
</IfModule>

<IfModule mod_gnutls.c>
	Listen 443
</IfModule>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet

# verify mods-enabled
sudo ls /etc/apache2/mods-enabled 
access_compat.load  auth_basic.load  authz_core.load  autoindex.conf  deflate.load  env.load	 mime.load	   negotiation.conf  php8.2.load      setenvif.conf	  ssl.conf     status.load
alias.conf	    authn_core.load  authz_host.load  autoindex.load  dir.conf	    filter.load  mpm_prefork.conf  negotiation.load  reqtimeout.conf  setenvif.load	  ssl.load
alias.load	    authn_file.load  authz_user.load  deflate.conf    dir.load	    mime.conf	 mpm_prefork.load  php8.2.conf	     reqtimeout.load  socache_shmcb.load  status.conf

# test config
Next, let’s test for configuration errors:
sudo apache2ctl configtest
If everything is successful, you will get a result that looks like this:
Output
AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 127.0.1.1. Set the 'ServerName' directive globally to suppress this message
Syntax OK
The first line is a message telling you that the ServerName directive is not set globally. If you want to get rid of that message, you can set ServerName to your server’s domain name or IP address in /etc/apache2/apache2.conf. This is optional as the message will do no harm.
- note CN has been obsoleted
If you include a fully-qualified domain name in the certificate, it must match the CN=common_name. The attribute name “CN” is case insensitive (it can be “CN”, “cn” or “Cn”), but the attribute value for the common name is case sensitive.
at work hostnamectl has:  Static hostname: moto.BUSCHE-CNC.com
but my certificate is CN in all lower case?

If your output has Syntax OK in it, your configuration file has no syntax errors. We can safely reload Apache to implement our changes:
# make sure you have added certs to all the trust stores by going to the gen-and-install-certs.md doc.

# start apache2
sudo systemctl status apache2
sudo systemctl start apache2
sudo systemctl reload apache2
# look at log
https://www.itsolutionstuff.com/post/how-to-check-apache-access-error-log-files-in-ubuntu-serverexample.html
cat /var/log/apache2/error.log

# check ports
sudo netstat -plunt |grep ":80"  
tcp6       0      0 :::80                   :::*                    LISTEN      903134/apache2  
sudo netstat -plunt |grep ":443"  
tcp6       0      0 :::443                  :::*                    LISTEN      903134/apache2

# moto at home
# deactivate an environment
conda deactivate
Now the openssl that comes with ubuntu is used
openssl version
OpenSSL 3.0.2 15 Mar 2022 (Library: OpenSSL 3.0.2 15 Mar 2022)
curl -L http://moto.busche-cnc.com
curl -L http://devcon2.busche-cnc.com
curl -L https://devcon2.busche-cnc.com
curl -L https://frt-kors43.busche-cnc.com

# enable environment called "base", the default env from conda
# conda activate base

# dont need to do this unless conda environment is being used
because it has openssl stored in a different location.
/home/brent/src/reports/volume/pki/intermediateCA/certs/ca-chain
curl -H 'Cache-Control: no-cache' localhost 
ok
curl --cacert ca-chain-bundle.cert.pem https://moto.busche-cnc.com
To follow redirect with Curl, use the -L or --location command-line option.
curl -L --cacert ca-chain-bundle.cert.pem http://moto.busche-cnc.com
https://manpages.ubuntu.com/manpages/lunar/en/man8/update-ca-certificates.8.html
https://serverfault.com/questions/485597/default-ca-cert-bundle-location
Running curl with strace might give you a clue.
strace curl https://moto.busche-cnc.com |& grep open
openssl s_client -connect foo.whatever.com:443 -CApath /etc/ssl/certs
curl -L http://moto.busche-cnc.com # This does not work exits with a verification error



# check from local chrome
https://devcon2.busche-cnc.com
Success! The your_domain virtual host is working!
# check redirect from http to https
http://devcon2.busche-cnc.com
Redirect worked
# check from remote chrome
https://devcon2.busche-cnc.com
Success! The your_domain virtual host is working!

# references
From https://octopus.com/blog/using-httpd-docker-image
# https://hub.docker.com/_/httpd?tab=description
# https://www.docker.com/blog/how-to-use-the-apache-httpd-docker-official-image/
# https://www.digitalocean.com/community/tutorials/how-to-install-the-apache-web-server-on-ubuntu-22-04#step-5-setting-up-virtual-hosts-recommended
https://www.digitalocean.com/community/tutorials/how-to-install-the-apache-web-server-on-ubuntu-22-04

docker run -d --name apache2-container -e TZ=UTC -p 8080:80 ubuntu/apache2:2.4-22.04_beta

docker run -p 80:80  -e TZ=UTC myhttpd

