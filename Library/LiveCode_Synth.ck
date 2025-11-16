Chmusick live => JCRev rev => Gain gate => dac;
//Chmusick live => LPF lpf => HPF hpf => JCRev rev => Gain gate => dac;

// 30000 => lpf.freq;
// 20 => hpf.freq;

// Sort changes to song
STATIC.oscMaster[3] => STATIC.TEMPO;

// 16 => int divOneBar;
// divOneBar+divOneBar => int divTwoBar;
// divTwoBar+divOneBar => int divThreeBar;
// divTwoBar+divTwoBar => int divFourBar;

//SinOsc bass;
SawOsc melody;

10 => int numSawVoices;
0.008 => float stdGain;
SawOsc saw[numSawVoices];

0.18 => melody.gain;
0.02 => rev.mix;

LPF sawLPF;
700 => sawLPF.freq;
0.4 => sawLPF.Q;

for (0 => int i; i < 10; i++) {
    saw[i] => sawLPF => dac;
    0 => saw[i].gain;
}

//<<<STATIC.BEATS, "Beats">>>;
//<<<STATIC.MEASURES, "Measures">>>;
//<<<STATIC.PHRASES, "Phrases">>>;

// KEYBOARD

0.003 => float sawGain;
spork~live.play(saw[0],STATIC.oscSaw0Array,STATIC.oscSaw0Amp*sawGain, STATIC.oscSaw0Mark);
spork~live.play(saw[1],STATIC.oscSaw1Array,STATIC.oscSaw1Amp*sawGain, STATIC.oscSaw1Mark);
spork~live.play(saw[2],STATIC.oscSaw2Array,STATIC.oscSaw2Amp*sawGain, STATIC.oscSaw2Mark);
spork~live.play(saw[3],STATIC.oscSaw3Array,STATIC.oscSaw3Amp*sawGain, STATIC.oscSaw3Mark);

while(true){
    //<<< STATIC.BEATS >>>;
    live.Dur(STATIC.TEMPO,STATIC.MEASURE) => now;
}

