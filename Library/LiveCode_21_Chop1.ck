Chmusick live => JCRev rev => HPF chopHPF => LPF chopLPF => Gain gate => dac;

200 => chopHPF.freq;
0.6 => chopHPF.Q;

6000 => chopLPF.freq;
0.6 => chopLPF.Q;

STATIC.oscChop1Gain => gate.gain;
0.04 => rev.mix;

// Sort changes to song
STATIC.oscMaster[3] => STATIC.TEMPO;

// VOCAL
spork~live.play(Buffer.chop1,STATIC.oscChop1Array,STATIC.oscChop1Amp,STATIC.oscChop1Freq,STATIC.oscChop1Mark);

while(true){
    //<<< STATIC.BEATS >>>;
    // Master Fade
    if (STATIC.MASTERFADEARRAY[1] == 1) {
        live.ramp(STATIC.oscChop1Gain, 0.0, 1.0, STATIC.MASTERFADERATE) => STATIC.oscChop1Gain => gate.gain;
    }
    // Wait for a beat
    live.Dur(STATIC.TEMPO,STATIC.MEASURE) => now;
}

