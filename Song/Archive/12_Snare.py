#!../.venv/bin/python
from typing import List, Any
from pythonosc.udp_client import SimpleUDPClient
from pythonosc.dispatcher import Dispatcher
from pythonosc.osc_server import BlockingOSCUDPServer
import sys
import Library

# Read in any command line variables
playPhrase, playVolume, numPhrase, maskArray, synchArray, delayPhrase, killNum  = Library.decodeInputArg(sys.argv)

ip = '127.0.0.1'
sendPort = 49162

# Set up server and client for testing
client = SimpleUDPClient(ip, sendPort)

vocalGain = 0.5
vocalRatio = 1.05

# ==== Send out 
if (delayPhrase > 0): 
    recPort = 49163 + delayPhrase

    dispatcher = Dispatcher()
    dispatcher.map("/song/master/phrase", Library.set_filter)  # Map wildcard address to set_filter function
    server = BlockingOSCUDPServer((ip, recPort), dispatcher)

    for i in range(delayPhrase): 
        server.handle_request()
    
posVal1 = Library.pos2Dec([4,12])
posVal2 = Library.pos2Dec([4,12,14])

if killNum == 0:
    client.send_message("/song/drums/snare", [0.35*playVolume, 1.0, maskArray[3]*posVal1, maskArray[2]*posVal2, maskArray[1]*posVal1, maskArray[0]*posVal2, numPhrase])
else:
    client.send_message("/song/drums/snare", [killNum])
