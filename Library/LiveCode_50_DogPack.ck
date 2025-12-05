Chmusick live => Gain gate => dac;

// Sort changes to song
STATIC.oscMaster[3] => STATIC.TEMPO;

STATIC.oscDogGain => gate.gain;

// DRUMS
spork~live.play(Buffer.dogPack, STATIC.oscDogPackArray, STATIC.oscDogPackAmp, STATIC.oscDogPackFreq, STATIC.oscDogPackMark);

while(true){
    //<<< STATIC.BEATS >>>;
    // Master Fade
    if (STATIC.MASTERFADEARRAY[4] == 1) {
        live.ramp(STATIC.oscDogGain, 0.0, 1.0, STATIC.MASTERFADERATE) => STATIC.oscDogGain => gate.gain;
    }
    // Wait for a beat
    live.Dur(STATIC.TEMPO,STATIC.MEASURE) => now;
}

