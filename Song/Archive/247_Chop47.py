#!../.venv/bin/python
from typing import List, Any
from pythonosc.udp_client import SimpleUDPClient
import sys
import Library

# Read in any command line variables
playPhrase, playVolume, numPhrase, maskArray, synchArray  = Library.decodeInputArg(sys.argv)

ip = '127.0.0.1'
sendPort = 49162
recPort = 49163

# Set up server and client for testing
client = SimpleUDPClient(ip, sendPort)

vocalGain = 0.5*playVolume
vocalRatio = 1.05

# if we define the number of bars we can then auto fill the OSC message to pack out the information
# Tweak the frequency of the hit hats
hatsRatio = 1.135716

# ==== Send out 
posVal4 = Library.pos2Dec([9])
posVal7 = Library.pos2Dec([14])

if (playPhrase == 1):
    client.send_message("/song/vocals/chop4", [0.5*vocalGain, vocalRatio, posVal4, posVal4, 0, 0, numPhrase])
    client.send_message("/song/vocals/chop7", [0.5*vocalGain, vocalRatio, posVal7, 0, 0, 0, numPhrase])
elif (playPhrase == 2):
    client.send_message("/song/vocals/chop4", [0.5*vocalGain, vocalRatio, posVal4, posVal4, posVal4, posVal4, numPhrase])
    client.send_message("/song/vocals/chop7", [0.5*vocalGain, vocalRatio, posVal7, 0, posVal7, 0, numPhrase])
elif (playPhrase == 3):
    client.send_message("/song/vocals/chop4", [0.5*vocalGain, vocalRatio, posVal4, posVal4, posVal4, posVal4, numPhrase])
    client.send_message("/song/vocals/chop7", [0.5*vocalGain, vocalRatio, posVal7, 0, posVal7, 0, numPhrase])


