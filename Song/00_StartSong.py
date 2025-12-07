#!../.venv/bin/python
from pythonosc.udp_client import SimpleUDPClient
from pythonosc.dispatcher import Dispatcher
from pythonosc.osc_server import ThreadingOSCUDPServer
from typing import List, Any
import Library

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
        instr01.send_message("/song/internal/phrase",[phraseNum])
        instr02.send_message("/song/internal/phrase",[phraseNum])
        instr03.send_message("/song/internal/phrase",[phraseNum])
        instr04.send_message("/song/internal/phrase",[phraseNum])
        instr05.send_message("/song/internal/phrase",[phraseNum])
        instr06.send_message("/song/internal/phrase",[phraseNum])
        instr07.send_message("/song/internal/phrase",[phraseNum])
        instr08.send_message("/song/internal/phrase",[phraseNum])
        return

# =================================
# Send out the OSC port to Chuck
# =================================

# Set up server and client for testing
client = SimpleUDPClient(Library.sendIp, Library.sendPort)

# ==== Send out master message
cycles = 4
measure = 4
division = 16
tempo = 110

client.send_message("/song/master/setup", [cycles, measure, division, tempo])

# =================================
# Setup rebroadcast clients for OSC to the local instruments
# =================================

instr01 = SimpleUDPClient('127.0.0.01', Library.replayPort)
instr02 = SimpleUDPClient('127.0.0.01', Library.replayPort+1)
instr03 = SimpleUDPClient('127.0.0.01', Library.replayPort+2)
instr04 = SimpleUDPClient('127.0.0.01', Library.replayPort+3)
instr05 = SimpleUDPClient('127.0.0.01', Library.replayPort+4)
instr06 = SimpleUDPClient('127.0.0.01', Library.replayPort+5)
instr07 = SimpleUDPClient('127.0.0.01', Library.replayPort+6)
instr08 = SimpleUDPClient('127.0.0.01', Library.replayPort+7)

# =================================
# Listen to OSC port from Chuck
# =================================

# Handle the different ports for each instrument
dispatcher = Dispatcher()
dispatcher.map("/song/master/phrase", set_filter)  # Map wildcard address to set_filter function

server = ThreadingOSCUDPServer((Library.listenIp, Library.listenPort), dispatcher)

# Listen for a new message
while True:
    server.serve_forever()
    

