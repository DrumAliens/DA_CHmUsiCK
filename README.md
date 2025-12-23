# DA_CHmUsiCK
Modifications to the CHmUsiCK live coding environment

# Inspiration for this code

The ChucK framework makes use of the following code

https://github.com/celestebetancur/CHmUsiCK

This then has made use of the samples and original musical idea from here

https://github.com/dbrown2642/ChucK-live-code-performance

## Objective
In CHmUsiCK a single livecode.ck file is reloaded (re-sporked in ChucK terminology) after a predefined number of bars. The song has to be develoed in the file and saved for that new set of instructions to be turned into music.

In this version instruments have been split out into individual chuck files this allows the following advantages
- samples that blend across bars can play properly (ends not overwritten)
- instrument changes are only reloaded when a change is triggered

What each instrument plays is controlled by sending out OSC messages to the ChucK code which then decodes this into a musical instructions. The code also sends out OSC synch messages this allows a "player piano" mode to be used. Which allows the sent OSC messages to be scheduled to allow a song without having to be controlled live. This allows you to develop ideas and the song, see the program oscPlayer.py as an example.

Importantly, as in CHmuSK any changes made to the song have to be sent saved at any point during the current phrase so that the changes can be instigated at the start of the new phrase. Synching of the music is handled by ChucK.

Note: this approach doesn't give you as much control as you can get with the CHmUsiCK or a more traditional livecoding approach. With the elements of the song/code having to be generated before each performance.

<h2 align="center"> You are more conducting than livecoding </h2>

# Linux Setup

The code has been developed on Ubuntu

## Modify Ubuntu 

Upgrade Ubuntu to make use of the real time kernel and low latency configuration. Open the terminal (Ctrl + Alt + T) and run:
```bash
    sudo apt update && sudo apt upgrade
```
You could reboot at this point just to be on the safe side, but it shouldn't be necessary unless you've been prompted to do so.

### Audio Configuration

You don't install Ubuntu Studio itself, just make use of the installer and audio configuration. Type the following into the terminal:
```bash
    sudo apt install ubuntustudio-installer
```
After that, run the installer itself:
```bash
    ubuntustudio-installer
```
When you see the message 'Package information successfully refreshed' with a 'Close' button, click it (the wording and red icon is a bit misleading here - the button should really have a green icon and say 'OK' or 'Continue').

When the installer opens, select the following packages (they should be the top three):
```
    linux-lowlatency
    ubuntustudio-lowlatency-settings
    ubuntustudio-performance-tweaks
```
We don't need the ubuntustudio-audio package - this refers to the bundled software. Click 'Modify Installed Package Selection' and wait for the process to finish. The installer may re-open again afterwards with the same packages selected, which may lead you to think the install wasn't successful, but this is another example of the user experience needing work - this is safe to close.

Finally, run the following command, which will optimally configure your system for audio:
```bash
    ubuntustudio-audio-config
```
Your system will likely require a restart at this point, but once the new configuration is active, you're good to go.

# Chuck Setup

This project makes use of ChucK livecoding environment. Get the latest version of the software from here
```
https://chuck.stanford.edu/release/
```

get the build instructions from here

```
https://github.com/ccrma/chuck#readme
```

To make ChucK available across the computer put the following in the .bashrc file. You need to define the path that points to the binary that you have generated as part of the build process
```
export PATH=$PATH:/XXX/chuck-XXXX/src
```

# Python setup
Setup a virtual environment for python in the project root directory using

```bash
python3 -m venv .venv
```
switch to the virtual environment 

```bash
    $ source .venv/bin/activate
```
and then install python-osc
```bash
    $ pip install python-osc
```

## Make the python executable

Since we are using the virtual environment we can point to this in the first line of the code to ensure that the python script uses this instead of any another python instance
```
    #!.venv/bin/python
```
Make the file executable with the following command
```bash
    chmod +x myfile.py
```
and execute with the following command
```bash
    ./myfile.py
```

# Running the code

### Running ChucK 
In a terminal run the following

```bash
    $ chuck Library.ck
```
This then loads all of the different chuck elements to run the code. It will wait at this point for a OSC synch message, this contains song information such as the number of bars that make up the phrase and the tempo of the song.

### Jack Control

**NEED SOMETHING IN HERE**

Install jack
sudo apt install jackd2 qjackctl pipewire-jack


in terminal type to find the list of available devices 
```
chuck --probe
```

should be able to do 
```
chuck --device:Jack Library.ck
```

# OSC Control

There are 3 different modes/approaches you can use to control the cond

- jupyter notebook, see oscSend.ipynb. Setup up a section for either each instrument or changes to be made at each point in the song
- playpiano mode, see oscPlay.py. This replicates the code that is wrapped 
- use a collection of OSC python instrument scripts, see the Song directory  

The table below shows the different OSC messages, IP and port numbers used. The three different options reflect the 3 different options for controlling the ChucK code. Note: that chuck program and the python can be run on different computers and in that case the IP's of the elements in bold would have to be changed accordingly. 


| IP | Port | Osc Message | From | To |
| --- | --- | --- | --- | --- |
|**127.0.0.1** | 49162  | song/master/setup | 00_StartSong.py | OscRevr.ck |\
| |   |  | oscPlayer.py | OscRevr.ck |\
| |   |  | oscSend.ipynb | OscRevr.ck |\
|**127.0.0.1** | 49163  | song/master/phrase | OscTrnsmt.ck | 00_StartSong.py |\
| |  |  | OscTrnsmt.ck | oscPlayer.py |\
| |  |  | OscTrnsmt.ck | oscSend.ipynb |\
|127.0.0.1 | 49164  | song/internal/phrase | 00_StartSong.py | Python Instrument Files |\
|127.0.0.1 | 49165  | song/internal/phrase | 00_StartSong.py | Python Instrument Files |\
|127.0.0.1 | 49166  | song/internal/phrase | 00_StartSong.py | Python Instrument Files |\
|127.0.0.1 | 49167  | song/internal/phrase | 00_StartSong.py | Python Instrument Files |\
|127.0.0.1 | 49168  | song/internal/phrase | 00_StartSong.py | Python Instrument Files |\
|127.0.0.1 | 49169  | song/internal/phrase | 00_StartSong.py | Python Instrument Files |\
|127.0.0.1 | 49170  | song/internal/phrase | 00_StartSong.py | Python Instrument Files |\
|127.0.0.1 | 49171  | song/internal/phrase | 00_StartSong.py | Python Instrument Files |\

Note: the last 8 ports in the table broadcast of the phrase numbers generated by OscTrnsmt.ck. The instrument files use this information to allow it to be delayed before it is played. The instrument file searches for a free port this then means that you can have up to 8 instruments delayed at any one time.

# Song folder

This contains a series of python scripts that can be used to replicate the song written in oscPlayer.py allowing you to play live

## 00_StartSong.py
This transmits all of the song information bpm, bar length and phrase length to ChucK. This has to be run first

This also receieves the phrase number information from ChucK (OscTrnsmt.ck) and displays it broadcasts this on various ports

## 01_SongFade.py

This allows a fade for all of instruments. This use the following input arguements

| Command | Example | Type | Description |
| --- | --- | --- | --- |
|**Rate**  |r-0.05   |float |reduce the volume of the instrument linearly  |\
|**Mark**    |m10  |integer |fade instruments starting in 1X and 3X |\

The Mark information is converted into binary in ChucK to allow different instruments to fade. The leading number of the instrument file indicates the bit to enable


## Instrument files

All of instruments have a leading number greater than 10

You can use the following command line arguements to control what is played. The following are a list of examples with default settings in brackets
| Command | Example | Type | Description |
| --- | --- | --- | --- |
|**Repeat**  |r4   |integer |repeat this instrument for 4 cycles (99999999) |\
|**Phrase**  |p2   |integer |play the second 2nd programmed pattern in the script (default 1) |\
|**Mark**    |m10  |integer |selects bar 1 and bar 3 parts of the phrase to be played converts decimal to binary with the MSB being bar 1 (15) |\
|**Timing**  |t10  |integer |similar to Mark allows different timings to be switched on or off each bar, usefull for synths (0) |\
|**Delay**   |d2   |integer |delays playing this phrase for 2 cycles (0) |\
|**Stop**    |s2   |integer |stops playing that instrument after 2 cycles (0) |
|**Volume**  |v0.5 |float   |allows you to change the current volume (1.0) |

To make replicating this live each instrument has been grouped using a leading number
- 1X drums
- 2X vocals
- 3X synth
- 4X piano
- 5X bass guitar
- 6x dog noises 

## Library.py
This contains a bunch of functions which are shared across the python scripts

# Future Improvements
- Automatically shut down 00_StartSong.py if it doesn't receive OSC messages


