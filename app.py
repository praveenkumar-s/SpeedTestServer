import sys
import json
import subprocess
from flask import Flask, jsonify
app = Flask(__name__)

@app.route('/get_speed')
def speed_get():
    divide_by=125000
    data_dummy={
        "upload":"N/A",
        "download":"NA"
    }

    try:
        output = subprocess.check_output(["speedtest",'-f','json'])
        output= output.decode('utf-8')
        output_js = json.loads(output)
        up= str(output_js['upload']['bandwidth']/divide_by)+' Mbps'
        down = str(output_js['download']['bandwidth']/divide_by)+' Mbps'
        data_dummy['upload']=up
        data_dummy['download']=down
        return jsonify(data_dummy)
    except:        
        print("Error Occured "+ str(sys.exc_info()))
    return jsonify(data_dummy)

if __name__ == '__main__':
    app.run(port=8080)
