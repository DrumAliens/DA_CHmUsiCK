#!../.venv/bin/python
from pythonosc.dispatcher import Dispatcher
from typing import List, Any
from pythonosc.osc_server import ThreadingOSCUDPServer
from pythonosc.udp_client import SimpleUDPClient
import sys
import Library

def set_filter(address: str, *args: List[Any]) -> None:
    # Check input length and type
    if not len(args) == 1 or type(args[0]) is not int:
        return

    # Check that address 
    if not address == "/song/master/phrase":  # Cut off the last character
        return

#    #print(f"Phrase #{args[0]}")

# Read in any command line variables
playPhrase, playVolume, numPhrase, maskArray, synchArray, delayPhrase, killNum, freqRatio = Library.decodeInputArg(sys.argv)

# Setup the OSC port and IP
ip = '127.0.0.1'
sendPort = 49162
recPort = 49163 + delayPhrase

dispatcher = Dispatcher()
dispatcher.map("/song/master/phrase", set_filter)  # Map wildcard address to set_filter function

# Set up server and client for testing
server = ThreadingOSCUDPServer((ip, recPort), dispatcher)
client = SimpleUDPClient(ip, sendPort)

vocalGain = 0.5*playVolume
vocalRatio = 1.05

# ==== Send out 
posVal1 = 65535 - maskArray[3]*Library.pos2Dec([2,5,9,10,11,14,15]);
posVal2 = 65535 - maskArray[2]*Library.pos2Dec([2,5,9,10,11]);
posVal3 = 65535 - maskArray[1]*Library.pos2Dec([2,5,9,10,11,14,15]);
posVal4 = 65535 - maskArray[0]*Library.pos2Dec([2,5,9,10,11]);

sawGain = 0.5

client.send_message("/song/synth/saw0", [sawGain, 40, posVal1, 40, posVal2, 40, posVal3, 40, posVal4, numPhrase])
client.send_message("/song/synth/saw1", [sawGain, 55, posVal1, 52, posVal2, 50, posVal3, 47, posVal4, numPhrase])
client.send_message("/song/synth/saw2", [sawGain, 62, posVal1, 59, posVal2, 57, posVal3, 54, posVal4, numPhrase])
client.send_message("/song/synth/saw3", [sawGain, 67, posVal1, 64, posVal2, 62, posVal3, 59, posVal4, numPhrase])

server.handle_request()

client.send_message("/song/synth/saw0", [sawGain, 40, posVal1, 40, posVal2, 40, posVal3, 40, posVal4, numPhrase])
client.send_message("/song/synth/saw1", [sawGain, 48, posVal1, 48, posVal2, 52, posVal3, 52, posVal4, numPhrase])
client.send_message("/song/synth/saw2", [sawGain, 55, posVal1, 55, posVal2, 59, posVal3, 59, posVal4, numPhrase])
client.send_message("/song/synth/saw3", [sawGain, 60, posVal1, 60, posVal2, 64, posVal3, 64, posVal4, numPhrase])


