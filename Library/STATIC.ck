public class STATIC
{
    // Define song parameters
    // 4 => static int MEASURE;
    // 4 => static int CYCLES;
    // 8 => static int STEP;
    // 120 => static float TEMPO;
    // 16 => static int DIVISION;

    // // Variables to keep running score
    -1 => static int BEATS;
    0 => static int MEASURES;
    0 => static int PHRASES;
 
    // Moving all static objects to this class
    4 => static int MEASURE;
    4 => static int CYCLES;
    120 => static float TEMPO;
    16 => static int DIVISION;
    8 => static int STEP;

    // Osc Receive Flag
    static int oscMsgDrumsRecvr;
    static int oscMsgSynthRecvr;
    static int oscMsgPianoRecvr;
    static int oscMsgMstrRecvr;
    static int oscMsgChops1Recvr;
    static int oscMsgChops2Recvr;
    static int oscMsgChops3Recvr;
    static int oscMsgChops4Recvr;
    static int oscMsgChops5Recvr;
    static int oscMsgChops6Recvr;
    static int oscMsgChops7Recvr;
     
    // Information transmitted over OSC
    static int oscMaster[8];

    static float oscKickAmp;
    static float oscKickFreq;
    static int oscKickArray[DIVISION*CYCLES];
    static float oscSnareAmp;
    static float oscSnareFreq;
    static int oscSnareArray[DIVISION*CYCLES];
    static float oscOpenHatsAmp;
    static float oscOpenHatsFreq;
    static int oscOpenHatsArray[DIVISION*CYCLES];
    static float oscClosedHatsAmp;
    static float oscClosedHatsFreq;
    static int oscClosedHatsArray[DIVISION*CYCLES];
    static float oscSplashAmp;
    static float oscSplashFreq;
    static int oscSplashArray[DIVISION*CYCLES];

    static float oscSaw0Amp;
    static float oscSaw0Freq;
    static int oscSaw0Array[DIVISION*CYCLES];
    static float oscSaw1Amp;
    static float oscSaw1Freq;
    static int oscSaw1Array[DIVISION*CYCLES];
    static float oscSaw2Amp;
    static float oscSaw2Freq;
    static int oscSaw2Array[DIVISION*CYCLES];
    static float oscSaw3Amp;
    static float oscSaw3Freq;
    static int oscSaw3Array[DIVISION*CYCLES];
    static float oscPianoAmp;
    static float oscPianoFreq;
    static int oscPianoArray[DIVISION*CYCLES];
    
    static float oscChop1Amp;
    static float oscChop1Freq;
    static int oscChop1Array[DIVISION*CYCLES];
    static float oscChop2Amp;
    static float oscChop2Freq;
    static int oscChop2Array[DIVISION*CYCLES];
    static float oscChop3Amp;
    static float oscChop3Freq;
    static int oscChop3Array[DIVISION*CYCLES];
    static float oscChop4Amp;
    static float oscChop4Freq;
    static int oscChop4Array[DIVISION*CYCLES];
    static float oscChop5Amp;
    static float oscChop5Freq;
    static int oscChop5Array[DIVISION*CYCLES];
    static float oscChop6Amp;
    static float oscChop6Freq;
    static int oscChop6Array[DIVISION*CYCLES];
    static float oscChop7Amp;
    static float oscChop7Freq;
    static int oscChop7Array[DIVISION*CYCLES];
  
}
