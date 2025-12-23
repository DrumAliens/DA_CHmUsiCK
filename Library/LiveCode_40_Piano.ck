Chmusick live => JCRev rev => Gain gate => dac;

STATIC.oscPianoGain => gate.gain;

// Sort changes to song
STATIC.oscMaster[3] => STATIC.TEMPO;

0.1 => rev.mix;

// KEYBOARD
spork~live.play(Buffer.piano1, STATIC.oscPianoArray, STATIC.oscPianoAmp, STATIC.oscPianoFreq, STATIC.oscPianoMark);
//spork~live.play(Buffer.piano2, STATIC.oscPianoArray, STATIC.oscPianoAmp, STATIC.oscPianoFreq, STATIC.oscPianoMark);

while(true){
    //<<< STATIC.BEATS >>>;
    // Master Fade
    if (STATIC.MASTERFADEARRAY[3] == 1) {
        live.ramp(STATIC.oscPianoGain, 0.0, 1.0, STATIC.MASTERFADERATE) => STATIC.oscPianoGain => gate.gain;
    }
    // Wait for a beat
    live.Dur(STATIC.TEMPO,STATIC.MEASURE) => now;
}

