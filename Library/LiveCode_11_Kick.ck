Chmusick live => JCRev rev => Gain gate => dac;

// Sort changes to song
STATIC.oscMaster[3] => STATIC.TEMPO;

STATIC.oscKickGain => gate.gain;
0.01 => rev.mix;

// DRUMS
0.5 => float localGain;
spork~live.play(Buffer.kick, STATIC.oscKickArray, STATIC.oscKickAmp * localGain, STATIC.oscKickFreq, STATIC.oscKickMark);

while(true){
    //<<< STATIC.BEATS >>>;
    if (STATIC.MASTERFADEARRAY[0] == 1) {
        live.ramp(STATIC.oscKickGain, 0.0, 1.0, STATIC.MASTERFADERATE) => STATIC.oscKickGain => gate.gain;
    }
    // Wait for a beat
    live.Dur(STATIC.TEMPO,STATIC.MEASURE) => now;
}

