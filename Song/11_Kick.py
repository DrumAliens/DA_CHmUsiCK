#!../.venv/bin/python
from typing import List, Any
from pythonosc.udp_client import SimpleUDPClient
from pythonosc.dispatcher import Dispatcher
from pythonosc.osc_server import ThreadingOSCUDPServer
import sys
import Library

def handler(address, *args):
    print(f"Received from {address}: {args}")

dispatcher = Dispatcher()
dispatcher.map("/data", handler)

# Read in any command line variables
playPhrase, playVolume, numPhrase, maskArray, timeArray, delayPhrase, stopNum, freqRatio  = Library.decodeInputArg(sys.argv)

ip = '127.0.0.1'
sendPort = 49162
recPort = 49163 + delayPhrase

# Set up server and client for testing
client = SimpleUDPClient(ip, sendPort)

vocalGain = 0.5
vocalRatio = 1.05

# ==== Send out 
if (delayPhrase > 0): 

    dispatcher = Dispatcher()
    dispatcher.map("/song/master/phrase", Library.set_filter)  # Map wildcard address to set_filter function
    server = ThreadingOSCUDPServer((ip, recPort), dispatcher)

    for i in range(delayPhrase): 
        server.handle_request()

if (maskArray[0]*maskArray[1]*maskArray[2]*maskArray[3] > 0):
    posVal = Library.pos2Dec([0,3,6,11,15])
else:
    posVal = Library.pos2Dec([0,3,6])

if stopNum == 0:
    client.send_message("/song/drums/kick", [0.3*playVolume, 1.0, maskArray[3]*posVal, maskArray[2]*posVal, maskArray[1]*posVal, maskArray[0]*posVal, numPhrase])
else:
    client.send_message("/song/drums/kick", [stopNum])


