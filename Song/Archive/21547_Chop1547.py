#!../.venv/bin/python
from typing import List, Any
from pythonosc.udp_client import SimpleUDPClient
import sys
import Library

# Read in any command line variables
playPhrase, playVolume, numPhrase, maskArray, synchArray  = Library.decodeInputArg(sys.argv)
        
# Setup the OSC port and IP
ip = '127.0.0.1'
sendPort = 49162
recPort = 49163

# Set up server and client for testing
client = SimpleUDPClient(ip, sendPort)

vocalGain = 0.5*playVolume
vocalRatio = 1.05

# ==== Send out 
posVal1 = Library.pos2Dec([0])
posVal5 = Library.pos2Dec([2])
if (playPhrase == 1): 
    client.send_message("/song/vocals/chop1", [0])
    client.send_message("/song/vocals/chop5", [0])
elif (playPhrase == 2):
    client.send_message("/song/vocals/chop1", [vocalGain, vocalRatio, 0, 0, posVal1, 0, numPhrase])
    client.send_message("/song/vocals/chop5", [vocalGain, vocalRatio, 0, 0, posVal5, 0, numPhrase])
elif (playPhrase == 3):   
    client.send_message("/song/vocals/chop1", [vocalGain, vocalRatio, 0, 0, posVal1, posVal1, numPhrase])
    client.send_message("/song/vocals/chop5", [vocalGain, vocalRatio, 0, 0, posVal5, posVal5, numPhrase])
elif (playPhrase == 4):
    client.send_message("/song/vocals/chop1", [vocalGain, vocalRatio, posVal1, 0, posVal1, 0, numPhrase])
    client.send_message("/song/vocals/chop5", [vocalGain, vocalRatio, posVal5, 0, posVal5, 0, numPhrase])
else:
    client.send_message("/song/vocals/chop1", [numPhrase])
    client.send_message("/song/vocals/chop5", [numPhrase])

posVal4 = Library.pos2Dec([9])
posVal7 = Library.pos2Dec([14])
if (playPhrase == 1):
    client.send_message("/song/vocals/chop4", [0.5*vocalGain, vocalRatio, posVal4, posVal4, 0, 0, numPhrase])
    client.send_message("/song/vocals/chop7", [0.5*vocalGain, vocalRatio, posVal7, 0, 0, 0, numPhrase])
elif (playPhrase == 2):
    client.send_message("/song/vocals/chop4", [0.5*vocalGain, vocalRatio, posVal4, posVal4, 0, 0, numPhrase])
    client.send_message("/song/vocals/chop7", [0.5*vocalGain, vocalRatio, posVal7, 0, 0, 0, numPhrase])
elif (playPhrase == 3):
    client.send_message("/song/vocals/chop4", [0.5*vocalGain, vocalRatio, posVal4, posVal4, 0, 0, numPhrase])
    client.send_message("/song/vocals/chop7", [0.5*vocalGain, vocalRatio, posVal7, 0, 0, 0, numPhrase])
elif (playPhrase == 4):
    client.send_message("/song/vocals/chop4", [0.5*vocalGain, vocalRatio, posVal4, posVal4, posVal4, posVal4, numPhrase])
    client.send_message("/song/vocals/chop7", [0.5*vocalGain, vocalRatio, posVal7, 0, posVal7, 0, numPhrase])
else:
    client.send_message("/song/vocals/chop4", [playPhrase])
    client.send_message("/song/vocals/chop7", [playPhrase])

#    server.handle_request()
