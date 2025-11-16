Chmusick live => Gain gate => dac;
//Chmusick live => LPF lpf => HPF hpf => JCRev rev => Gain gate => dac;

// Sort changes to song
STATIC.oscMaster[3] => STATIC.TEMPO;

// STATIC.oscDrumsAmp => gate.gain;
// STATIC.oscDrumsRev => rev.mix;

// 30000 => lpf.freq;
// 20 => hpf.freq;

//<<<STATIC.BEATS, "Beats">>>;
//<<<STATIC.MEASURES, "Measures">>>;
//<<<STATIC.PHRASES, "Phrases">>>;

// DRUMS
spork~live.play(Buffer.dogPack, STATIC.oscDogPackArray, STATIC.oscDogPackAmp, STATIC.oscDogPackFreq, STATIC.oscDogPackMark);

while(true){
    //<<< STATIC.BEATS >>>;
    live.Dur(STATIC.TEMPO,STATIC.MEASURE) => now;
}

