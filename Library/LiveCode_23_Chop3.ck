Chmusick live => JCRev rev => HPF chopHPF => LPF chopLPF => Gain gate => dac;

200 => chopHPF.freq;
0.6 => chopHPF.Q;

6000 => chopLPF.freq;
0.6 => chopLPF.Q;

STATIC.oscChop3Gain => gate.gain;
0.04 => rev.mix;

// Sort changes to song
STATIC.oscMaster[3] => STATIC.TEMPO;

// VOCAL
spork~live.play(Buffer.chop3,STATIC.oscChop3Array,STATIC.oscChop3Amp,STATIC.oscChop3Freq,STATIC.oscChop3Mark);

while(true){
    //<<< STATIC.BEATS >>>;
    // Master Fade
    if (STATIC.MASTERFADEARRAY[1] == 1) {
        live.ramp(STATIC.oscChop3Gain, 0.0, 1.0, STATIC.MASTERFADERATE) => STATIC.oscChop3Gain => gate.gain;
    }
    // Wait for a beat
    live.Dur(STATIC.TEMPO,STATIC.MEASURE) => now;
}

