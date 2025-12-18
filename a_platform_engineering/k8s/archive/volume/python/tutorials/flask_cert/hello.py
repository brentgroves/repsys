from flask import Flask
app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello World!"

if __name__ == "__main__":
    app.run()
    # app.run(ssl_context=('frt_kors43_certificate.pem', 'frt_kors43_private_key.pem'))
 