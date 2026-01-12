#!../.venv/bin/python
from typing import List, Any
from pythonosc.udp_client import SimpleUDPClient
from pythonosc.dispatcher import Dispatcher
from pythonosc.osc_server import ThreadingOSCUDPServer
import sys
import Library

# Read in any command line variables
playPhrase, playVolume, numPhrase, maskArray, timeArray, delayPhrase, stopNum, freqRatio = Library.decodeInstrArg(sys.argv)

# Set up server and client for testing
client = SimpleUDPClient(Library.sendIp, Library.sendPort)

sawGain = 0.00075*0.65

# ==== Send out 
posVal1 = 65535 - timeArray[3]*Library.pos2Dec([2,5,9,10,11,14,15]);
posVal2 = 65535 - timeArray[2]*Library.pos2Dec([2,5,9,10,11]);
posVal3 = 65535 - timeArray[1]*Library.pos2Dec([2,5,9,10,11,14,15]);
posVal4 = 65535 - timeArray[0]*Library.pos2Dec([2,5,9,10,11]);

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

octave = 12

if stopNum == 0:
    if (playPhrase == 1):
        # Same notes all way through
        client.send_message("/song/synth/saw0", [playVolume*sawGain, 40, maskArray[3]*posVal1, 40, maskArray[2]*posVal2, 40, maskArray[1]*posVal3, 40, maskArray[0]*posVal4, numPhrase])
        client.send_message("/song/synth/saw1", [playVolume*sawGain, 43+octave, maskArray[3]*posVal1, 42+octave, maskArray[2]*posVal2, 40+octave, maskArray[1]*posVal3, 40+octave, maskArray[0]*posVal4, numPhrase])
        client.send_message("/song/synth/saw2", [playVolume*sawGain, 50+octave, maskArray[3]*posVal1, 49+octave, maskArray[2]*posVal2, 47+octave, maskArray[1]*posVal3, 47+octave, maskArray[0]*posVal4, numPhrase])
        client.send_message("/song/synth/saw3", [playVolume*sawGain, 55+octave, maskArray[3]*posVal1, 54+octave, maskArray[2]*posVal2, 52+octave, maskArray[1]*posVal3, 52+octave, maskArray[0]*posVal4, numPhrase])
    else:
        client.send_message("/song/synth/saw0", [playVolume*sawGain, 40, maskArray[3]*posVal1, 40, maskArray[2]*posVal2, 40, maskArray[1]*posVal3, 40, maskArray[0]*posVal4, numPhrase])
        client.send_message("/song/synth/saw1", [playVolume*sawGain, 40+octave, maskArray[3]*posVal1, 40+octave, maskArray[2]*posVal2, 40+octave, maskArray[1]*posVal3, 40+octave, maskArray[0]*posVal4, numPhrase])
        client.send_message("/song/synth/saw2", [playVolume*sawGain, 47+octave, maskArray[3]*posVal1, 47+octave, maskArray[2]*posVal2, 47+octave, maskArray[1]*posVal3, 47+octave, maskArray[0]*posVal4, numPhrase])
        client.send_message("/song/synth/saw3", [playVolume*sawGain, 52+octave, maskArray[3]*posVal1, 52+octave, maskArray[2]*posVal2, 52+octave, maskArray[1]*posVal3, 52+octave, maskArray[0]*posVal4, numPhrase])
else:
    client.send_message("/song/synth/saw0", [stopNum])
    client.send_message("/song/synth/saw1", [stopNum])
    client.send_message("/song/synth/saw2", [stopNum])
    client.send_message("/song/synth/saw3", [stopNum])




# Original set of chords
    # client.send_message("/song/synth/saw0", [sawGain, 44, posVal1, 41, posVal2, 43, posVal3, 36, posVal4, numPhrase])
    # client.send_message("/song/synth/saw1", [sawGain, 56, posVal1, 55, posVal2, 58, posVal3, 56, posVal4, numPhrase])
    # client.send_message("/song/synth/saw2", [sawGain, 60, posVal1, 60, posVal2, 62, posVal3, 60, posVal4, numPhrase])
    # client.send_message("/song/synth/saw3", [sawGain, 63, posVal1, 63, posVal2, 65, posVal3, 64, posVal4, numPhrase])

