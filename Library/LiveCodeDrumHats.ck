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

spork~live.play(Buffer.hatsOpen,live.fill([0,4,8,12],divOneBar),STATIC.oscDataC[1]*hatsGain/100.0,hatsRatio);
spork~live.play(Buffer.hatsSplash,live.fill([30],divTwoBar),STATIC.oscDataC[1]*hatsGain/100.0);
spork~live.play(Buffer.hatsGhost1,live.fill([1,5,9,13],divOneBar),STATIC.oscDataC[1]*hatsGain/100.0,hatsRatio);
spork~live.play(Buffer.hatsGhost2,live.fill([2,6,10,14],divOneBar),STATIC.oscDataC[1]*hatsGain/100.0,hatsRatio);
spork~live.play(Buffer.hatsGhost3,live.join([3,7,11,15],[3,7,11],divOneBar),STATIC.oscDataC[1]*hatsGain/100.0,hatsRatio);

while(true){
    //<<< STATIC.oscDataA[0] >>>;
    live.Dur(STATIC.TEMPO,STATIC.MEASURE) => now;
}

