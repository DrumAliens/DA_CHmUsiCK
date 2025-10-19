Chmusick live => JCRev rev => Gain gate => dac;
//Chmusick live => LPF lpf => HPF hpf => JCRev rev => Gain gate => dac;
Notes notes;

// 30000 => lpf.freq;
// 20 => hpf.freq;

0.04 => rev.mix;

// Sort changes to song
STATIC.oscMaster[3] => STATIC.TEMPO;

// VOCAL
if (STATIC.oscChop3Amp > 0.0) spork~live.play(Buffer.chop3,STATIC.oscChop3Array,STATIC.oscChop3Amp,STATIC.oscChop3Freq);

while(true){
    //<<< STATIC.BEATS >>>;
    live.Dur(STATIC.TEMPO,STATIC.MEASURE) => now;
}

