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

        // Master setup
        if (msg.address == "/master/setup") {
          msg.numArgs() +=> STATIC.oscMsgRecvr;
          msg.getInt(0) => STATIC.oscMaster[0];
          msg.getInt(1) => STATIC.oscMaster[1];
          msg.getInt(2) => STATIC.oscMaster[2];
          msg.getInt(3) => STATIC.oscMaster[3];
        }

        // Drums
        if (msg.address == "/drum/kick") {
          msg.numArgs() +=> STATIC.oscMsgRecvr;
          if (msg.numArgs() != 1) {
            msg.getFloat(0) => STATIC.oscKickAmp;
            msg.getFloat(1) => STATIC.oscKickFreq;
            live.join(live.dec2Pos(msg.getInt(2)),
                      live.dec2Pos(msg.getInt(3)),
                      live.dec2Pos(msg.getInt(4)),
                      live.dec2Pos(msg.getInt(5))) @=> STATIC.oscKickArray;
          }            
          else {
            0.0 => STATIC.oscKickAmp;
          }
        }  
        if (msg.address == "/drum/snare") {
          msg.numArgs() +=> STATIC.oscMsgRecvr;
          if (msg.numArgs() != 1) {
            msg.getFloat(0) => STATIC.oscSnareAmp;
            msg.getFloat(1) => STATIC.oscSnareFreq;
            live.join(live.dec2Pos(msg.getInt(2)),
                      live.dec2Pos(msg.getInt(3)),
                      live.dec2Pos(msg.getInt(4)),
                      live.dec2Pos(msg.getInt(5))) @=> STATIC.oscSnareArray;   
          }            
          else {
            0.0 => STATIC.oscSnareAmp;
          }
        }  
        if (msg.address == "/drum/openhats") {
          msg.numArgs() +=> STATIC.oscMsgRecvr;
          if (msg.numArgs() != 1) {
            msg.getFloat(0) => STATIC.oscOpenHatsAmp;
            msg.getFloat(1) => STATIC.oscOpenHatsFreq;
            live.join(live.dec2Pos(msg.getInt(2)),
                      live.dec2Pos(msg.getInt(3)),
                      live.dec2Pos(msg.getInt(4)),
                      live.dec2Pos(msg.getInt(5))) @=> STATIC.oscOpenHatsArray;
          }            
          else {
            0.0 => STATIC.oscOpenHatsAmp;
          }
        }  
        if (msg.address == "/drum/closedhats") {
          msg.numArgs() +=> STATIC.oscMsgRecvr;
          if (msg.numArgs() != 1) {
            msg.getFloat(0) => STATIC.oscClosedHatsAmp;
            msg.getFloat(1) => STATIC.oscClosedHatsFreq;
            live.join(live.dec2Pos(msg.getInt(2)),
                      live.dec2Pos(msg.getInt(3)),
                      live.dec2Pos(msg.getInt(4)),
                      live.dec2Pos(msg.getInt(5))) @=> STATIC.oscClosedHatsArray;
          }            
          else {
            0.0 => STATIC.oscClosedHatsAmp;
          }
        }  
        if (msg.address == "/drum/splash") {
          msg.numArgs() +=> STATIC.oscMsgRecvr;
          if (msg.numArgs() != 1) {
            msg.getFloat(0) => STATIC.oscSplashAmp;
            msg.getFloat(1) => STATIC.oscSplashFreq;
            live.join(live.dec2Pos(msg.getInt(2)),
                      live.dec2Pos(msg.getInt(3)),
                      live.dec2Pos(msg.getInt(4)),
                      live.dec2Pos(msg.getInt(5))) @=> STATIC.oscSplashArray;
          }            
          else {
            0.0 => STATIC.oscSplashAmp;
          }
        }  

        // Vocals
        if (msg.address == "/vocals/chop1") {
          msg.numArgs() +=> STATIC.oscMsgRecvr;
          if (msg.numArgs() != 1) {
            msg.getFloat(0) => STATIC.oscChop1Amp;
            msg.getFloat(1) => STATIC.oscChop1Freq;
            live.join(live.dec2Pos(msg.getInt(2)),
                      live.dec2Pos(msg.getInt(3)),
                      live.dec2Pos(msg.getInt(4)),
                      live.dec2Pos(msg.getInt(5))) @=> STATIC.oscChop1Array;
          }            
          else {
            0.0 => STATIC.oscChop1Amp;
          }
        }  
        if (msg.address == "/vocals/chop2") {
          msg.numArgs() +=> STATIC.oscMsgRecvr;
          if (msg.numArgs() != 1) {
            msg.getFloat(0) => STATIC.oscChop2Amp;
            msg.getFloat(1) => STATIC.oscChop2Freq;
            live.join(live.dec2Pos(msg.getInt(2)),
                      live.dec2Pos(msg.getInt(3)),
                      live.dec2Pos(msg.getInt(4)),
                      live.dec2Pos(msg.getInt(5))) @=> STATIC.oscChop2Array;
          }            
          else {
            0.0 => STATIC.oscChop2Amp;
          }
        }  
        if (msg.address == "/vocals/chop3") {
          msg.numArgs() +=> STATIC.oscMsgRecvr;
          if (msg.numArgs() != 1) {
            msg.getFloat(0) => STATIC.oscChop3Amp;
            msg.getFloat(1) => STATIC.oscChop3Freq;
            live.join(live.dec2Pos(msg.getInt(2)),
                      live.dec2Pos(msg.getInt(3)),
                      live.dec2Pos(msg.getInt(4)),
                      live.dec2Pos(msg.getInt(5))) @=> STATIC.oscChop3Array;
          }            
          else {
            0.0 => STATIC.oscChop3Amp;
          }
        }  
        if (msg.address == "/vocals/chop4") {
          msg.numArgs() +=> STATIC.oscMsgRecvr;
          if (msg.numArgs() != 1) {
            msg.getFloat(0) => STATIC.oscChop4Amp;
            msg.getFloat(1) => STATIC.oscChop4Freq;
            live.join(live.dec2Pos(msg.getInt(2)),
                      live.dec2Pos(msg.getInt(3)),
                      live.dec2Pos(msg.getInt(4)),
                      live.dec2Pos(msg.getInt(5))) @=> STATIC.oscChop4Array;
          }            
          else {
            0.0 => STATIC.oscChop4Amp;
          }
        }  
        if (msg.address == "/vocals/chop5") {
          msg.numArgs() +=> STATIC.oscMsgRecvr;
          if (msg.numArgs() != 1) {
            msg.getFloat(0) => STATIC.oscChop5Amp;
            msg.getFloat(1) => STATIC.oscChop5Freq;
            live.join(live.dec2Pos(msg.getInt(2)),
                      live.dec2Pos(msg.getInt(3)),
                      live.dec2Pos(msg.getInt(4)),
                      live.dec2Pos(msg.getInt(5))) @=> STATIC.oscChop5Array;
          }            
          else {
            0.0 => STATIC.oscChop5Amp;
          }
        }  
        if (msg.address == "/vocals/chop6") {
          msg.numArgs() +=> STATIC.oscMsgRecvr;
          if (msg.numArgs() != 1) {
            msg.getFloat(0) => STATIC.oscChop6Amp;
            msg.getFloat(1) => STATIC.oscChop6Freq;
            live.join(live.dec2Pos(msg.getInt(2)),
                      live.dec2Pos(msg.getInt(3)),
                      live.dec2Pos(msg.getInt(4)),
                      live.dec2Pos(msg.getInt(5))) @=> STATIC.oscChop6Array;
          }            
          else {
            0.0 => STATIC.oscChop6Amp;
          }
        }  
        if (msg.address == "/vocals/chop7") {
          msg.numArgs() +=> STATIC.oscMsgRecvr;
          if (msg.numArgs() != 1) {
            msg.getFloat(0) => STATIC.oscChop7Amp;
            msg.getFloat(1) => STATIC.oscChop7Freq;
            live.join(live.dec2Pos(msg.getInt(2)),
                      live.dec2Pos(msg.getInt(3)),
                      live.dec2Pos(msg.getInt(4)),
                      live.dec2Pos(msg.getInt(5))) @=> STATIC.oscChop7Array;
          }            
          else {
            0.0 => STATIC.oscChop7Amp;
          }
        }  
    }     
}
