#!/usr/bin/env python

import configparser
import json
import socket
from datetime import datetime
from elasticsearch import Elasticsearch
import paho.mqtt.client as mqtt

config = configparser.ConfigParser()
config.read("config.ini")

mqttServer = config['ttn']['server']
mqttPort = int(config['ttn']['port'])

ttnes_hostname = socket.gethostname()

channelSubs="%s/#" % config['ttn']['app_id']


# The callback for when the client receives a CONNACK response from the server.
def on_connect(client, userdata, flags, rc):
    # Subscribing in on_connect() means that if we lose the connection and
    # reconnect then subscriptions will be renewed.
    client.subscribe(channelSubs)

# The callback for when a PUBLISH message is received from the server.
def on_message(client, userdata, msg):
    try:
        ds = {}
        pl = json.loads(msg.payload)
        for field in pl['payload_fields']:
            ds[field] = pl['payload_fields'][field]
        ds['port'] = pl['port']
        ds['app_id'] = pl['app_id']
        ds['dev_id'] = pl['dev_id']
        ds['message_created'] = pl['metadata']['time']
        ds['topic'] = msg.topic
        ds['timestamp'] = datetime.utcnow()
        ds['ttn2es_relay'] = ttnes_hostname
        print(ds)
        es.index(index="ttnp25", doc_type="string", body=ds)
    except:
        pass

if config['elasticsearch']['port'] == "":
    es_svr = config['elasticsearch']['server']
else:
    es_svr = "%s:%s" % (
        config['elasticsearch']['server'],
        config['elasticsearch']['port']
        )

es = Elasticsearch(es_svr)

client = mqtt.Client()
client.username_pw_set(
        config['ttn']['app_id'],
        password=config['ttn']['password']
        )
client.on_connect = on_connect
client.on_message = on_message
client.connect(mqttServer,mqttPort, 60)

# Blocking call that processes network traffic, dispatches callbacks and
# handles reconnecting.
# Other loop*() functions are available that give a threaded interface and a
# manual interface.
client.loop_forever()

