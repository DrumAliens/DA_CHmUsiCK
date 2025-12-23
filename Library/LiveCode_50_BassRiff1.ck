Chmusick live => Gain gate => dac;

// Sort changes to song
STATIC.oscMaster[3] => STATIC.TEMPO;

STATIC.oscBassRiff1Gain => gate.gain;

// DRUMS
spork~live.play(Buffer.bassRiff1, STATIC.oscBassRiff1Array, STATIC.oscBassRiff1Amp, STATIC.oscBassRiff1Freq, STATIC.oscBassRiff1Mark);

while(true){
    //<<< STATIC.BEATS >>>;
    // Master Fade
    if (STATIC.MASTERFADEARRAY[4] == 1) {
        live.ramp(STATIC.oscBassRiff1Gain, 0.0, 1.0, STATIC.MASTERFADERATE) => STATIC.oscBassRiff1Gain => gate.gain;
    }
    // Wait for a beat
    live.Dur(STATIC.TEMPO,STATIC.MEASURE) => now;
}

