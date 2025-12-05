Chmusick live => JCRev rev => Gain gate => dac;

// Sort changes to song
STATIC.oscMaster[3] => STATIC.TEMPO;

STATIC.oscCymbalGain => gate.gain;
0.01 => rev.mix;

// DRUMS
0.5 => float localGain;
spork~live.play(Buffer.hatsOpen, STATIC.oscOpenHatsArray, STATIC.oscOpenHatsAmp * localGain, STATIC.oscOpenHatsFreq, STATIC.oscOpenHatsMark);
spork~live.play(Buffer.hatsSplash, STATIC.oscSplashArray, STATIC.oscSplashAmp * localGain, STATIC.oscSplashFreq, STATIC.oscSplashMark);
spork~live.play(Buffer.hatsGhost1, STATIC.oscClosedHatsArray, STATIC.oscClosedHatsAmp * localGain, STATIC.oscClosedHatsFreq, STATIC.oscClosedHatsMark);

while(true){
    //<<< STATIC.BEATS >>>;
    // Master Fade
    if (STATIC.MASTERFADEARRAY[0] == 1) {
        live.ramp(STATIC.oscCymbalGain, 0.0, 1.0, STATIC.MASTERFADERATE) => STATIC.oscCymbalGain => gate.gain;
   }
    // Wait for a beat
    live.Dur(STATIC.TEMPO,STATIC.MEASURE) => now;
}

