#!../.venv/bin/python
from typing import List, Any
from pythonosc.udp_client import SimpleUDPClient
from pythonosc.dispatcher import Dispatcher
from pythonosc.osc_server import ThreadingOSCUDPServer
import sys
import Library

# Read in any command line variables
playPhrase, playVolume, numPhrase, maskArray, timeArray, delayPhrase, stopNum, freqRatio = Library.decodeInputArg(sys.argv)

# Setup the OSC port and IP
ip = '127.0.0.1'
sendPort = 49162
recPort = 49163 + delayPhrase

# Set up server and client for testing
client = SimpleUDPClient(ip, sendPort)

sawGain = 0.5

# ==== Send out 
posVal1 = 65535 - timeArray[3]*Library.pos2Dec([2,5,9,10,11,14,15]);
posVal2 = 65535 - timeArray[2]*Library.pos2Dec([2,5,9,10,11]);
posVal3 = 65535 - timeArray[1]*Library.pos2Dec([2,5,9,10,11,14,15]);
posVal4 = 65535 - timeArray[0]*Library.pos2Dec([2,5,9,10,11]);

if (delayPhrase > 0): 
 
    dispatcher = Dispatcher()
    dispatcher.map("/song/master/phrase", Library.set_filter)  # Map wildcard address to set_filter function
    server = ThreadingOSCUDPServer((ip, recPort), dispatcher)

    for i in range(delayPhrase): 
        server.handle_request()

if stopNum == 0:
    if playPhrase == 1:
        client.send_message("/song/synth/saw0", [playVolume*sawGain, 40, maskArray[3]*posVal1, 40, maskArray[2]*posVal2, 40, maskArray[1]*posVal3, 40, maskArray[0]*posVal4, numPhrase])
        client.send_message("/song/synth/saw1", [playVolume*sawGain, 55, maskArray[3]*posVal1, 52, maskArray[2]*posVal2, 50, maskArray[1]*posVal3, 47, maskArray[0]*posVal4, numPhrase])
        client.send_message("/song/synth/saw2", [playVolume*sawGain, 62, maskArray[3]*posVal1, 59, maskArray[2]*posVal2, 57, maskArray[1]*posVal3, 54, maskArray[0]*posVal4, numPhrase])
        client.send_message("/song/synth/saw3", [playVolume*sawGain, 67, maskArray[3]*posVal1, 64, maskArray[2]*posVal2, 62, maskArray[1]*posVal3, 59, maskArray[0]*posVal4, numPhrase])
    else:
        client.send_message("/song/synth/saw0", [playVolume*sawGain, 40, maskArray[3]*posVal1, 40, maskArray[2]*posVal2, 40, maskArray[1]*posVal3, 40, maskArray[0]*posVal4, numPhrase])
        client.send_message("/song/synth/saw1", [playVolume*sawGain, 48, maskArray[3]*posVal1, 48, maskArray[2]*posVal2, 52, maskArray[1]*posVal3, 52, maskArray[0]*posVal4, numPhrase])
        client.send_message("/song/synth/saw2", [playVolume*sawGain, 55, maskArray[3]*posVal1, 55, maskArray[2]*posVal2, 59, maskArray[1]*posVal3, 59, maskArray[0]*posVal4, numPhrase])
        client.send_message("/song/synth/saw3", [playVolume*sawGain, 60, maskArray[3]*posVal1, 60, maskArray[2]*posVal2, 64, maskArray[1]*posVal3, 64, maskArray[0]*posVal4, numPhrase])

else:
    client.send_message("/song/synth/saw0", [stopNum])
    client.send_message("/song/synth/saw1", [stopNum])
    client.send_message("/song/synth/saw2", [stopNum])
    client.send_message("/song/synth/saw3", [stopNum])
