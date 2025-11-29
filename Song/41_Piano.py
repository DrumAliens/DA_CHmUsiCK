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

# ==== Send out 
if (delayPhrase > 0): 

    dispatcher = Dispatcher()
    dispatcher.map("/song/internal/phrase", Library.set_filter)  # Map wildcard address to set_filter function
    server = ThreadingOSCUDPServer((recIp, recPort), dispatcher)

    for i in range(delayPhrase): 
        server.handle_request()

posVal = Library.pos2Dec([0, 8, 12, 14]);
e4 = 0.749145455
e5 = 1.4982727
#client.send_message("/synth/piano", [0.2, 164.81/110.0, posVal, posVal, posVal, posVal, numPhrase])
if stopNum == 0:
    client.send_message("/song/synth/piano", [0.22*0.35*playVolume, 0.99 * freqRatio, maskArray[3]*posVal, maskArray[2]*posVal, maskArray[1]*posVal, maskArray[0]*posVal, numPhrase])
else:
    client.send_message("/song/synth/piano", [stopNum])

