//
//  Loop.ck
//  CHmUsiCK
//
//  Created by Celeste Betancur on 18/10/14.
//  Modified 24/06/15.
//  Testing ram overflow fix 1/03/2017.

// Osc sender object
OscOut oscOut;

// Aim the transmitter to a destination
oscOut.dest( "localhost", 49163);

0 => int device;
if( me.args() ) me.arg(0) => Std.atoi => device;

0 => int cmd;
0 => int syncState;
Shred counterID;

Chmusick extractor;
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

Machine.add(me.dir()+"/LiveCode_Drums.ck") => int fileDrumsID;
Machine.add(me.dir()+"/LiveCode_Synth.ck") => int fileSynthID;
Machine.add(me.dir()+"/LiveCode_Piano.ck") => int filePianoID;
Machine.add(me.dir()+"/LiveCode_Chops1.ck") => int fileChops1ID;
Machine.add(me.dir()+"/LiveCode_Chops3.ck") => int fileChops3ID;
Machine.add(me.dir()+"/LiveCode_Chops4.ck") => int fileChops4ID;
Machine.add(me.dir()+"/LiveCode_Chops5.ck") => int fileChops5ID;
Machine.add(me.dir()+"/LiveCode_Chops7.ck") => int fileChops7ID;

if(fileDrumsID*fileSynthID*filePianoID*fileChops1ID*fileChops3ID*fileChops4ID*fileChops5ID*fileChops7ID != 0) {
    spork~beatCounter() @=> counterID;
    while(true) day => now;
}
else {
    <<< "Check your LiveCode.ck file and add Library.ck again..." >>>;
}

public static int beatCounter()
{
    while(true)
    {
        STATIC.BEATS++;
        if(STATIC.BEATS % (STATIC.MEASURE * STATIC.CYCLES) == 0 && STATIC.BEATS > 2)
        {
            samp => now;
            if (STATIC.oscMsgDrumsRecvr > 0) {
               Machine.replace(fileDrumsID,me.dir()+"/LiveCode_Drums.ck");
               // Reset the length information
               0 => STATIC.oscMsgDrumsRecvr;
            }
            if (STATIC.oscMsgSynthRecvr > 0) {
               Machine.replace(fileSynthID,me.dir()+"/LiveCode_Synth.ck");
               // Reset the length information
               0 => STATIC.oscMsgSynthRecvr;
            }
            if (STATIC.oscMsgPianoRecvr > 0) {
               Machine.replace(filePianoID,me.dir()+"/LiveCode_Piano.ck");
               // Reset the length information
               0 => STATIC.oscMsgPianoRecvr;
            }
            if (STATIC.oscMsgChops1Recvr > 0) {
               Machine.replace(fileChops1ID,me.dir()+"/LiveCode_Chops1.ck");
               // Reset the length information
               0 => STATIC.oscMsgChops1Recvr;
            }

            if (STATIC.oscMsgChops3Recvr > 0) {
               Machine.replace(fileChops3ID,me.dir()+"/LiveCode_Chops3.ck");
               // Reset the length information
               0 => STATIC.oscMsgChops3Recvr;
            }
            if (STATIC.oscMsgChops4Recvr > 0) {
               Machine.replace(fileChops4ID,me.dir()+"/LiveCode_Chops4.ck");
               // Reset the length information
               0 => STATIC.oscMsgChops4Recvr;
            }
            if (STATIC.oscMsgChops5Recvr > 0) {
               Machine.replace(fileChops5ID,me.dir()+"/LiveCode_Chops5.ck");
               // Reset the length information
               0 => STATIC.oscMsgChops5Recvr;
            }
            if (STATIC.oscMsgChops7Recvr > 0) {
               Machine.replace(fileChops7ID,me.dir()+"/LiveCode_Chops7.ck");
               // Reset the length information
               0 => STATIC.oscMsgChops7Recvr;
            }

        }
        samp => now; // to let ChucK change STATIC.TEMPO value in case of change
        measureCounter();
        phraseCounter();
        extractor.convert(STATIC.TEMPO) => now;
      
    }
    return STATIC.BEATS;
}

public static int measureCounter()
{
    if(STATIC.BEATS % STATIC.MEASURE == 0)
    {
        STATIC.MEASURES++;
        //<<<STATIC.MEASURES, "Measures">>>; //uncomment to see # of measures
    }
    return STATIC.MEASURES;
}

public static int phraseCounter()
{
    if(STATIC.BEATS % (Sync.NUMMEASURES * STATIC.MEASURE) == 0)
    {
        STATIC.PHRASES++;
        
        // Setup OSC message
        oscOut.start( "/master/phrase" );
    
        // Add phrase the message
        STATIC.PHRASES => oscOut.add;
    
        // Send OSC message
        oscOut.send();

        //<<<STATIC.PHRASES, "Phrases">>>; //uncomment to see # of phrases
    }
   return STATIC.PHRASES;
}
