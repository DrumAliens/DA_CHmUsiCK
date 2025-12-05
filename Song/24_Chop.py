#!../.venv/bin/python
from typing import List, Any
from pythonosc.udp_client import SimpleUDPClient
from pythonosc.dispatcher import Dispatcher
from pythonosc.osc_server import ThreadingOSCUDPServer
import sys
import Library

# Read in any command line variables
playPhrase, playVolume, numPhrase, maskArray, timeArray, delayPhrase, stopNum, freqRatio = Library.decodeInstrArg(sys.argv)

# Setup the OSC port and IP
sendIp = Library.sendIp
sendPort = 49162
# LEAVE THIS ONE ALONE
recIp = '127.0.0.1'
recPort = Library.replayPort + delayPhrase

# Set up server and client for testing
client = SimpleUDPClient(sendIp, sendPort)

vocalGain = 0.5*playVolume
vocalRatio = 1.06

# if we define the number of bars we can then auto fill the OSC message to pack out the information
# Tweak the frequency of the hit hats
hatsRatio = 1.135716

# ==== Send out 
if (delayPhrase > 0): 

    dispatcher = Dispatcher()
    dispatcher.map("/song/internal/phrase", Library.set_filter)  # Map wildcard address to set_filter function
    server = ThreadingOSCUDPServer((recIp, recPort), dispatcher)

    for i in range(delayPhrase): 
        server.handle_request()

posVal4 = Library.pos2Dec([9])
if stopNum == 0:
    client.send_message("/song/vocals/chop4", [0.5*vocalGain, vocalRatio*freqRatio, maskArray[3]*posVal4, maskArray[2]*posVal4, maskArray[1]*posVal4, maskArray[0]*posVal4, numPhrase])
else:
    client.send_message("/song/vocals/chop4", [stopNum])

