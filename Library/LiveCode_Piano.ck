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


0.02 => rev.mix;

//<<<STATIC.BEATS, "Beats">>>;
//<<<STATIC.MEASURES, "Measures">>>;
//<<<STATIC.PHRASES, "Phrases">>>;

// KEYBOARD

spork~live.play(Buffer.piano, STATIC.oscPianoArray, STATIC.oscPianoAmp, STATIC.oscPianoFreq);

while(true){
    //<<< STATIC.BEATS >>>;
    live.Dur(STATIC.TEMPO,STATIC.MEASURE) => now;
}

