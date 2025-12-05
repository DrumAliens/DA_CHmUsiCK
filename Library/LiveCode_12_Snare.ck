Chmusick live => JCRev rev => Gain gate => dac;

// Sort changes to song
STATIC.oscMaster[3] => STATIC.TEMPO;

STATIC.oscSnareGain => gate.gain;
0.01 => rev.mix;

// DRUMS
0.5 => float localGain;
spork~live.play(Buffer.snare, STATIC.oscSnareArray, STATIC.oscSnareAmp * localGain, STATIC.oscSnareFreq, STATIC.oscSnareMark);

while(true){
    //<<< STATIC.BEATS >>>;
    // Master Fade
    if (STATIC.MASTERFADEARRAY[0] == 1) {
        live.ramp(STATIC.oscSnareGain, 0.0, 1.0, STATIC.MASTERFADERATE) => STATIC.oscSnareGain => gate.gain;
    }
    // Wait for a beat
    live.Dur(STATIC.TEMPO,STATIC.MEASURE) => now;
}

