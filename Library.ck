Machine.add(me.dir() + "/Library/STATIC.ck");
Machine.add(me.dir() + "/Library/Buffer.ck");
//Machine.add(me.dir() + "/Library/NotesClass.ck");  /// Currently used in CHmUsiK
Machine.add(me.dir() + "/Library/CHmUsiCK.ck");
Machine.add(me.dir() + "/Library/SyncClass.ck");

// Call OscRecvr.ck to read in the OSC data  
Machine.add(me.dir() + "/Library/OscRecvr.ck");

// Call OscTransmt.ck to send out OSC data  
Machine.add(me.dir() + "/Library/OscTrnsmt.ck");

// Presumably can use static to share data between them not sure
Machine.add(me.dir() + "/Library/LoopByCounter.ck");


