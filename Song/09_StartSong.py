import time
import threading
from pythonosc.dispatcher import Dispatcher
from pythonosc.osc_server import ThreadingOSCUDPServer

# Global variables shared between threads
last_message_time_lock = threading.Lock()
last_message_time = time.time()
TIMEOUT_DURATION = 3 # seconds

def update_last_message_time(address, *args):
    """Handler function to update the global timestamp securely using a lock."""
    global last_message_time
    with last_message_time_lock:
        current_time = time.time()
        time_since_last_message = current_time - last_message_time
        print(f"Received message from {address} after {time_since_last_message:.2f} seconds.")
        last_message_time = current_time # Update the timestamp

dispatcher = Dispatcher()
# Map all addresses to the same handler for simplicity
dispatcher.set_default_handler(update_last_message_time) 

server = ThreadingOSCUDPServer(("127.0.0.1", 5005), dispatcher)
server_thread = threading.Thread(target=server.serve_forever)
server_thread.start()

print(f"Server running in separate thread on 127.0.0.1:5005. Monitoring for silence > {TIMEOUT_DURATION}s.")

# Main program loop (runs independently from the server thread)
try:
    while True:
        # Sleep for a short duration to avoid consuming excessive CPU
        time.sleep(1) 
        
        # Check the time difference securely using a lock
        with last_message_time_lock:
            current_time = time.time()
            time_since_last_message = current_time - last_message_time

            if time_since_last_message > TIMEOUT_DURATION:
                print("-" * 40)
                print(f"ALERT: No message received for over {TIMEOUT_DURATION} seconds ({time_since_last_message:.2f}s elapsed).")
                print("Triggering action and resetting check time.")
                last_message_time = current_time # Reset the time to acknowledge the timeout
                print("-" * 40)
                # You can add the specific action logic here (e.g., stopping a process)

except KeyboardInterrupt:
    print("Keyboard interrupt received. Shutting down server.")

finally:
    # Stop the server and wait for the thread to terminate gracefully
    server.shutdown()
    server_thread.join()
    print("Server stopped and thread terminated.")
