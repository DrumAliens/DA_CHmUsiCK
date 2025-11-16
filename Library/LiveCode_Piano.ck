Chmusick live => JCRev rev => Gain gate => dac;
//Chmusick live => LPF lpf => HPF hpf => JCRev rev => Gain gate => dac;

// 30000 => lpf.freq;
// 20 => hpf.freq;

// Sort changes to song
STATIC.oscMaster[3] => STATIC.TEMPO;

0.02 => rev.mix;


// KEYBOARD
spork~live.play(Buffer.piano, STATIC.oscPianoArray, STATIC.oscPianoAmp, STATIC.oscPianoFreq, STATIC.oscPianoMark);

while(true){
    //<<< STATIC.BEATS >>>;
    live.Dur(STATIC.TEMPO,STATIC.MEASURE) => now;
}

