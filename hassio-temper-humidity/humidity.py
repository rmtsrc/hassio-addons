import datetime
import logging
import requests
import json

from temperusb.temper import TemperHandler

humidity_pc = round(TemperHandler().get_devices()[0].get_humidity()[0]['humidity_pc'], 2)

print(datetime.datetime.now())
print("Got humidity {}".format(humidity_pc))

optionsFile = open('/data/options.json')
options = json.load(optionsFile)
optionsFile.close()

response = requests.post("http://127.0.0.1:8123/api/webhook/{}".format(options['webHookId']), json={'humidity': humidity_pc})

print("http {} {}".format(response.status_code, response.reason))
