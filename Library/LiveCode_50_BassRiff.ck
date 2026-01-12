Chmusick live => Gain gate => dac;

// Sort changes to song
STATIC.oscMaster[3] => STATIC.TEMPO;

STATIC.oscBassRiffGain => gate.gain;

// Bass Riff
SndBuf bassRiff;

// Select the correct bass Riff default is the first riff
Buffer.bassRiff1 @=> bassRiff;
if (STATIC.oscBassRiffPhrase == 2) {
    Buffer.bassRiff2 @=> bassRiff;
}    
else if (STATIC.oscBassRiffPhrase == 3) {
    Buffer.bassRiff3 @=> bassRiff;
}
else if (STATIC.oscBassRiffPhrase == 4) {
    Buffer.bassRiff4 @=> bassRiff;
}
// else if (STATIC.oscBassRiffPhrase == 5) {
//     Buffer.bassRiff5 @=> bassRiff;
// }
// else if (STATIC.oscBassRiffPhrase == 6) {
//     Buffer.bassRiff6 @=> bassRiff;
// }

spork~live.play(bassRiff, STATIC.oscBassRiffArray, STATIC.oscBassRiffAmp, STATIC.oscBassRiffFreq, STATIC.oscBassRiffMark);

while(true){
    //<<< STATIC.BEATS >>>;
    // Master Fade
    if (STATIC.MASTERFADEARRAY[4] == 1) {
        live.ramp(STATIC.oscBassRiffGain, 0.0, 1.0, STATIC.MASTERFADERATE) => STATIC.oscBassRiffGain => gate.gain;
    }
    // Wait for a beat
    live.Dur(STATIC.TEMPO,STATIC.MEASURE) => now;
}

