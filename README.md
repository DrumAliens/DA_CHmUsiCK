# DA_CHmUsiCK
Modifications to the CHmUsiCK live coding environment


This project makes use of ChucK

https://github.com/ccrma/chuck


## Initial code base

The ChucK framework makes use of the following code

https://github.com/celestebetancur/CHmUsiCK

This then has made use of  

https://github.com/dbrown2642/ChucK-live-code-performance


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

## Python setup
Setup virtual environment best to do it the folder using VSCode then do 
```bash
    $ pip install python-osc
```

## Run Player Piano mode
Open a terminal 

```bash
    $ source .venv/bin/activate
```

-------------
### For command line users
In a terminal

```bash
    $ chuck Library.ck
```


### Make the python executable

Since we are making use of a virtual environment we have to put the following comment on the first line of the code
```
    #!.venv/bin/python
```
Make the file executable with the following command
'''bash
    chmod +x myfile.py
```
and execute with the following command
```bash
    ./myfile.py
```

