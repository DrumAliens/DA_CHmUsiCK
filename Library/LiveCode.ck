Chmusick live => JCRev rev => Gain gate => dac;
Notes notes;

// Sort changes to song
STATIC.oscMaster[3] => STATIC.TEMPO;

16 => int divOneBar;
divOneBar+divOneBar => int divTwoBar;
divTwoBar+divOneBar => int divThreeBar;
divTwoBar+divTwoBar => int divFourBar;

SinOsc bass;
SawOsc melody;

10 => int numSawVoices;
0.008 => float stdGain;
SawOsc saw[numSawVoices];

LPF sawLPF;
700 => sawLPF.freq;
0.4 => sawLPF.Q;

for (0 => int i; i < 10; i++) {
    saw[i] => sawLPF => dac;
    0 => saw[i].gain;
}

0.5 => gate.gain;
0.00 => rev.mix;
0.18 => melody.gain;

//<<<STATIC.BEATS, "Beats">>>;
//<<<STATIC.MEASURES, "Measures">>>;
//<<<STATIC.PHRASES, "Phrases">>>;

// DRUMS

// Tweak the frequency of the high hats
1.135716 => float hatsRatio;
0.7 => float hatsGain;
1 => float snareGain;
1 => float kickGain;

spork~live.play(Buffer.kick, STATIC.oscKickArray, STATIC.oscKickAmp*kickGain/100.0);
spork~live.play(Buffer.snare, STATIC.oscSnareArray, STATIC.oscSnareAmp*snareGain/100.0);
spork~live.play(Buffer.hatsOpen, STATIC.oscOpenHatsArray, STATIC.oscOpenHatsAmp*hatsGain/100.0, hatsRatio);
spork~live.play(Buffer.hatsSplash, STATIC.oscSplashArray, STATIC.oscSplashAmp*hatsGain/100.0, hatsRatio);
spork~live.play(Buffer.hatsGhost1, STATIC.oscClosedHatsArray, STATIC.oscClosedHatsAmp*hatsGain/100.0, hatsRatio);
// spork~live.play(Buffer.hatsGhost2,live.fill([2,6,10,14],divOneBar),STATIC.oscClosedHats[1]*hatsGain/100.0,hatsRatio);
// spork~live.play(Buffer.hatsGhost3,live.join([3,7,11,15],[3,7,11],divOneBar),STATIC.oscClosedHats[1]*hatsGain/100.0,hatsRatio);

// VOCALS
0.5 => float vocalGain;
1.05 => float vocalRatio;

live.copy(live.fill([0],divOneBar),4) @=> int chop1Array[]; 

// live.join(live.fill([2],divOneBar),
//           live.fill([2],divOneBar),
//           live.fill([2],divOneBar),
//           live.fill([2],divOneBar)) @=> int chop5Array[]; 
live.fill([2],divOneBar) @=> int chop5Array[]; 

live.join(live.fill([4,12],divOneBar),
          live.fill([4,12],divOneBar),
          live.fill([4,12],divOneBar),
          live.fill([4,12],divOneBar)) @=> int chop3Array[]; 

live.join(live.fill([9],divOneBar),
          live.fill([9],divOneBar),
          live.fill([9],divOneBar),
          live.fill([9],divOneBar)) @=> int chop4Array[]; 

live.join(live.fill([14],divOneBar),
          live.fill([14],divOneBar),
          live.fill([14],divOneBar),
          live.fill([14],divOneBar)) @=> int chop7Array[]; 

spork~live.play(Buffer.chop1,chop1Array,vocalGain,vocalRatio);
spork~live.play(Buffer.chop5,chop5Array,vocalGain,vocalRatio);
spork~live.play(Buffer.chop3,chop3Array,vocalGain*.75,vocalRatio);
spork~live.play(Buffer.chop4,chop4Array,vocalGain,vocalRatio);
spork~live.play(Buffer.chop7,chop7Array,vocalGain*.75,vocalRatio);

// KEYBOARD

[-2,5,9,10,11,14,15] @=> int maskArray1[];
[-2,5,9,10,11] @=> int maskArray2[];
[-2,5,9,10,11,14,15] @=> int maskArray3[];
[2,5,9,10,11] @=> int maskArray4[];

live.join(live.mask(44,maskArray1,divOneBar),
          live.mask(41,maskArray2,divOneBar),
          live.mask(43,maskArray3,divOneBar),
          live.mask(36,maskArray4,divOneBar))  @=> int sawVoices0[];

live.join(live.mask(56,maskArray1,divOneBar),
          live.mask(55,maskArray2,divOneBar),
          live.mask(58,maskArray3,divOneBar),
          live.mask(56,maskArray4,divOneBar))  @=> int sawVoices1[];

live.join(live.mask(60,maskArray1,divOneBar),
          live.mask(60,maskArray2,divOneBar),
          live.mask(62,maskArray3,divOneBar),
          live.mask(60,maskArray4,divOneBar))  @=> int sawVoices2[];

live.join(live.mask(63,maskArray1,divOneBar),
          live.mask(63,maskArray2,divOneBar),
          live.mask(65,maskArray3,divOneBar),
          live.mask(64,maskArray4,divOneBar))  @=> int sawVoices3[];

live.join(live.mask(67,maskArray1,divOneBar),
          live.mask(67,maskArray2,divOneBar),
          live.mask(69,maskArray3,divOneBar),
          live.mask(68,maskArray4,divOneBar))  @=> int sawVoices4[];

0.003 => float sawGain;
spork~live.play(saw[0],sawVoices0,sawGain);
spork~live.play(saw[1],sawVoices1,sawGain);
spork~live.play(saw[2],sawVoices2,sawGain);
spork~live.play(saw[3],sawVoices3,sawGain);
spork~live.play(saw[4],sawVoices4,sawGain);

while(true){
    //<<< STATIC.MEASURES >>>;
    live.Dur(STATIC.TEMPO,STATIC.MEASURE) => now;
}

