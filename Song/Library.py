#!../.venv/bin/python
import socket, errno
from typing import List, Any

# ======================================
# User defined the network ip addresses
# ======================================
listenIp = '127.0.0.1'
listenPort = 49163
sendIp   = '127.0.0.1'
sendPort = 49162
replayPort = listenPort + 1
replayPortNum = 9

def pos2Dec(array):
    decVal = 0
    for val in array:
        decVal += 2**val

    return decVal     

def dec2Bin(val):
    array = 4*[0]
    if (val > 0):
        for i in range(len(array)):
            array[i] = int(val % 2)
            val = val / 2

    return array        

def set_filter(address: str, *args: List[Any]) -> None:
    # Check input length and type
    if not len(args) == 1 or type(args[0]) is not int:
        return

    # Check that address 
    if not address == "/song/internal/phrase":  # Cut off the last character
        return

def decodeInstrArg(argv):
    # Read in any command line variables
    playPhrase = 1
    playVolume = 1.0
    numPhrase = 99999999
    maskArray = dec2Bin(15)
    timeArray = dec2Bin(0)
    delayPhrase = 0
    stopNum = 0
    freqRatio = 1.0
    for indx in range(len(argv)):
        string = str(argv[indx])
        if 'p' in string[0].lower():
            playPhrase = int(string[1:])
        if 'v' in string[0].lower():
            playVolume = float(string[1:])
        if 'r' in string[0].lower():
            numPhrase = int(string[1:])
        if 'm' in string[0].lower():
            maskArray = dec2Bin(int(string[1:]))
        if 't' in string[0].lower():
            timeArray = dec2Bin(int(string[1:]))
        if 'd' in string[0].lower():
            delayPhrase = int(string[1:])
        if 's' in string[0].lower():
            stopNum = int(string[1:])
        if 'f' in string[0].lower():
            freqRatio = float(string[1:])

    return playPhrase, playVolume, numPhrase, maskArray, timeArray, delayPhrase, stopNum, freqRatio

def decodeRampArg(argv):
    # Read in any command line variables
    rampRate = 0
    maskDec = 0
    for indx in range(len(argv)):
        string = str(argv[indx])
        if 'r' in string[0].lower():
            rampRate = float(string[1:])
        if 'm' in string[0].lower():
            maskDec = int(string[1:])

    return rampRate, maskDec
