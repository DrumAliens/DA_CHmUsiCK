#!../.venv/bin/python
from typing import List, Any
from pythonosc.udp_client import SimpleUDPClient
from pythonosc.dispatcher import Dispatcher
from pythonosc.osc_server import ThreadingOSCUDPServer
import sys
import Library

# Read in any command line variables
playPhrase, playVolume, numPhrase, maskArray, timeArray, delayPhrase, stopNum, freqRatio  = Library.decodeInstrArg(sys.argv)

# Set up server and client for testing
client = SimpleUDPClient(Library.sendIp, Library.sendPort)

vocalRatio = 1.05

# if we define the number of bars we can then auto fill the OSC message to pack out the information
# Tweak the frequency of the hit hats
hatsRatio = 1.135716

# ==== Send out 
if (delayPhrase > 0): 

    dispatcher = Dispatcher()
    dispatcher.map("/song/internal/phrase", Library.set_filter)  # Map wildcard address to set_filter function

    # Find a free port
    for port in range(Library.replayPort, Library.replayPort + Library.replayPortNum):      
        try:
            server = ThreadingOSCUDPServer(('127.0.0.1', port), dispatcher)
        except:
            pass
        
    for i in range(delayPhrase): 
        server.handle_request()

posVal1 = Library.pos2Dec([4,12])
posVal2 = Library.pos2Dec([4])
if stopNum == 0:
    if (playPhrase == 1):
        client.send_message("/song/vocals/chop3", [0.155*playVolume, vocalRatio, maskArray[3]*posVal1, maskArray[2]*posVal1, maskArray[1]*posVal1, maskArray[0]*posVal1, numPhrase])
    else:
        client.send_message("/song/vocals/chop3", [0.155*playVolume, vocalRatio, maskArray[3]*posVal2, maskArray[2]*posVal2, maskArray[1]*posVal2, maskArray[0]*posVal2, numPhrase])
else:
    client.send_message("/song/vocals/chop3", [stopNum])
