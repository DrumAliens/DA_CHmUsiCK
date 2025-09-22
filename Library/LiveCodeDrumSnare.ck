Chmusick live => JCRev rev => Gain gate => dac;

16 => int divOneBar;
divOneBar+divOneBar => int divTwoBar;
divTwoBar+divOneBar => int divThreeBar;
divTwoBar+divTwoBar => int divFourBar;


0.5 => gate.gain;
0.10 => rev.mix;

// DRUMS

// Tweak the frequency of the high hats
1.135716 => float hatsRatio;
0.7 => float hatsGain;
1 => float snareGain;
1 => float kickGain;

//spork~live.play(Buffer.kick,live.fill([0,3,6,11,15],divOneBar),kickGain);
spork~live.play(Buffer.snare,live.join([4,12],[4,12,14],divOneBar),STATIC.oscDataA[1]*snareGain/100.0);

while(true){
    //<<< STATIC.oscDataA[0] >>>;
    live.Dur(STATIC.TEMPO,STATIC.MEASURE) => now;
}

