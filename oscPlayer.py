#!.venv/bin/python
from pythonosc.dispatcher import Dispatcher
from typing import List, Any
from pythonosc.osc_server import ThreadingOSCUDPServer
from pythonosc.udp_client import SimpleUDPClient

def set_filter(address: str, *args: List[Any]) -> None:
    # Check input length and type
    if not len(args) == 1 or type(args[0]) is not int:
        return

    # Check that address 
    if not address == "/song/master/phrase":  # Cut off the last character
        return

    print(f"Phrase #{args[0]}")

def pos2Dec(array):
    decVal = 0
    for val in array:
        decVal += 2**val

    return decVal     


ip = '127.0.0.1'
sendPort = 49162
recPort = 49163

dispatcher = Dispatcher()
dispatcher.map("/song/master/phrase", set_filter)  # Map wildcard address to set_filter function

# Set up server and client for testing
server = ThreadingOSCUDPServer((ip, recPort), dispatcher)
client = SimpleUDPClient(ip, sendPort)

# Send out the master setup message to start the song
cycles = 4
measure = 4
division = 16
tempo = 110
client.send_message("/song/master/setup", [cycles, measure, division, tempo])

hatsRatio = 1.135716


## Song

# ==== Cymbals
server.handle_request()
numPhrase = 3
posVal = pos2Dec([0,4,8,12])
client.send_message("/song/drums/openhats", [0.15, hatsRatio, posVal, posVal, posVal, posVal, numPhrase])
posVal = pos2Dec([1,5,9,13])
#posVal = pos2Dec([2,6,10,14])
client.send_message("/song/drums/closedhats", [0.3, hatsRatio, posVal, posVal, posVal, posVal, numPhrase])
posVal = pos2Dec([14])
client.send_message("/song/drums/splash", [0.1, hatsRatio, 0, posVal, 0, posVal, numPhrase])

# ==== Kick
server.handle_request()
numPhrase = 2
posVal = pos2Dec([0,3,6,11,15])
client.send_message("/song/drums/kick", [0.3, 1.0, posVal, posVal, posVal, posVal, numPhrase])

# ==== Snare
server.handle_request()
numPhrase = 1
posVal1 = pos2Dec([4,12])
posVal2 = pos2Dec([4,12,14])
client.send_message("/song/drums/snare", [0.3, 1.0, posVal1, posVal2, posVal1, posVal2, numPhrase])

# ==== Vocals 3
server.handle_request()
vocalGain = 0.5
vocalRatio = 1.05
# posVal = pos2Dec([0])
# client.send_message("/song/vocals/chop1", [vocalGain, vocalRatio, posVal, posVal, posVal, posVal])
posVal = pos2Dec([4,12])
client.send_message("/song/vocals/chop3", [0.75*vocalGain, vocalRatio, posVal, posVal, posVal, posVal])
posVal = pos2Dec([9])
# client.send_message("/song/vocals/chop4", [vocalGain, vocalRatio, posVal, posVal, posVal, posVal])
# posVal = pos2Dec([2])
# client.send_message("/song/vocals/chop5", [vocalGain, vocalRatio, posVal, posVal, posVal, posVal])
# posVal = pos2Dec([14])
# client.send_message("/song/vocals/chop7", [0.75*vocalGain, vocalRatio, posVal, posVal, posVal, posVal])

server.handle_request()
posVal = pos2Dec([0,4,8,12])
client.send_message("/song/drums/openhats", [0.15, hatsRatio, 0, 0, posVal, posVal])
posVal = pos2Dec([1,5,9,13])
#posVal = pos2Dec([2,6,10,14])
client.send_message("/song/drums/closedhats", [0.3, hatsRatio, 0, 0, posVal, posVal])
posVal = pos2Dec([14])
client.send_message("/song/drums/splash", [0.1, hatsRatio, 0, posVal, 0, posVal])

# ==== Kick
server.handle_request()
numPhrase = 2
posVal = pos2Dec([0,3,6])
client.send_message("/song/drums/kick", [0.3, 1.0, posVal, 0, 0, 0])

# ==== Vocals 1-5
server.handle_request()
posVal = pos2Dec([0])
client.send_message("/song/vocals/chop1", [vocalGain, vocalRatio, posVal, 0, posVal, 0])
# posVal = pos2Dec([4,12])
# client.send_message("/song/vocals/chop3", [0.75*vocalGain, vocalRatio, posVal, posVal, posVal, posVal])
posVal = pos2Dec([2])
client.send_message("/song/vocals/chop5", [vocalGain, vocalRatio, posVal, 0, posVal, 0])

# ==== Vocals 4-7
server.handle_request()
posVal = pos2Dec([9])
client.send_message("/song/vocals/chop4", [vocalGain, vocalRatio, posVal, posVal, 0, 0])
posVal = pos2Dec([14])
client.send_message("/song/vocals/chop7", [0.75*vocalGain, vocalRatio, posVal, 0, 0, 0])

server.handle_request()
server.handle_request()
posVal = pos2Dec([0,4,8,12])
client.send_message("/song/drums/openhats", [0.15, hatsRatio, posVal, posVal, posVal, posVal, numPhrase])
posVal = pos2Dec([1,5,9,13])
#posVal = pos2Dec([2,6,10,14])
client.send_message("/song/drums/closedhats", [0.3, hatsRatio, posVal, posVal, posVal, posVal, numPhrase])
posVal = pos2Dec([14])
client.send_message("/song/drums/splash", [0.1, hatsRatio, 0, posVal, 0, posVal, numPhrase])

# ====  Reinstate Drums
server.handle_request()
server.handle_request()
posVal = pos2Dec([0,3,6,11,15])
client.send_message("/song/drums/kick", [0.3, 1.0, posVal, posVal, posVal, posVal])
posVal1 = pos2Dec([4,12])
posVal2 = pos2Dec([4,12,14])
client.send_message("/song/drums/snare", [0.3, 1.0, posVal1, posVal2, posVal1, posVal2])
#posVal = pos2Dec([0,4,8,12])
#client.send_message("/song/drums/openhats", [0.15, hatsRatio, posVal, posVal, posVal, posVal])
#posVal = pos2Dec([1,5,9,13])
#posVal = pos2Dec([2,6,10,14])
#client.send_message("/song/drums/closedhats", [0.3, hatsRatio, posVal, posVal, posVal, posVal])
#posVal = pos2Dec([14])
#client.send_message("/song/drums/splash", [0.1, hatsRatio, 0, posVal, 0, posVal])
#posVal = pos2Dec([0,3,6,11,15])
#client.send_message("/song/drums/kick", [0.3, 1.0, posVal, posVal, posVal, posVal])






# posVal1 = pos2Dec([4,12])
# posVal2 = pos2Dec([4,12,14])
# client.send_message("/song/drums/snare", [0.3, 1.0, posVal1, posVal2, posVal1, posVal2])

# ## ====
# server.handle_request()
# server.handle_request()
# posVal1 = 65535; # - pos2Dec([2,5,9,10,11,14,15]);
# posVal2 = 65535; # - pos2Dec([2,5,9,10,11]);
# posVal3 = 65535; # - pos2Dec([2,5,9,10,11,14,15]);
# posVal4 = 65535; # - pos2Dec([2,5,9,10,11]);

# client.send_message("//song/synth/saw0", [1.0, 44, posVal1, 41, posVal2, 43, posVal3, 36, posVal4])
# client.send_message("/song/synth/saw1", [1.0, 56, posVal1, 55, posVal2, 58, posVal3, 56, posVal4])
# client.send_message("/song/synth/saw2", [1.0, 60, posVal1, 60, posVal2, 62, posVal3, 60, posVal4])
# client.send_message("/song/synth/saw3", [1.0, 63, posVal1, 63, posVal2, 65, posVal3, 64, posVal4])
# posVal = pos2Dec([0, 4, 8, 12, 14]);
# client.send_message("/song/synth/saw4", [0.3, 1.0, posVal, posVal, posVal, posVal])

# ## ====
# server.handle_request()
# server.handle_request()
# vocalGain = 0.5
# vocalRatio = 1.05

# posVal = pos2Dec([0])
# client.send_message("/song/vocals/chop1", [vocalGain, vocalRatio, posVal, posVal, posVal, posVal])
# posVal = pos2Dec([4,12])
# client.send_message("/song/vocals/chop3", [0.75*vocalGain, vocalRatio, posVal, posVal, posVal, posVal])
# posVal = pos2Dec([9])
# client.send_message("/song/vocals/chop4", [vocalGain, vocalRatio, posVal, posVal, posVal, posVal])
# posVal = pos2Dec([2])
# client.send_message("/song/vocals/chop5", [vocalGain, vocalRatio, posVal, posVal, posVal, posVal])
# posVal = pos2Dec([14])
# client.send_message("/song/vocals/chop7", [0.75*vocalGain, vocalRatio, posVal, posVal, posVal, posVal])

# server.handle_request()
# server.handle_request()
# posVal1 = 65535;# - pos2Dec([2,5,9,10,11,14,15]);
# posVal2 = 65535;# - pos2Dec([2,5,9,10,11]);
# posVal3 = 65535;# - pos2Dec([2,5,9,10,11,14,15]);
# posVal4 = 65535 - pos2Dec([2,5,9,10,11]);

# client.send_message("/song/synth/saw0", [1.0, 44, posVal1, 41, posVal2, 43, posVal3, 36, posVal4])
# client.send_message("/song/synth/saw1", [1.0, 56, posVal1, 55, posVal2, 58, posVal3, 56, posVal4])
# client.send_message("/song/synth/saw2", [1.0, 60, posVal1, 60, posVal2, 62, posVal3, 60, posVal4])
# client.send_message("/song/synth/saw3", [1.0, 63, posVal1, 63, posVal2, 65, posVal3, 64, posVal4])
# client.send_message("/song/synth/saw4", [1.0, 67, posVal1, 67, posVal2, 69, posVal3, 68, posVal4])

# ## ====
# server.handle_request()
# server.handle_request()
# posVal1 = 65535 - pos2Dec([2,5,9,10,11,14,15]);
# posVal2 = 65535 - pos2Dec([2,5,9,10,11]);
# posVal3 = 65535 - pos2Dec([2,5,9,10,11,14,15]);
# posVal4 = 65535 - pos2Dec([2,5,9,10,11]);

# client.send_message("/song/synth/saw0", [1.0, 44, posVal1, 41, posVal2, 43, posVal3, 36, posVal4])
# client.send_message("/song/synth/saw1", [1.0, 56, posVal1, 55, posVal2, 58, posVal3, 56, posVal4])
# client.send_message("/song/synth/saw2", [1.0, 60, posVal1, 60, posVal2, 62, posVal3, 60, posVal4])
# client.send_message("/song/synth/saw3", [1.0, 63, posVal1, 63, posVal2, 65, posVal3, 64, posVal4])
# client.send_message("/song/synth/saw4", [1.0, 67, posVal1, 67, posVal2, 69, posVal3, 68, posVal4])




# # posVal = pos2Dec([0,3,6,11,15])
# # client.send_message("/song/drums/kick", [0.3, 1.0, posVal, posVal, posVal, posVal])

# # posVal1 = pos2Dec([4,12])
# # posVal2 = pos2Dec([4,12,14])
# # client.send_message("/song/drums/snare", [0.3, 1.0, posVal1, posVal2, posVal1, posVal2])

# # posVal = pos2Dec([0,4,8,12])
# # client.send_message("/song/drums/openhats", [0.15, hatsRatio, posVal, posVal, posVal, posVal])

# # posVal = pos2Dec([1,5,9,13])
# # #posVal = pos2Dec([2,6,10,14])
# # client.send_message("/song/drums/closedhats", [0.3, hatsRatio, posVal, posVal, posVal, posVal])

# # posVal = pos2Dec([14])
# # client.send_message("/song/drums/splash", [0.1, hatsRatio, 0, posVal, 0, posVal])


