//----------------------------------------------------------------------------
// desc: OpenSoundControl (OSC) Transmit example
// note: launch with s.ck (or another sender)
//----------------------------------------------------------------------------

Chmusick live;

// Osc sender object
OscOut oscOut;
// Aim the transmitter to a destination
oscOut.dest( STATIC.sendNetworkPort, 49163);

99999 => int currentPhrase;

// infinite event loop
while( true )
{

  // Wait a beat to check for a change
  live.convert(STATIC.TEMPO) => now;

  if (currentPhrase != STATIC.PHRASES) {

    // Setup OSC message
    oscOut.start( "/song/master/phrase" );
    STATIC.PHRASES => oscOut.add;
    oscOut.send();
  
    // Update current phrase
    STATIC.PHRASES => currentPhrase;
   
  }
}
