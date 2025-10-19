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
0 => STATIC.oscMsgDrumsRecvr;
0 => STATIC.oscMsgSynthRecvr;
0 => STATIC.oscMsgPianoRecvr;
0 => STATIC.oscMsgMstrRecvr;
0 => STATIC.oscMsgChops1Recvr;
0 => STATIC.oscMsgChops3Recvr;
0 => STATIC.oscMsgChops5Recvr;
0 => STATIC.oscMsgChops7Recvr;

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
          msg.numArgs() => STATIC.oscMsgMstrRecvr;
          msg.getInt(0) => STATIC.oscMaster[0];
          msg.getInt(1) => STATIC.oscMaster[1];
          msg.getInt(2) => STATIC.oscMaster[2];
          msg.getInt(3) => STATIC.oscMaster[3];
        }

        // Drums
        if (msg.address == "/drums/kick") {
          msg.numArgs() +=> STATIC.oscMsgDrumsRecvr;
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
        if (msg.address == "/drums/snare") {
          msg.numArgs() +=> STATIC.oscMsgDrumsRecvr;
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
        if (msg.address == "/drums/openhats") {
          msg.numArgs() +=> STATIC.oscMsgDrumsRecvr;
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
        if (msg.address == "/drums/closedhats") {
          msg.numArgs() +=> STATIC.oscMsgDrumsRecvr;
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
        if (msg.address == "/drums/splash") {
          msg.numArgs() +=> STATIC.oscMsgDrumsRecvr;
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

        // Synths
        if (msg.address == "/synth/saw0") {
          msg.numArgs() +=> STATIC.oscMsgSynthRecvr;
          if (msg.numArgs() != 1) {
            msg.getFloat(0) => STATIC.oscSaw0Amp;
            msg.getInt(1) => int loclFreq1;
            live.dec2Pos(msg.getInt(2)) @=> int loclArray1[];
            msg.getInt(3) => int loclFreq2;
            live.dec2Pos(msg.getInt(4)) @=> int loclArray2[];
            msg.getInt(5) => int loclFreq3;
            live.dec2Pos(msg.getInt(6)) @=> int loclArray3[];
            msg.getInt(7) => int loclFreq4;
            live.dec2Pos(msg.getInt(8)) @=> int loclArray4[];
            live.join(live.freqArray(loclFreq1,loclArray1),
                      live.freqArray(loclFreq2,loclArray2),
                      live.freqArray(loclFreq3,loclArray3),
                      live.freqArray(loclFreq4,loclArray4)) @=> STATIC.oscSaw0Array;
          }            
          else {
            0.0 => STATIC.oscSaw0Amp;
          }
        }  
        if (msg.address == "/synth/saw1") {
          msg.numArgs() +=> STATIC.oscMsgSynthRecvr;
          if (msg.numArgs() != 1) {
            msg.getFloat(0) => STATIC.oscSaw1Amp;
            msg.getInt(1) => int loclFreq1;
            live.dec2Pos(msg.getInt(2)) @=> int loclArray1[];
            msg.getInt(3) => int loclFreq2;
            live.dec2Pos(msg.getInt(4)) @=> int loclArray2[];
            msg.getInt(5) => int loclFreq3;
            live.dec2Pos(msg.getInt(6)) @=> int loclArray3[];
            msg.getInt(7) => int loclFreq4;
            live.dec2Pos(msg.getInt(8)) @=> int loclArray4[];
            live.join(live.freqArray(loclFreq1,loclArray1),
                      live.freqArray(loclFreq2,loclArray2),
                      live.freqArray(loclFreq3,loclArray3),
                      live.freqArray(loclFreq4,loclArray4)) @=> STATIC.oscSaw1Array;
          }            
          else {
            0.0 => STATIC.oscSaw1Amp;
          }
        }  
        if (msg.address == "/synth/saw2") {
          msg.numArgs() +=> STATIC.oscMsgSynthRecvr;
          if (msg.numArgs() != 1) {
            msg.getFloat(0) => STATIC.oscSaw2Amp;
            msg.getInt(1) => int loclFreq1;
            live.dec2Pos(msg.getInt(2)) @=> int loclArray1[];
            msg.getInt(3) => int loclFreq2;
            live.dec2Pos(msg.getInt(4)) @=> int loclArray2[];
            msg.getInt(5) => int loclFreq3;
            live.dec2Pos(msg.getInt(6)) @=> int loclArray3[];
            msg.getInt(7) => int loclFreq4;
            live.dec2Pos(msg.getInt(8)) @=> int loclArray4[];
            live.join(live.freqArray(loclFreq1,loclArray1),
                      live.freqArray(loclFreq2,loclArray2),
                      live.freqArray(loclFreq3,loclArray3),
                      live.freqArray(loclFreq4,loclArray4)) @=> STATIC.oscSaw2Array;
          }
          else {
            0.0 => STATIC.oscSaw2Amp;
          }
        }  
        if (msg.address == "/synth/saw3") {
          msg.numArgs() +=> STATIC.oscMsgSynthRecvr;
          if (msg.numArgs() != 1) {
            msg.getFloat(0) => STATIC.oscSaw3Amp;
            msg.getInt(1) => int loclFreq1;
            live.dec2Pos(msg.getInt(2)) @=> int loclArray1[];
            msg.getInt(3) => int loclFreq2;
            live.dec2Pos(msg.getInt(4)) @=> int loclArray2[];
            msg.getInt(5) => int loclFreq3;
            live.dec2Pos(msg.getInt(6)) @=> int loclArray3[];
            msg.getInt(7) => int loclFreq4;
            live.dec2Pos(msg.getInt(8)) @=> int loclArray4[];
            live.join(live.freqArray(loclFreq1,loclArray1),
                      live.freqArray(loclFreq2,loclArray2),
                      live.freqArray(loclFreq3,loclArray3),
                      live.freqArray(loclFreq4,loclArray4)) @=> STATIC.oscSaw3Array;
          }            
          else {
            0.0 => STATIC.oscSaw3Amp;
          }
        }  
        if (msg.address == "/synth/piano") {
           msg.numArgs() => STATIC.oscMsgPianoRecvr;
          if (msg.numArgs() != 1) {
            msg.getFloat(0) => STATIC.oscPianoAmp;
            msg.getFloat(1) => STATIC.oscPianoFreq;
            live.join(live.dec2Pos(msg.getInt(2)),
                      live.dec2Pos(msg.getInt(3)),
                      live.dec2Pos(msg.getInt(4)),
                      live.dec2Pos(msg.getInt(5))) @=> STATIC.oscPianoArray;
          }            
          else {
            0.0 => STATIC.oscPianoAmp;
          }
        }  

        // Vocals
        if (msg.address == "/vocals/chop1") {
          msg.numArgs() => STATIC.oscMsgChops1Recvr;
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
          msg.numArgs() => STATIC.oscMsgChops2Recvr;
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
          msg.numArgs() => STATIC.oscMsgChops3Recvr;
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
          msg.numArgs() => STATIC.oscMsgChops4Recvr;
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
          msg.numArgs() => STATIC.oscMsgChops5Recvr;
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
          msg.numArgs() => STATIC.oscMsgChops6Recvr;
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
          msg.numArgs() => STATIC.oscMsgChops7Recvr;
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
