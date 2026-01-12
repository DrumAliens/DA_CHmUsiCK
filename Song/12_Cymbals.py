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

if stopNum == 0:
    posVal = Library.pos2Dec([0,4,8,12])
    client.send_message("/song/drums/openhats", [0.15*playVolume*1.0, hatsRatio, maskArray[3]*posVal, maskArray[2]*posVal, maskArray[1]*posVal, maskArray[0]*posVal, numPhrase])

    posVal = Library.pos2Dec([1,5,9,13])
    client.send_message("/song/drums/closedhats", [0.15*1.5*playVolume*0.0, hatsRatio, maskArray[3]*posVal, maskArray[2]*posVal, maskArray[1]*posVal, maskArray[0]*posVal, numPhrase])

    posVal = Library.pos2Dec([14])
    client.send_message("/song/drums/splash", [0.05*1.5*playVolume, hatsRatio, 0, maskArray[2]*posVal, 0, maskArray[0]*posVal, numPhrase])
else:
    client.send_message("/song/drums/openhats", [stopNum])
    client.send_message("/song/drums/closedhats", [stopNum])
    client.send_message("/song/drums/splash", [stopNum])
