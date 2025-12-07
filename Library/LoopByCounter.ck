//
//  Loop.ck
//  CHmUsiCK
//
//  Created by Celeste Betancur on 18/10/14.
//  Modified 24/06/15.
//  Testing ram overflow fix 1/03/2017.

0 => int device;
if( me.args() ) me.arg(0) => Std.atoi => device;

0 => int cmd;
0 => int syncState;
Shred counterID;

Chmusick live;
Buffer buffer;

Sync sync;

// Wait for the OSC signal on the song information
while (STATIC.oscMsgMstrRecvr == 0){
    samp => now;
}
STATIC.oscMaster[0] => STATIC.CYCLES;
STATIC.oscMaster[1] => STATIC.MEASURE;
STATIC.oscMaster[2] => STATIC.DIVISION;

sync.sync(STATIC.MEASURE, Sync.NUMMEASURES);

Machine.add(me.dir()+"/LiveCode_11_Kick.ck") => int fileKickID;
Machine.add(me.dir()+"/LiveCode_12_Snare.ck") => int fileSnareID;
Machine.add(me.dir()+"/LiveCode_13_Cymbals.ck") => int fileCymbalsID;
Machine.add(me.dir()+"/LiveCode_21_Chop1.ck") => int fileChop1ID;
Machine.add(me.dir()+"/LiveCode_23_Chop3.ck") => int fileChop3ID;
Machine.add(me.dir()+"/LiveCode_24_Chop4.ck") => int fileChop4ID;
Machine.add(me.dir()+"/LiveCode_25_Chop5.ck") => int fileChop5ID;
Machine.add(me.dir()+"/LiveCode_27_Chop7.ck") => int fileChop7ID;
Machine.add(me.dir()+"/LiveCode_30_Synth.ck") => int fileSynthID;
Machine.add(me.dir()+"/LiveCode_40_Piano.ck") => int filePianoID;
Machine.add(me.dir()+"/LiveCode_50_DogPack.ck") => int fileDogPackID;

if (fileKickID*fileSnareID*fileCymbalsID*fileSynthID*filePianoID*fileChop1ID*fileChop3ID*fileChop4ID*fileChop5ID*fileChop7ID*fileDogPackID != 0) {
   spork~beatCounter() @=> counterID;
   while(true) day => now;
}
else {
   if (fileKickID == 0) {
      <<< "Check your LiveCode_11_Kick.ck file " >>>;
   }
   if (fileSnareID == 0) {
      <<< "Check your LiveCode_12_Snare.ck file " >>>;
   }
   if (fileCymbalsID == 0) {
      <<< "Check your LiveCode_13_Cymbals.ck file " >>>;
   }
   if (fileChop1ID == 0) {
      <<< "Check your LiveCode_21_Chop1.ck file " >>>;
   }
   if (fileChop3ID == 0) {
      <<< "Check your LiveCode_23_Chop3.ck file " >>>;
   }
   if (fileChop4ID == 0) {
      <<< "Check your LiveCode_24_Chop4.ck file " >>>;
   }
   if (fileChop5ID == 0) {
      <<< "Check your LiveCode_25_Chop5.ck file " >>>;
   }
   if (fileChop7ID == 0) {
      <<< "Check your LiveCode_27_Chop7.ck file " >>>;
   }
   if (fileSynthID == 0) {
      <<< "Check your LiveCode_30_Synth.ck file " >>>;
   }
   if (filePianoID == 0) {
      <<< "Check your LiveCode_40_Piano.ck file " >>>;
   }
   if (fileDogPackID == 0) {
      <<< "Check your LiveCode_50_DogPack.ck file " >>>;
   }
}

public static int beatCounter() {
   while(true) {
      STATIC.BEATS++;
      if (STATIC.BEATS % (STATIC.MEASURE * STATIC.CYCLES) == 0 && STATIC.BEATS > 2) {
         samp => now;
         if (STATIC.oscMsgKickRecvr > 0) {
            Machine.replace(fileKickID,me.dir()+"/LiveCode_11_Kick.ck");
           0 => STATIC.oscMsgKickRecvr;
         }
         if (STATIC.oscMsgSnareRecvr > 0) { 
            Machine.replace(fileSnareID,me.dir()+"/LiveCode_12_Snare.ck");
            0 => STATIC.oscMsgSnareRecvr;
         }   
         if ((STATIC.oscMsgOpenHatsRecvr + STATIC.oscMsgClosedHatsRecvr + STATIC.oscMsgSplashRecvr) > 0) { 
            Machine.replace(fileCymbalsID,me.dir()+"/LiveCode_13_Cymbals.ck");
            0 => STATIC.oscMsgOpenHatsRecvr;
            0 => STATIC.oscMsgClosedHatsRecvr;
            0 => STATIC.oscMsgSplashRecvr;
         } 

         if (STATIC.oscMsgChop1Recvr > 0) {
            Machine.replace(fileChop1ID,me.dir()+"/LiveCode_21_Chop1.ck");
            // Reset the length information
            0 => STATIC.oscMsgChop1Recvr;
         }
         if (STATIC.oscMsgChop3Recvr > 0) {
            Machine.replace(fileChop3ID,me.dir()+"/LiveCode_23_Chop3.ck");
            // Reset the length information
            0 => STATIC.oscMsgChop3Recvr;
         }
         if (STATIC.oscMsgChop4Recvr > 0) {
            Machine.replace(fileChop4ID,me.dir()+"/LiveCode_24_Chop4.ck");
            // Reset the length information
            0 => STATIC.oscMsgChop4Recvr;
         }
         if (STATIC.oscMsgChop5Recvr > 0) {
            Machine.replace(fileChop5ID,me.dir()+"/LiveCode_25_Chop5.ck");
            // Reset the length information
            0 => STATIC.oscMsgChop5Recvr;
         }
         if (STATIC.oscMsgChop7Recvr > 0) {
            Machine.replace(fileChop7ID,me.dir()+"/LiveCode_27_Chop7.ck");
            // Reset the length information
            0 => STATIC.oscMsgChop7Recvr;
         }

         if (STATIC.oscMsgSynthRecvr > 0) {
            Machine.replace(fileSynthID,me.dir()+"/LiveCode_30_Synth.ck");
            // Reset the length information
            0 => STATIC.oscMsgSynthRecvr;
         }

         if (STATIC.oscMsgPianoRecvr > 0) {
            Machine.replace(filePianoID,me.dir()+"/LiveCode_40_Piano.ck");
            // Reset the length information
            0 => STATIC.oscMsgPianoRecvr;
         }

         if (STATIC.oscMsgDogPackRecvr > 0) { 
            Machine.replace(fileDogPackID,me.dir()+"/LiveCode_50_DogPack.ck");
            0 => STATIC.oscMsgDogPackRecvr;
         }   

         if (STATIC.oscMsgFadeRecvr > 0) { 
            STATIC.oscFadeRate => STATIC.MASTERFADERATE;
            STATIC.oscFadeEnbleArray @=> STATIC.MASTERFADEARRAY;
            0 => STATIC.oscMsgFadeRecvr;
         }   
      }
      
      samp => now; // to let ChucK change STATIC.TEMPO value in case of change
      measureCounter();
      phraseCounter();
      live.convert(STATIC.TEMPO) => now;
   
   }
   return STATIC.BEATS;
}

public static int measureCounter() {
   if (STATIC.BEATS % STATIC.MEASURE == 0)  {
      STATIC.MEASURES++;
      //<<<STATIC.MEASURES, "Measures">>>; //uncomment to see # of measures
   }
   return STATIC.MEASURES;
}

public static int phraseCounter() {
   if (STATIC.BEATS % (Sync.NUMMEASURES * STATIC.MEASURE) == 0) {
      STATIC.PHRASES++;
        
      //<<<STATIC.PHRASES, "Phrases">>>; //uncomment to see # of phrases
   }
   return STATIC.PHRASES;
}
