#!../.venv/bin/python
from pythonosc.udp_client import SimpleUDPClient
from pythonosc.dispatcher import Dispatcher
from pythonosc.osc_server import ThreadingOSCUDPServer
from typing import List, Any
import time

def set_filter(address: str, *args: List[Any]) -> None:
    # Check input length and type
    if not len(args) == 1 or type(args[0]) is not int:
        return

    # Check that address 
    if not address == "/song/master/phrase":  # Cut off the last character
        return
    else:
        phraseNum = args[0]
        print(f"Phrase #{phraseNum}")
        instr01.send_message("/song/master/phrase",[phraseNum])
        instr02.send_message("/song/master/phrase",[phraseNum])
        instr03.send_message("/song/master/phrase",[phraseNum])
        instr04.send_message("/song/master/phrase",[phraseNum])
        instr05.send_message("/song/master/phrase",[phraseNum])
        instr06.send_message("/song/master/phrase",[phraseNum])
        instr07.send_message("/song/master/phrase",[phraseNum])
        return

# Setup the OSC port and IP
ip = '127.0.0.1'
sendPort = 49162
recPort = 49163

# Set up server and client for testing
client = SimpleUDPClient(ip, sendPort)

# ==== Send out master message
cycles = 4
measure = 4
division = 16
tempo = 110

client.send_message("/song/master/setup", [cycles, measure, division, tempo])

# Setup a port for each instrument
instr01 = SimpleUDPClient(ip, recPort+1)
instr02 = SimpleUDPClient(ip, recPort+2)
instr03 = SimpleUDPClient(ip, recPort+3)
instr04 = SimpleUDPClient(ip, recPort+4)
instr05 = SimpleUDPClient(ip, recPort+5)
instr06 = SimpleUDPClient(ip, recPort+6)
instr07 = SimpleUDPClient(ip, recPort+7)

# Handle the different ports for each instrument
dispatcher = Dispatcher()
dispatcher.map("/song/master/phrase", set_filter)  # Map wildcard address to set_filter function

# Setup the server
server = ThreadingOSCUDPServer((ip, recPort), dispatcher)

# Infinite event loop
while True:
    server.handle_request()
    

