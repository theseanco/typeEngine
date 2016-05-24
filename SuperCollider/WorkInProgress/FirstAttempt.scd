
/*

What I need to do:

Grab SoundIn from an input

Read it into a circular buffer

Convert that into some kind of data

Send that data to arduino

Detect onsets, when an onset is detected send a byte?

*/

(
~buf = Buffer.alloc(s,44100*10);
{RecordBuf.ar(SoundIn.ar(0),~buf,0,1,0,1,1,1,0)}.play;
)


Onsets











