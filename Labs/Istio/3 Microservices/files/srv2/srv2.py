from flask import Flask
import socket
app = Flask(__name__)

@app.route('/')
@app.route('/srv2')
def srv():
    host_name = socket.gethostname() 
    host_ip = socket.gethostbyname(host_name) 
    return 'Service 2. IP: ' + host_ip + ' HostName: ' + host_name



if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')