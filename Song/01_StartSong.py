#!../.venv/bin/python
import time
from pythonosc.dispatcher import Dispatcher
from pythonosc.osc_server import ThreadingOSCUDPServer
#from pythonosc.server import ThreadingOSCUDPServer
from pythonosc.udp_client import SimpleUDPClient

# # A global variable to signal if a message has been received
# message_received = False

def handler_function(address, *args):
    # Check input length and type
    if not len(args) == 1 or type(args[0]) is not int:
        return start_time
    
    # Check that address 
    if not address == "/song/master/phrase":  # Cut off the last character
        return start_time
    else:
        # """Handler for received OSC messages."""
        # global message_received
        # message_received = True

        phraseNum = args[0]
        print(f"Phrase #{phraseNum}")
        instr01.send_message("/song/master/phrase",[phraseNum])
        instr02.send_message("/song/master/phrase",[phraseNum])
        instr03.send_message("/song/master/phrase",[phraseNum])
        instr04.send_message("/song/master/phrase",[phraseNum])
        instr05.send_message("/song/master/phrase",[phraseNum])
        instr06.send_message("/song/master/phrase",[phraseNum])
        instr07.send_message("/song/master/phrase",[phraseNum])
        instr08.send_message("/song/master/phrase",[phraseNum])
        instr09.send_message("/song/master/phrase",[phraseNum])
        instr10.send_message("/song/master/phrase",[phraseNum])

        return time.time()

def run_server_with_timeout(ip, recPort, timeout_seconds):
    """
    Runs an OSC server in a thread and stops it if a message
    is received or after a timeout.
    """
    # global message_received
    # message_received = False
    
    dispatcher = Dispatcher()
    # Map a wildcard address to the handler to catch any incoming message
    dispatcher.map("/song/master/phrase", handler_function) 

    server = ThreadingOSCUDPServer((ip, recPort), dispatcher)
    #print(f"Serving on {server.server_address} with timeout of {timeout_seconds} seconds")
    
    # Start the server in a separate thread
    server_thread = server.serve_forever
    # We call it as a function in the main thread in this simplified example, 
    # but for a non-blocking main loop, you would typically use `threading.Thread` 
    # or `asyncio`.
    
    # A simple blocking way to simulate the timeout logic:

    # while not message_received and (time.time() - start_time) < timeout_seconds:
    start_time = time.time()
    while (time.time() - start_time) < timeout_seconds:
        # handle_request processes one message or times out briefly to check the loop condition
        start_time = server.handle_request() 

    # if message_received:
    #     print("Message received within the timeout period.")
    # else:
    #     print("Timeout: No OSC message received.")
        
    # server.shutdown() # Stop the server
    # print("Server shut down.")

if __name__ == "__main__":
    # Configuration
    IP = "127.0.0.1"
    SEND_PORT = 49162
    LISTEN_PORT = 49163
    TIMEOUT = 5 # seconds

    # ==== Send out master message
    cycles = 4
    measure = 4
    division = 16
    tempo = 110
 
    # Set up server and client for testing
    client = SimpleUDPClient(IP, SEND_PORT)
    client.send_message("/song/master/setup", [cycles, measure, division, tempo])

    # Setup a port for each instrument
    instr01 = SimpleUDPClient(IP, LISTEN_PORT+1)
    instr02 = SimpleUDPClient(IP, LISTEN_PORT+2)
    instr03 = SimpleUDPClient(IP, LISTEN_PORT+3)
    instr04 = SimpleUDPClient(IP, LISTEN_PORT+4)
    instr05 = SimpleUDPClient(IP, LISTEN_PORT+5)
    instr06 = SimpleUDPClient(IP, LISTEN_PORT+6)
    instr07 = SimpleUDPClient(IP, LISTEN_PORT+7)
    instr08 = SimpleUDPClient(IP, LISTEN_PORT+8)
    instr09 = SimpleUDPClient(IP, LISTEN_PORT+9)
    instr10 = SimpleUDPClient(IP, LISTEN_PORT+10)

    run_server_with_timeout(IP, LISTEN_PORT, TIMEOUT)
