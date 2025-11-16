Chmusick live => JCRev rev => Gain gate => dac;
//Chmusick live => LPF lpf => HPF hpf => JCRev rev => Gain gate => dac;

// Sort changes to song
STATIC.oscMaster[3] => STATIC.TEMPO;

// STATIC.oscDrumsAmp => gate.gain;
// STATIC.oscDrumsRev => rev.mix;

// 30000 => lpf.freq;
// 20 => hpf.freq;

0.5 => gate.gain;
0.01 => rev.mix;

//<<<STATIC.BEATS, "Beats">>>;
//<<<STATIC.MEASURES, "Measures">>>;
//<<<STATIC.PHRASES, "Phrases">>>;

// DRUMS
spork~live.play(Buffer.snare, STATIC.oscSnareArray, STATIC.oscSnareAmp, STATIC.oscSnareFreq, STATIC.oscSnareMark);

// spork~live.play(Buffer.hatsGhost2,live.fill([2,6,10,14],divOneBar),STATIC.oscClosedHats[1]*hatsGain/100.0,hatsRatio);
// spork~live.play(Buffer.hatsGhost3,live.join([3,7,11,15],[3,7,11],divOneBar),STATIC.oscClosedHats[1]*hatsGain/100.0,hatsRatio);

while(true){
    //<<< STATIC.BEATS >>>;
    live.Dur(STATIC.TEMPO,STATIC.MEASURE) => now;
}

