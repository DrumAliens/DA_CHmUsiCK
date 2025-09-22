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

Chmusick extractor;
Buffer buffer;

Sync sync;

// Wait for the OSC signal on the song information
while (STATIC.oscMasterLen == 0){
    samp => now;
}
STATIC.oscMaster[0] => STATIC.CYCLES;
STATIC.oscMaster[1] => STATIC.MEASURE;
STATIC.oscMaster[2] => STATIC.DIVISION;

sync.sync(STATIC.MEASURE, Sync.NUMMEASURES);

Machine.add(me.dir()+"/LiveCode.ck") => int fileID;

if(fileID != 0) {
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
            if ((STATIC.oscMasterLen+STATIC.oscKickLen+STATIC.oscSnareLen+STATIC.oscOpenHatsLen+STATIC.oscClosedHatsLen+STATIC.oscSplashLen) > 0) {
               Machine.replace(fileID,me.dir()+"/LiveCode.ck");
               // Reset the length information
               0 => STATIC.oscMasterLen;
               0 => STATIC.oscKickLen;
               0 => STATIC.oscSnareLen;
               0 => STATIC.oscKickLen;
               0 => STATIC.oscOpenHatsLen;
               0 => STATIC.oscClosedHatsLen;
               0 => STATIC.oscSplashLen;
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
        //<<<STATIC.PHRASES, "Phrases">>>; //uncomment to see # of phrases
    }
   return STATIC.PHRASES;
}
