from flask import Flask, abort
import socket
import json

app = Flask(__name__)


@app.route('/')
def hello():
    host_name = socket.gethostname() 
    host_ip = socket.gethostbyname(host_name) 
    text = 'Hello from: {0} On: {1}'.format(host_name, host_ip)
    return text

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')