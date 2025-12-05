Chmusick live; // => JCRev rev => Gain gate => dac;
//Chmusick live => LPF lpf => HPF hpf => JCRev rev => Gain gate => dac;

// 30000 => lpf.freq;
// 20 => hpf.freq;

// Sort changes to song
STATIC.oscMaster[3] => STATIC.TEMPO;

JCRev rev;
0.02 => rev.mix;

LPF sawLPF;
700 => sawLPF.freq;
0.4 => sawLPF.Q;

Gain gate;
STATIC.oscSawGain => gate.gain;

// KEYBOARD
SawOsc saw0 => sawLPF => rev => gate => dac;
SawOsc saw1 => sawLPF => rev => gate => dac;
SawOsc saw2 => sawLPF => rev => gate => dac;
SawOsc saw3 => sawLPF => rev => gate => dac;

0.002 => float localGain;
spork~live.play(saw0,STATIC.oscSaw0Array,STATIC.oscSaw0Amp * localGain, STATIC.oscSaw0Mark);
spork~live.play(saw1,STATIC.oscSaw1Array,STATIC.oscSaw1Amp * localGain, STATIC.oscSaw1Mark);
spork~live.play(saw2,STATIC.oscSaw2Array,STATIC.oscSaw2Amp * localGain, STATIC.oscSaw2Mark);
spork~live.play(saw3,STATIC.oscSaw3Array,STATIC.oscSaw3Amp * localGain, STATIC.oscSaw3Mark);

while(true){
    //<<< STATIC.BEATS >>>;
    // Master Fade
     if (STATIC.MASTERFADEARRAY[2] == 1) {
        live.ramp(STATIC.oscSawGain, 0.0, 1.0, STATIC.MASTERFADERATE) => STATIC.oscSawGain => gate.gain;
    }
    // Wait for a beat
    live.Dur(STATIC.TEMPO,STATIC.MEASURE) => now;
}

