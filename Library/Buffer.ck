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
    new SndBuf @=> static SndBuf @ piano1;
    new SndBuf @=> static SndBuf @ piano2;
    new SndBuf @=> static SndBuf @ bassRiff1;
    new SndBuf @=> static SndBuf @ bassRiff2;
    new SndBuf @=> static SndBuf @ bassRiff3;
    new SndBuf @=> static SndBuf @ bassRiff4;
    new SndBuf @=> static SndBuf @ bassRiff5;
    new SndBuf @=> static SndBuf @ bassRiff6;
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
    file("resources","chop4") => chop4.read;
    file("resources","chop5") => chop5.read;
    file("resources","chop6") => chop6.read;
    file("resources","chop7") => chop7.read;
    file("resources","chop8") => chop8.read;

    file("resources","382528__lomographicmusic__piano-41-e5") => piano1.read;
    file("resources","382502__lomographicmusic__piano-14-e4") => piano2.read;
    
    file("resources","401259__mystikuum__dogs_barking_stereo_4824") => dogPack.read;

    file("resources","bassRiffVerse1_v99") => bassRiff1.read;
    file("resources","bassRiffVerse2_v99") => bassRiff2.read;
    file("resources","bassRiffChorusAllHigh_v99") => bassRiff3.read;
    file("resources","bassRiffChorus2_v99") => bassRiff4.read;

    fun string file(string name, string letter)
    {
        me.dir() + "Samples/" + name + "/" + letter + ".wav" => string fileName; //Mac/Linux conflict with path
        //"Samples/" + name + "/" + letter + ".wav" => fileName; //Mac/Linux conflict with path
        return fileName;
    }
   
}

//0 => Buffer.buffer17Status;
