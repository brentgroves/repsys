docker run -d --rm -p 8000:80 -p 8443:443 --name httpd-test brentgroves/httpd:1.0
docker run -d --rm -p 80:80 --name httpd-test brentgroves/httpd:1.0

docker run -d --name httpd-test -p 8080:80 brentgroves/httpd:1.0
docker run -d --name httpd-test -p 80:80 brentgroves/httpd:1.0
docker run -dit --name httpd-test -p 80:80 brentgroves/httpd:1.0
# is http connection from httpd container working?
docker exec -ti reports_devcontainer-httpd-1 sh
docker exec -ti httpd-test sh

curl -v http://localhost

# is http connection from dev container working?
curl -v http://localhost


# is http connection from the development host working?
brent@devcon2 >curl -v http://localhost

# is http connection from a remote host working?
brent@moto >curl -v http://localhost


