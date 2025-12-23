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
    
posVal = Library.pos2Dec([14])   
if stopNum == 0:
    client.send_message("/song/vocals/bassriff1", [0.5*playVolume, freqRatio, maskArray[3]*posVal, maskArray[2]*posVal, maskArray[1]*posVal, maskArray[0]*posVal, numPhrase])
else:
    client.send_message("/song/vocals/bassriff1", [stopNum])
