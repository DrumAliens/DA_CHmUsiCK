#!../.venv/bin/python
from typing import List, Any
from pythonosc.udp_client import SimpleUDPClient
from pythonosc.dispatcher import Dispatcher
from pythonosc.osc_server import ThreadingOSCUDPServer
import sys
import Library

# Read in any command line variables
playPhrase, playVolume, numPhrase, maskArray, timeArray, delayPhrase, stopNum, freqRatio  = Library.decodeInputArg(sys.argv)

sendIp = Library.sendIp
sendPort = 49162
recIp = '127.0.0.1'
recPort = 49163 + delayPhrase

# Set up server and client for testing
client = SimpleUDPClient(sendIp, sendPort)

# ==== Send out 
if (delayPhrase > 0): 


    dispatcher = Dispatcher()
    dispatcher.map("/song/master/phrase", Library.set_filter)  # Map wildcard address to set_filter function
    server = ThreadingOSCUDPServer((recIp, recPort), dispatcher)

    for i in range(delayPhrase): 
        server.handle_request()
    
if stopNum == 0:
    client.send_message("/song/vocals/dogpack", [0.5*playVolume, freqRatio, 1, 0, 0, 0, 1])
else:
    client.send_message("/song/vocals/dogpack", [stopNum])
