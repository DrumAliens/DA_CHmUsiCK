Chmusick live => JCRev rev => Gain gate => dac;

16 => int divOneBar;
divOneBar+divOneBar => int divTwoBar;
divTwoBar+divOneBar => int divThreeBar;
divTwoBar+divTwoBar => int divFourBar;

// 4 => STATIC.CYCLES;
// 4 => STATIC.MEASURE;
// 95 => STATIC.TEMPO;
0.5 => gate.gain;
0.10 => rev.mix;

// DRUMS

// Tweak the frequency of the high hats
1.135716 => float hatsRatio;
0.7 => float hatsGain;
1 => float snareGain;
1 => float kickGain;

spork~live.play(Buffer.kick,live.fill([0,3,6,11,15],divOneBar),STATIC.oscDataB[1]*snareGain/100.0);

while(true){
    //<<< STATIC.MEASURES >>>;
    live.Dur(STATIC.TEMPO,STATIC.MEASURE) => now;
}

