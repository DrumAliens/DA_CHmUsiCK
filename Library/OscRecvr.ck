//----------------------------------------------------------------------------
// desc: OpenSoundControl (OSC) receiver example
// note: launch with s.ck (or another sender)
//----------------------------------------------------------------------------

Chmusick live;

// create our OSC receiver
OscIn oscIn;
// create our OSC message
OscMsg msg;
// use port 49162 (or whatever)
49162 => oscIn.port;
// create an address in the receiver, expect an int and a float
oscIn.addAddress( "/*");

// Reset the Osc receive message flag
0 => STATIC.oscMsgRecvr;

// infinite event loop
while( true )
{
    // wait for event to arrive
    oscIn => now;

    // grab the next message from the queue. 
    while( oscIn.recv(msg) )
    {
        // print stuff
        // cherr <= "received OSC message: \"" <= msg.address <= "\" "
        //      <= "typetag: \"" <= msg.typetag <= "\" "
        //      <= "arguments: " <= msg.numArgs() <= IO.newline();         

        if (msg.address == "/master/setup") {
          msg.numArgs() +=> STATIC.oscMsgRecvr;
          msg.getInt(0) => STATIC.oscMaster[0];
          msg.getInt(1) => STATIC.oscMaster[1];
          msg.getInt(2) => STATIC.oscMaster[2];
          msg.getInt(3) => STATIC.oscMaster[3];
        }

        // // Decode the different messages 
        if (msg.address == "/drum/kick") {
          msg.numArgs() +=> STATIC.oscMsgRecvr;
          msg.getInt(0) => STATIC.oscKickAmp;
          live.join(live.dec2Pos(msg.getInt(1)),
                    live.dec2Pos(msg.getInt(2)),
                    live.dec2Pos(msg.getInt(3)),
                    live.dec2Pos(msg.getInt(4))) @=> STATIC.kickArray;
        }  
        if (msg.address == "/drum/snare") {
          msg.numArgs() +=> STATIC.oscMsgRecvr;
          msg.getInt(0) => STATIC.oscSnareAmp;
          msg.getInt(1) => STATIC.oscSnare[1];
          msg.getInt(2) => STATIC.oscSnare[2];
          msg.getInt(3) => STATIC.oscSnare[3];
          msg.getInt(4) => STATIC.oscSnare[4];
        }  
        if (msg.address == "/drum/openhats") {
          msg.numArgs() +=> STATIC.oscMsgRecvr;
          msg.getInt(0) => STATIC.oscOpenHatsAmp;
          msg.getInt(1) => STATIC.oscOpenHats[1];
          msg.getInt(2) => STATIC.oscOpenHats[2];
          msg.getInt(3) => STATIC.oscOpenHats[3];
          msg.getInt(4) => STATIC.oscOpenHats[4];
        }  
        if (msg.address == "/drum/closedhats") {
          msg.numArgs() +=> STATIC.oscMsgRecvr;
          msg.getInt(0) => STATIC.oscClosedHatsAmp;
          msg.getInt(1) => STATIC.oscClosedHats[1];
          msg.getInt(2) => STATIC.oscClosedHats[2];
          msg.getInt(3) => STATIC.oscClosedHats[3];
          msg.getInt(4) => STATIC.oscClosedHats[4];
        }  
        if (msg.address == "/drum/splash") {
          msg.numArgs() +=> STATIC.oscMsgRecvr;
          msg.getInt(0) => STATIC.oscSplashAmp;
          msg.getInt(1) => STATIC.oscSplash[1];
          msg.getInt(2) => STATIC.oscSplash[2];
          msg.getInt(3) => STATIC.oscSplash[3];
          msg.getInt(4) => STATIC.oscSplash[4];
        }  
    }     
}
