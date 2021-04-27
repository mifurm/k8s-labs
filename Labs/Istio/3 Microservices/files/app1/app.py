from flask import Flask
import os
import requests
import socket
import json

app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello World'

@app.route('/app1')
def app1():
    service1 = "http://"+os.environ['service1']+":5000"
    service2 = "http://"+os.environ['service2']+":5000"
    host_name = socket.gethostname() 
    host_ip = socket.gethostbyname(host_name) 
    r1 = requests.get(service1)
    r2 = requests.get(service2)
    data = {}
    data['app'] = "Application"
    data['host_ip'] = host_ip
    data['host_name'] = host_name
    data['responses'] = {}
    data['responses']['service_1'] = r1.text
    data['responses']['service_2'] = r2.text
    return json.dumps(data)


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')