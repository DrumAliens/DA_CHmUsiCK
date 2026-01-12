Chmusick live; // => JCRev rev => Gain gate => dac;
//Chmusick live => LPF lpf => HPF hpf => JCRev rev => Gain gate => dac;

// 30000 => lpf.freq;
// 20 => hpf.freq;

// Sort changes to song
STATIC.oscMaster[3] => STATIC.TEMPO;

JCRev rev;
0.02 => rev.mix;

LPF sawHPF;
50 => sawHPF.freq;
0.4 => sawHPF.Q;

Gain gate;
STATIC.oscSawGain => gate.gain;

// KEYBOARD
// SawOsc saw0 => sawHPF => rev => gate => dac;
// SawOsc saw1 => sawHPF => rev => gate => dac;
// SawOsc saw2 => sawHPF => rev => gate => dac;
// SawOsc saw3 => sawHPF => rev => gate => dac;

SawOsc saw0 => rev => gate => dac;
SawOsc saw1 => rev => gate => dac;
SawOsc saw2 => rev => gate => dac;
SawOsc saw3 => rev => gate => dac;

// HevyMetl saw0 => rev => gate => dac;
// HevyMetl saw1 => rev => gate => dac;
// HevyMetl saw2 => rev => gate => dac;
// HevyMetl saw3 => rev => gate => dac;

// FMVoices saw0 => rev => gate => dac;
// FMVoices saw1 => rev => gate => dac;
// FMVoices saw2 => rev => gate => dac;
// FMVoices saw3 => rev => gate => dac;

// BeeThree saw0 => rev => gate => dac;
// BeeThree saw1 => rev => gate => dac;
// BeeThree saw2 => rev => gate => dac;
// BeeThree saw3 => rev => gate => dac;

// Rhodey saw0 => rev => gate => dac;
// Rhodey saw1 => rev => gate => dac;
// Rhodey saw2 => rev => gate => dac;
// Rhodey saw3 => rev => gate => dac;

// Moog saw0 => rev => gate => dac;
// Moog saw1 => rev => gate => dac;
// Moog saw2 => rev => gate => dac;
// Moog saw3 => rev => gate => dac;

spork~live.play(saw0,STATIC.oscSaw0Array,STATIC.oscSaw0Amp, STATIC.oscSaw0Mark);
spork~live.play(saw1,STATIC.oscSaw1Array,STATIC.oscSaw1Amp, STATIC.oscSaw1Mark);
spork~live.play(saw2,STATIC.oscSaw2Array,STATIC.oscSaw2Amp, STATIC.oscSaw2Mark);
spork~live.play(saw3,STATIC.oscSaw3Array,STATIC.oscSaw3Amp, STATIC.oscSaw3Mark);

while(true){
    //<<< STATIC.BEATS >>>;
    // Master Fade
     if (STATIC.MASTERFADEARRAY[2] == 1) {
        live.ramp(STATIC.oscSawGain, 0.0, 1.0, STATIC.MASTERFADERATE) => STATIC.oscSawGain => gate.gain;
    }
    // Wait for a beat
    live.Dur(STATIC.TEMPO,STATIC.MEASURE) => now;
}

