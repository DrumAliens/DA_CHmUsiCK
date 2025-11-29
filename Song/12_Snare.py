#!../.venv/bin/python
from typing import List, Any
from pythonosc.udp_client import SimpleUDPClient
from pythonosc.dispatcher import Dispatcher
from pythonosc.osc_server import ThreadingOSCUDPServer
import sys
import Library

# Read in any command line variables
playPhrase, playVolume, numPhrase, maskArray, timeArray, delayPhrase, stopNum, freqRatio  = Library.decodeInputArg(sys.argv)

# Setup the OSC port and IP
sendIp = Library.sendIp
sendPort = 49162
# LEAVE THIS ONE ALONE
recIp = '127.0.0.1'
recPort = Library.replayPort + delayPhrase

# Set up server and client for testing
client = SimpleUDPClient(sendIp, sendPort)

vocalGain = 0.5
vocalRatio = 1.05

# ==== Send out 
if (delayPhrase > 0): 

    dispatcher = Dispatcher()
    dispatcher.map("/song/internal/phrase", Library.set_filter)  # Map wildcard address to set_filter function
    server = ThreadingOSCUDPServer((recIp, recPort), dispatcher)

    for i in range(delayPhrase): 
        server.handle_request()
    
posVal1 = Library.pos2Dec([4,12])
posVal2 = Library.pos2Dec([4,12,14])

if stopNum == 0:
    client.send_message("/song/drums/snare", [0.35*playVolume, 1.0, maskArray[3]*posVal1, maskArray[2]*posVal2, maskArray[1]*posVal1, maskArray[0]*posVal2, numPhrase])
else:
    client.send_message("/song/drums/snare", [stopNum])
