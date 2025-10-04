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
spork~live.play(Buffer.kick, STATIC.oscKickArray, STATIC.oscKickAmp, STATIC.oscKickFreq);
spork~live.play(Buffer.snare, STATIC.oscSnareArray, STATIC.oscSnareAmp, STATIC.oscSnareFreq);
spork~live.play(Buffer.hatsOpen, STATIC.oscOpenHatsArray, STATIC.oscOpenHatsAmp, STATIC.oscOpenHatsFreq);
spork~live.play(Buffer.hatsSplash, STATIC.oscSplashArray, STATIC.oscSplashAmp, STATIC.oscSplashFreq);
spork~live.play(Buffer.hatsGhost1, STATIC.oscClosedHatsArray, STATIC.oscClosedHatsAmp, STATIC.oscClosedHatsFreq);
// spork~live.play(Buffer.hatsGhost2,live.fill([2,6,10,14],divOneBar),STATIC.oscClosedHats[1]*hatsGain/100.0,hatsRatio);
// spork~live.play(Buffer.hatsGhost3,live.join([3,7,11,15],[3,7,11],divOneBar),STATIC.oscClosedHats[1]*hatsGain/100.0,hatsRatio);

// VOCALS
spork~live.play(Buffer.chop1,STATIC.oscChop1Array,STATIC.oscChop1Amp,STATIC.oscChop1Freq);
spork~live.play(Buffer.chop1,STATIC.oscChop2Array,STATIC.oscChop2Amp,STATIC.oscChop2Freq);
spork~live.play(Buffer.chop3,STATIC.oscChop3Array,STATIC.oscChop3Amp,STATIC.oscChop3Freq);
spork~live.play(Buffer.chop4,STATIC.oscChop4Array,STATIC.oscChop4Amp,STATIC.oscChop4Freq);
spork~live.play(Buffer.chop5,STATIC.oscChop5Array,STATIC.oscChop5Amp,STATIC.oscChop5Freq);
spork~live.play(Buffer.chop1,STATIC.oscChop6Array,STATIC.oscChop6Amp,STATIC.oscChop6Freq);
spork~live.play(Buffer.chop7,STATIC.oscChop7Array,STATIC.oscChop7Amp,STATIC.oscChop7Freq);

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

