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
    static int oscMsgRecvr;
     
    // Information transmitted over OSC
    static int oscMaster[8];
    static int oscKickAmp;
    static int oscKickArray[DIVISION*CYCLES];
    static int oscSnareAmp;
    static int oscSnareArray[DIVISION*CYCLES];
    static int oscOpenHatsAmp;
    static int oscOpenHatsArray[DIVISION*CYCLES];
    static int oscClosedHatsAmp;
    static int oscClosedHatsArray[DIVISION*CYCLES];
    static int oscSplashAmp;
    static int oscSplashArray[DIVISION*CYCLES];

}
