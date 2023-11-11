# flask_cert
Once you allow the browser to connect, you will have an encrypted connection, just like what you get from a server with a valid certificate, which make these ad hoc certificates convenient for quick & dirty tests, but not for any real use.
https://blog.miguelgrinberg.com/post/running-your-flask-application-over-https

# hello.py
from flask import Flask
app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello World!"

if __name__ == "__main__":
    app.run(ssl_context=('cert.pem', 'key.pem'))


$ sudo cp CA_certificate.crt /usr/local/share/ca-certificates
$ sudo update-ca-certificates
Updating certificates in /etc/ssl/certs...
rehash: warning: skipping ca-certificates.crt,it does not contain exactly one certificate or CRL
1 added, 0 removed; done.
Running hooks in /etc/ca-certificates/update.d...

Adding debian:CA_certificate.pem
done.
done.


Using Production Web Servers
Of course we all know that the Flask development server is only good for development and testing. So how do we install an SSL certificate on a production server?

If you are using gunicorn, you can do this with command line arguments:

$ gunicorn --certfile frt_kors43_certificate.crt --keyfile frt_kors43_private_key.pem -b 0.0.0.0:8000 hello:app

After this point you can use Ubuntu’s tools like curl and wget to connect to local sites.
curl --verbose https://frt-kors43.busche-cnc.com
curl --verbose https://frt-kors43.busche-cnc.com


# run flask
Alternatively, you can add the --cert and --key options to the flask run command if you are using Flask 1.x or newer:

$ flask run --cert=frt_kors43_certificate.pem --key=frt_kors43_private_key.pem