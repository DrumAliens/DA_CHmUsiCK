Chmusick live => JCRev rev => Gain gate => dac;

STATIC.oscChop7Gain => gate.gain;
0.04 => rev.mix;

// Sort changes to song
STATIC.oscMaster[3] => STATIC.TEMPO;

// VOCAL
spork~live.play(Buffer.chop7,STATIC.oscChop7Array,STATIC.oscChop7Amp,STATIC.oscChop7Freq,STATIC.oscChop7Mark);

while(true){
    //<<< STATIC.BEATS >>>;
    // Master Fade
    if (STATIC.MASTERFADEARRAY[1] == 1) {
        live.ramp(STATIC.oscChop7Gain, 0.0, 1.0, STATIC.MASTERFADERATE) => STATIC.oscChop7Gain => gate.gain;
    }    
    // Wait for a beat
    live.Dur(STATIC.TEMPO,STATIC.MEASURE) => now;
}

