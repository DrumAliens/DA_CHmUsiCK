import time
from pythonosc.dispatcher import Dispatcher
from pythonosc.osc_server import BlockingOSCUDPServer

last_message_time = time.time()
TIMEOUT_DURATION = 3 # seconds

def update_last_message_time(address, *args):
    """Handler function to update the global timestamp every time a message is received."""
    global last_message_time
    current_time = time.time()
    time_since_last_message = current_time - last_message_time
    print(f"Received message from {address} after {time_since_last_message:.2f} seconds.")
    last_message_time = current_time # Update the timestamp to the current time

dispatcher = Dispatcher()
# Map a specific address to the handler that updates the timestamp
dispatcher.map("/monitor/time", update_last_message_time)
# Map all other addresses to the same handler for simplicity, or use a default handler
dispatcher.set_default_handler(update_last_message_time) 

server = BlockingOSCUDPServer(("127.0.0.1", 5005), dispatcher)
print(f"Server listening on 127.0.0.1:5005. Monitoring for silence longer than {TIMEOUT_DURATION} seconds.")

# Main loop to repeatedly check for messages
try:
    while True:
        # Check for messages with a short timeout to prevent blocking forever
        server.serve_timeout(0.5) 
        
        # After the timeout (whether a message came in or not), check the time difference
        current_time = time.time()
        time_since_last_message = current_time - last_message_time

        if time_since_last_message > TIMEOUT_DURATION:
            print("-" * 40)
            print(f"ALERT: No message received for over {TIMEOUT_DURATION} seconds ({time_since_last_message:.2f}s elapsed).")
            print("Resetting last message time to prevent repeated alerts.")
            last_message_time = current_time # Reset the time to acknowledge the timeout condition
            print("-" * 40)
            # You can add code here to trigger a specific action (e.g., send an error signal, stop a process, etc.)

except KeyboardInterrupt:
    print("Server stopped.")
    server.server_close()
