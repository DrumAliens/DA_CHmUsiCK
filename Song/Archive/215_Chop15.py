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

vocalGain = 0.5
vocalRatio = 1.05

# ==== Send out 
posVal1 = Library.pos2Dec([0])
posVal5 = Library.pos2Dec([2])
if (playPhrase == 1): 
    client.send_message("/song/vocals/chop1", [vocalGain*playVolume, vocalRatio, 0, 0, posVal1, 0, numPhrase])
    client.send_message("/song/vocals/chop5", [vocalGain*playVolume, vocalRatio, 0, 0, posVal5, 0, numPhrase])
elif (playPhrase == 2):
    client.send_message("/song/vocals/chop1", [vocalGain*playVolume, vocalRatio, 0, 0, posVal1, posVal1, numPhrase])
    client.send_message("/song/vocals/chop5", [vocalGain*playVolume, vocalRatio, 0, 0, posVal5, posVal5, numPhrase])
elif (playPhrase == 3):   
    client.send_message("/song/vocals/chop1", [vocalGain*playVolume, vocalRatio, 0, posVal1, posVal1, posVal1, numPhrase])
    client.send_message("/song/vocals/chop5", [vocalGain*playVolume, vocalRatio, 0, posVal5, posVal5, posVal5, numPhrase])
elif (playPhrase == 4):
    client.send_message("/song/vocals/chop1", [vocalGain*playVolume, vocalRatio, posVal1, 0, posVal1, 0, numPhrase])
    client.send_message("/song/vocals/chop5", [vocalGain*playVolume, vocalRatio, posVal5, 0, posVal5, 0, numPhrase])
