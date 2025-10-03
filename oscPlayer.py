from pythonosc.dispatcher import Dispatcher
from typing import List, Any
from pythonosc.osc_server import BlockingOSCUDPServer
from pythonosc.udp_client import SimpleUDPClient

def set_filter(address: str, *args: List[Any]) -> None:
    # Check input length and type
    if not len(args) == 1 or type(args[0]) is not int:
        return

    # Check that address 
    if not address == "/master/phrase":  # Cut off the last character
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
dispatcher.map("/master/phrase", set_filter)  # Map wildcard address to set_filter function

# Set up server and client for testing
server = BlockingOSCUDPServer((ip, recPort), dispatcher)
client = SimpleUDPClient(ip, sendPort)

# Send out the master setup message to start the song
cycles = 4
measure = 4
division = 16
tempo = 95
client.send_message("/master/setup", [cycles, measure, division, tempo])

## Song
server.handle_request()
posVal = pos2Dec([0,3,6,11,15])
client.send_message("/drum/kick", [30, posVal, posVal, posVal, posVal])
server.handle_request()
posVal1 = pos2Dec([4,12])
posVal2 = pos2Dec([4,12,14])
client.send_message("/drum/snare", [30, posVal1, posVal2, posVal1, posVal2])
server.handle_request()
