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

    0.0 => static float MASTERFADERATE;
    static int MASTERFADEARRAY[8];

    "127.0.0.1" @=> static string sendNetworkPort;

    9999999 => static int MAXINT;

    // Osc Receive Flag
    static int oscMsgKickRecvr;
    static int oscMsgSnareRecvr;
    static int oscMsgOpenHatsRecvr;
    static int oscMsgClosedHatsRecvr;
    static int oscMsgSplashRecvr;
    static int oscMsgSynthRecvr;
    static int oscMsgPianoRecvr;
    static int oscMsgMstrRecvr;
    static int oscMsgChop1Recvr;
    static int oscMsgChop2Recvr;
    static int oscMsgChop3Recvr;
    static int oscMsgChop4Recvr;
    static int oscMsgChop5Recvr;
    static int oscMsgChop6Recvr;
    static int oscMsgChop7Recvr;
    static int oscMsgBassRiffRecvr;
    static int oscMsgDogPackRecvr;
    static int oscMsgFadeRecvr;
         
    // Information transmitted over OSC
    static int oscMaster[8];

    static float oscKickAmp;
    static float oscKickFreq;
    MAXINT => static int oscKickMark;
    static int oscKickArray[DIVISION*CYCLES];
    1.0 => static float oscKickGain;

    static float oscSnareAmp;
    static float oscSnareFreq;
    MAXINT => static int oscSnareMark;
    static int oscSnareArray[DIVISION*CYCLES];
    1.0 => static float oscSnareGain;
        
    static float oscOpenHatsAmp;
    static float oscOpenHatsFreq;
    MAXINT => static int oscOpenHatsMark;
    static int oscOpenHatsArray[DIVISION*CYCLES];
    static float oscClosedHatsAmp;
    static float oscClosedHatsFreq;
    MAXINT => static int oscClosedHatsMark;
    static int oscClosedHatsArray[DIVISION*CYCLES];
    static float oscSplashAmp;
    static float oscSplashFreq;
    MAXINT => static int oscSplashMark;
    static int oscSplashArray[DIVISION*CYCLES];
    1.0 => static float oscCymbalGain;
   
    static float oscSaw0Amp;
    static float oscSaw0Freq;
    MAXINT => static int oscSaw0Mark;
    static int oscSaw0Array[DIVISION*CYCLES];
    static float oscSaw1Amp;
    static float oscSaw1Freq;
    MAXINT => static int oscSaw1Mark;
    static int oscSaw1Array[DIVISION*CYCLES];
    static float oscSaw2Amp;
    static float oscSaw2Freq;
    MAXINT => static int oscSaw2Mark;
    static int oscSaw2Array[DIVISION*CYCLES];
    static float oscSaw3Amp;
    static float oscSaw3Freq;
    MAXINT => static int oscSaw3Mark;
    static int oscSaw3Array[DIVISION*CYCLES];
    1.0 => static float oscSawGain;

    static float oscPianoAmp;
    static float oscPianoFreq;
    MAXINT => static int oscPianoMark;
    static int oscPianoArray[DIVISION*CYCLES];
    1.0 => static float oscPianoGain;
    
    static float oscChop1Amp;
    static float oscChop1Freq;
    MAXINT => static int oscChop1Mark;
    static int oscChop1Array[DIVISION*CYCLES];
    static float oscChop2Amp;
    static float oscChop2Freq;
    MAXINT => static int oscChop2Mark;
    static int oscChop2Array[DIVISION*CYCLES];
    static float oscChop3Amp;
    static float oscChop3Freq;
    MAXINT => static int oscChop3Mark;
    static int oscChop3Array[DIVISION*CYCLES];
    static float oscChop4Amp;
    static float oscChop4Freq;
    MAXINT => static int oscChop4Mark;
    static int oscChop4Array[DIVISION*CYCLES];
    static float oscChop5Amp;
    static float oscChop5Freq;
    MAXINT => static int oscChop5Mark;
    static int oscChop5Array[DIVISION*CYCLES];
    static float oscChop6Amp;
    static float oscChop6Freq;
    MAXINT => static int oscChop6Mark;
    static int oscChop6Array[DIVISION*CYCLES];
    static float oscChop7Amp;
    static float oscChop7Freq;
    MAXINT => static int oscChop7Mark;
    static int oscChop7Array[DIVISION*CYCLES];
    1.0 => static float oscChop1Gain;
    1.0 => static float oscChop2Gain;
    1.0 => static float oscChop3Gain;
    1.0 => static float oscChop4Gain;
    1.0 => static float oscChop5Gain;
    1.0 => static float oscChop6Gain;
    1.0 => static float oscChop7Gain;

    static float oscBassRiffAmp;
    static float oscBassRiffFreq;
    static int oscBassRiffPhrase;
    MAXINT => static int oscBassRiffMark;
    static int oscBassRiffArray[DIVISION*CYCLES];
    1.0 => static float oscBassRiffGain;

    static float oscDogPackAmp;
    static float oscDogPackFreq;
    MAXINT => static int oscDogPackMark;
    static int oscDogPackArray[DIVISION*CYCLES];
    1.0 => static float oscDogGain;

    static float oscFadeRate;
    static int oscFadeEnbleArray[16];


}
