#!../.venv/bin/python
from pythonosc.udp_client import SimpleUDPClient
from typing import List, Any
import sys
import Library

# =================================
# Send out the OSC port to Chuck
# =================================

# Set up server and client for testing
client = SimpleUDPClient(Library.sendIp, Library.sendPort)

# ==== Send out ramp message
rampRate, maskDec  = Library.decodeRampArg(sys.argv)
client.send_message("/song/master/fade", [rampRate, maskDec])
    