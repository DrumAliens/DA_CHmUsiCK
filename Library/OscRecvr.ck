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
oscIn.addAddress( "/song/*");

// Reset the Osc receive message flag
0 => STATIC.oscMsgKickRecvr;
0 => STATIC.oscMsgSnareRecvr;
0 => STATIC.oscMsgOpenHatsRecvr;
0 => STATIC.oscMsgClosedHatsRecvr;
0 => STATIC.oscMsgSplashRecvr;
0 => STATIC.oscMsgSynthRecvr;
0 => STATIC.oscMsgPianoRecvr;
0 => STATIC.oscMsgMstrRecvr;
0 => STATIC.oscMsgChops1Recvr;
0 => STATIC.oscMsgChops3Recvr;
0 => STATIC.oscMsgChops5Recvr;
0 => STATIC.oscMsgDogPackRecvr;
0 => STATIC.oscMsgFadeRecvr;

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
    if (msg.address == "/song/master/setup") {
      msg.numArgs() => STATIC.oscMsgMstrRecvr;
      msg.getInt(0) => STATIC.oscMaster[0];
      msg.getInt(1) => STATIC.oscMaster[1];
      msg.getInt(2) => STATIC.oscMaster[2];
      msg.getInt(3) => STATIC.oscMaster[3];
    }

    if (msg.address == "/song/master/fade") {
      msg.numArgs() => STATIC.oscMsgFadeRecvr;
      // Ensure that the input is clamped between 0.0 and 1.0
      Std.clampf(msg.getFloat(0),-1.0,1.0) => STATIC.oscFadeRate;
      live.dec2Pos(msg.getInt(1)) @=> STATIC.oscFadeEnbleArray;
    }

    // Drums
    if (msg.address == "/song/drums/kick") {
      msg.numArgs() => STATIC.oscMsgKickRecvr;
      if (msg.numArgs() != 1) {
        msg.getFloat(0) => STATIC.oscKickAmp;
        msg.getFloat(1) => STATIC.oscKickFreq;
        live.join(live.dec2Pos(msg.getInt(2)),
                  live.dec2Pos(msg.getInt(3)),
                  live.dec2Pos(msg.getInt(4)),
                  live.dec2Pos(msg.getInt(5))) @=> STATIC.oscKickArray;
        STATIC.MAXINT => STATIC.oscKickMark;
        if (msg.numArgs() > 6) {
          msg.getInt(6) => STATIC.oscKickMark;
        }
      }            
      else {
        //0.0 => STATIC.oscKickAmp;
        msg.getInt(0) => STATIC.oscKickMark;
      }
    }  
    if (msg.address == "/song/drums/snare") {
      msg.numArgs() => STATIC.oscMsgSnareRecvr;
      if (msg.numArgs() != 1) {
        msg.getFloat(0) => STATIC.oscSnareAmp;
        msg.getFloat(1) => STATIC.oscSnareFreq;
        live.join(live.dec2Pos(msg.getInt(2)),
                  live.dec2Pos(msg.getInt(3)),
                  live.dec2Pos(msg.getInt(4)),
                  live.dec2Pos(msg.getInt(5))) @=> STATIC.oscSnareArray;   
        STATIC.MAXINT => STATIC.oscSnareMark;
        if (msg.numArgs() > 6) {
          msg.getInt(6) => STATIC.oscSnareMark;
        }
      }            
      else {
        //0.0 => STATIC.oscSnareAmp;
        msg.getInt(0) => STATIC.oscSnareMark;
      }
    }  
    if (msg.address == "/song/drums/openhats") {
      msg.numArgs() => STATIC.oscMsgOpenHatsRecvr;
      if (msg.numArgs() != 1) {
        msg.getFloat(0) => STATIC.oscOpenHatsAmp;
        msg.getFloat(1) => STATIC.oscOpenHatsFreq;
        live.join(live.dec2Pos(msg.getInt(2)),
                  live.dec2Pos(msg.getInt(3)),
                  live.dec2Pos(msg.getInt(4)),
                  live.dec2Pos(msg.getInt(5))) @=> STATIC.oscOpenHatsArray;
        STATIC.MAXINT => STATIC.oscOpenHatsMark;
        if (msg.numArgs() > 6) {
          msg.getInt(6) => STATIC.oscOpenHatsMark;
        }

      }            
      else {
        //0.0 => STATIC.oscOpenHatsAmp;
        msg.getInt(0)  => STATIC.oscOpenHatsMark;
      }
    }  
    if (msg.address == "/song/drums/closedhats") {
      msg.numArgs() => STATIC.oscMsgClosedHatsRecvr;
      if (msg.numArgs() != 1) {
        msg.getFloat(0) => STATIC.oscClosedHatsAmp;
        msg.getFloat(1) => STATIC.oscClosedHatsFreq;
        live.join(live.dec2Pos(msg.getInt(2)),
                  live.dec2Pos(msg.getInt(3)),
                  live.dec2Pos(msg.getInt(4)),
                  live.dec2Pos(msg.getInt(5))) @=> STATIC.oscClosedHatsArray;
        STATIC.MAXINT => STATIC.oscClosedHatsMark;
        if (msg.numArgs() > 6) {
          msg.getInt(6) => STATIC.oscClosedHatsMark;
        }
      }            
      else {
        //0.0 => STATIC.oscClosedHatsAmp;
        msg.getInt(0) => STATIC.oscClosedHatsMark;
      }
    }  
    if (msg.address == "/song/drums/splash") {
      msg.numArgs() => STATIC.oscMsgSplashRecvr;
      if (msg.numArgs() != 1) {
        msg.getFloat(0) => STATIC.oscSplashAmp;
        msg.getFloat(1) => STATIC.oscSplashFreq;
        live.join(live.dec2Pos(msg.getInt(2)),
                  live.dec2Pos(msg.getInt(3)),
                  live.dec2Pos(msg.getInt(4)),
                  live.dec2Pos(msg.getInt(5))) @=> STATIC.oscSplashArray;
        STATIC.MAXINT => STATIC.oscSplashMark;
        if (msg.numArgs() > 6) {
          msg.getInt(6) => STATIC.oscSplashMark;
        }
      }            
      else {
        //0.0 => STATIC.oscSplashAmp;
        msg.getInt(0) => STATIC.oscSplashMark;
      }
    }  

    // Synths
    if (msg.address == "/song/synth/saw0") {
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
        STATIC.MAXINT => STATIC.oscSaw0Mark;
        if (msg.numArgs() > 9) {
          msg.getInt(9) => STATIC.oscSaw0Mark;
        }
      }            
      else {
        //0.0 => STATIC.oscSaw0Amp;
        msg.getInt(0) => STATIC.oscSaw0Mark;
      }
    }  
    if (msg.address == "/song/synth/saw1") {
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
        STATIC.MAXINT => STATIC.oscSaw1Mark;
        if (msg.numArgs() > 9) {
          msg.getInt(9) => STATIC.oscSaw1Mark;
        }
      }            
      else {
        // 0.0 => STATIC.oscSaw1Amp;
        msg.getInt(0) => STATIC.oscSaw1Mark;
      }
    }  
    if (msg.address == "/song/synth/saw2") {
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
        STATIC.MAXINT => STATIC.oscSaw2Mark;
        if (msg.numArgs() > 9) {
          msg.getInt(9) => STATIC.oscSaw2Mark;
        }
      }
      else {
        // 0.0 => STATIC.oscSaw2Amp;
        msg.getInt(0) => STATIC.oscSaw2Mark;
      }
    }  
    if (msg.address == "/song/synth/saw3") {
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
        STATIC.MAXINT => STATIC.oscSaw3Mark;
        if (msg.numArgs() > 9) {
          msg.getInt(9) => STATIC.oscSaw3Mark;
        }
      }            
      else {
        // 0.0 => STATIC.oscSaw3Amp;
        msg.getInt(0) => STATIC.oscSaw3Mark;
      }
    }  
    if (msg.address == "/song/synth/piano") {
        msg.numArgs() => STATIC.oscMsgPianoRecvr;
      if (msg.numArgs() != 1) {
        msg.getFloat(0) => STATIC.oscPianoAmp;
        msg.getFloat(1) => STATIC.oscPianoFreq;
        live.join(live.dec2Pos(msg.getInt(2)),
                  live.dec2Pos(msg.getInt(3)),
                  live.dec2Pos(msg.getInt(4)),
                  live.dec2Pos(msg.getInt(5))) @=> STATIC.oscPianoArray;
        STATIC.MAXINT => STATIC.oscPianoMark;
        if (msg.numArgs() > 6) {
          msg.getInt(6) => STATIC.oscPianoMark;
        }
      }            
      else {
        // 0.0 => STATIC.oscPianoAmp;
        msg.getInt(0) => STATIC.oscPianoMark;
      }
    }  

    // Vocals
    if (msg.address == "/song/vocals/chop1") {
      msg.numArgs() => STATIC.oscMsgChops1Recvr;
      if (msg.numArgs() != 1) {
        msg.getFloat(0) => STATIC.oscChop1Amp;
        msg.getFloat(1) => STATIC.oscChop1Freq;
        live.join(live.dec2Pos(msg.getInt(2)),
                  live.dec2Pos(msg.getInt(3)),
                  live.dec2Pos(msg.getInt(4)),
                  live.dec2Pos(msg.getInt(5))) @=> STATIC.oscChop1Array;
        STATIC.MAXINT => STATIC.oscChop1Mark;
        if (msg.numArgs() > 6) {
          msg.getInt(6) => STATIC.oscChop1Mark;
        }
      }            
      else {
        // 0.0 => STATIC.oscChop1Amp;
        msg.getInt(0) => STATIC.oscChop1Mark;
      }
    }  
    if (msg.address == "/song/vocals/chop2") {
      msg.numArgs() => STATIC.oscMsgChops2Recvr;
      if (msg.numArgs() != 1) {
        msg.getFloat(0) => STATIC.oscChop2Amp;
        msg.getFloat(1) => STATIC.oscChop2Freq;
        live.join(live.dec2Pos(msg.getInt(2)),
                  live.dec2Pos(msg.getInt(3)),
                  live.dec2Pos(msg.getInt(4)),
                  live.dec2Pos(msg.getInt(5))) @=> STATIC.oscChop2Array;
        STATIC.MAXINT => STATIC.oscChop2Mark;
        if (msg.numArgs() > 6) {
          msg.getInt(6) => STATIC.oscChop2Mark;
        }
      }            
      else {
        // 0.0 => STATIC.oscChop2Amp;
        msg.getInt(0) => STATIC.oscChop2Mark;
      }
    }  
    if (msg.address == "/song/vocals/chop3") {
      msg.numArgs() => STATIC.oscMsgChops3Recvr;
      if (msg.numArgs() != 1) {
        msg.getFloat(0) => STATIC.oscChop3Amp;
        msg.getFloat(1) => STATIC.oscChop3Freq;
        live.join(live.dec2Pos(msg.getInt(2)),
                  live.dec2Pos(msg.getInt(3)),
                  live.dec2Pos(msg.getInt(4)),
                  live.dec2Pos(msg.getInt(5))) @=> STATIC.oscChop3Array;
        STATIC.MAXINT => STATIC.oscChop3Mark;
        if (msg.numArgs() > 6) {
          msg.getInt(6) => STATIC.oscChop3Mark;
        }
      }            
      else {
        // 0.0 => STATIC.oscChop3Amp;
        msg.getInt(0) => STATIC.oscChop3Mark;
      }
    }  
    if (msg.address == "/song/vocals/chop4") {
      msg.numArgs() => STATIC.oscMsgChops4Recvr;
      if (msg.numArgs() != 1) {
        msg.getFloat(0) => STATIC.oscChop4Amp;
        msg.getFloat(1) => STATIC.oscChop4Freq;
        live.join(live.dec2Pos(msg.getInt(2)),
                  live.dec2Pos(msg.getInt(3)),
                  live.dec2Pos(msg.getInt(4)),
                  live.dec2Pos(msg.getInt(5))) @=> STATIC.oscChop4Array;
        STATIC.MAXINT => STATIC.oscChop4Mark;
        if (msg.numArgs() > 6) {
          msg.getInt(6) => STATIC.oscChop4Mark;
        }
      }            
      else {
        // 0.0 => STATIC.oscChop4Amp;
        msg.getInt(0) => STATIC.oscChop4Mark;
      }
    }  
    if (msg.address == "/song/vocals/chop5") {
      msg.numArgs() => STATIC.oscMsgChops5Recvr;
      if (msg.numArgs() != 1) {
        msg.getFloat(0) => STATIC.oscChop5Amp;
        msg.getFloat(1) => STATIC.oscChop5Freq;
        live.join(live.dec2Pos(msg.getInt(2)),
                  live.dec2Pos(msg.getInt(3)),
                  live.dec2Pos(msg.getInt(4)),
                  live.dec2Pos(msg.getInt(5))) @=> STATIC.oscChop5Array;
        STATIC.MAXINT => STATIC.oscChop5Mark;
        if (msg.numArgs() > 6) {
          msg.getInt(6) => STATIC.oscChop5Mark;
        }
      }            
      else {
        //0.0 => STATIC.oscChop5Amp;
        msg.getInt(0) => STATIC.oscChop5Mark;
      }
    }  
    if (msg.address == "/song/vocals/chop6") {
      msg.numArgs() => STATIC.oscMsgChops6Recvr;
      if (msg.numArgs() != 1) {
        msg.getFloat(0) => STATIC.oscChop6Amp;
        msg.getFloat(1) => STATIC.oscChop6Freq;
        live.join(live.dec2Pos(msg.getInt(2)),
                  live.dec2Pos(msg.getInt(3)),
                  live.dec2Pos(msg.getInt(4)),
                  live.dec2Pos(msg.getInt(5))) @=> STATIC.oscChop6Array;
        STATIC.MAXINT => STATIC.oscChop6Mark;
        if (msg.numArgs() > 6) {
          msg.getInt(6) => STATIC.oscChop6Mark;
        }
      }            
      else {
        //0.0 => STATIC.oscChop6Amp;
        msg.getInt(0) => STATIC.oscChop6Mark;
      }
    }  
    if (msg.address == "/song/vocals/chop7") {
      msg.numArgs() => STATIC.oscMsgChops7Recvr;
      if (msg.numArgs() != 1) {
        msg.getFloat(0) => STATIC.oscChop7Amp;
        msg.getFloat(1) => STATIC.oscChop7Freq;
        live.join(live.dec2Pos(msg.getInt(2)),
                  live.dec2Pos(msg.getInt(3)),
                  live.dec2Pos(msg.getInt(4)),
                  live.dec2Pos(msg.getInt(5))) @=> STATIC.oscChop7Array;
        STATIC.MAXINT => STATIC.oscChop7Mark;
        if (msg.numArgs() > 6) {
          msg.getInt(6) => STATIC.oscChop7Mark;
        }
      }            
      else {
        msg.getInt(0) => STATIC.oscChop7Mark;
      }
    }  
    if (msg.address == "/song/vocals/dogpack") {
      msg.numArgs() => STATIC.oscMsgDogPackRecvr;
      if (msg.numArgs() != 1) {
        msg.getFloat(0) => STATIC.oscDogPackAmp;
        msg.getFloat(1) => STATIC.oscDogPackFreq;
        live.join(live.dec2Pos(msg.getInt(2)),
                  live.dec2Pos(msg.getInt(3)),
                  live.dec2Pos(msg.getInt(4)),
                  live.dec2Pos(msg.getInt(5))) @=> STATIC.oscDogPackArray;   
        STATIC.MAXINT => STATIC.oscDogPackMark;
        if (msg.numArgs() > 6) {
          msg.getInt(6) => STATIC.oscDogPackMark;
        }
      }            
      else {
        msg.getInt(0) => STATIC.oscDogPackMark;
      }
    }  
  }     
}
