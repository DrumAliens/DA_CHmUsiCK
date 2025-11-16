public class Buffer extends Chugraph{

    new SndBuf @=> static SndBuf @ kick;
    new SndBuf @=> static SndBuf @ snare;
    new SndBuf @=> static SndBuf @ hatsOpen;
    new SndBuf @=> static SndBuf @ hatsSplash;
    new SndBuf @=> static SndBuf @ hatsGhost1;
    new SndBuf @=> static SndBuf @ hatsGhost2;
    new SndBuf @=> static SndBuf @ hatsGhost3;
    new SndBuf @=> static SndBuf @ chop1;
    new SndBuf @=> static SndBuf @ chop2;
    new SndBuf @=> static SndBuf @ chop3;
    new SndBuf @=> static SndBuf @ chop4;
    new SndBuf @=> static SndBuf @ chop5;
    new SndBuf @=> static SndBuf @ chop6;
    new SndBuf @=> static SndBuf @ chop7;
    new SndBuf @=> static SndBuf @ chop8;
    new SndBuf @=> static SndBuf @ piano;
    new SndBuf @=> static SndBuf @ dogSolo;
    new SndBuf @=> static SndBuf @ dogPack;

    file("resources","kick") => kick.read;
    file("resources","snare") => snare.read;
    file("resources","hatsOpen") => hatsOpen.read;
    file("resources","hatsSplash") => hatsSplash.read;
    file("resources","hatsGhost1") => hatsGhost1.read;
    file("resources","hatsGhost2") => hatsGhost2.read;
    file("resources","hatsGhost3") => hatsGhost3.read;
    file("resources","chop1") => chop1.read;
    file("resources","chop2") => chop2.read;
    file("resources","chop3") => chop3.read;
    file("resources","chop4Mod") => chop4.read;
    file("resources","chop5") => chop5.read;
    file("resources","chop6") => chop6.read;
    file("resources","chop7") => chop7.read;
    file("resources","chop8") => chop8.read;

    file("resources","11627__techsetsu__grandmithers-piano-08") => piano.read;
    // file("resources","11628__techsetsu__grandmithers-piano-09") => piano.read;

    //file("resources","11646__techsetsu__grandmithers-piano-27") => piano.read;
    //file("resources","11632__techsetsu__grandmithers-piano-13") => piano.read;
    //file("resources","11634__techsetsu__grandmithers-piano-15") => piano.read;
    //file("resources","11637__techsetsu__grandmithers-piano-18") => piano.read;
    //file("resources","334534__teddy_frost__piano-a4-sound") => piano.read;

    //file("resources","254285__jagadamba__vocal-ooaahh-male-voice") => scream.read;
    file("resources","418107__crazymonke9__single-dog-bark-1") => dogSolo.read;
    // file("resources","343868__reitanna_hoo-hoo_MOD") => scream.read;

    file("resources","401259__mystikuum__dogs_barking_stereo_4824") => dogPack.read;

     
    fun string file(string name, string letter)
    {
        me.dir() + "Samples/" + name + "/" + letter + ".wav" => string fileName; //Mac/Linux conflict with path
        //"Samples/" + name + "/" + letter + ".wav" => fileName; //Mac/Linux conflict with path
        return fileName;
    }
   
}

//0 => Buffer.buffer17Status;
