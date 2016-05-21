//LEP project, typing detection segment.

(
w.front; // something safe to type on
{ SinOsc.ar(550, 0, KeyState.kr(60, 0, 0.1)) }.play;
)

//. is registered as key 60, so that works nicely. Now need a function which will pass values when a full stop is detected.

//Here's a SendTrig as an example

(
SynthDef("help-SendTrig",{
    SendTrig.kr(Dust.kr(1.0),0,0.9);
}).send(s);

o = OSCFunc({ arg msg, time;
    [time, msg].postln;
},'/tr', s.addr);
)


Synth("help-SendTrig");


/*

So according to this...
SendTrig.kr(Dust.kr(1.0),0,0.9);

this sends a trigger of 0.9 whenever the dust triggers something.

So, if i have an array continually being filled by audio data which is stored as a global variable (maybe), then I can pass that array on as a message once the KeyState uGen detects something (in theory)

Here we go.

*/

~array = [40, 409, 209, 200]

(
SynthDef("help-SendTrig",{
    SendTrig.kr(KeyState.kr(60, 0, 1, 0),0,1);
}).send(s);

o = OSCFunc({ arg msg, time;
    [time, msg].postln;
},'/tr', s.addr);


Synth("help-SendTrig");
)

//that appears to send four triggers, rather than passing an array. Hmm.
//Maybe setting up the OSCFunc so that it passes the array WHEN triggered, rather than handling it on the trigger side

~array = [60, 61, 64, 55]

(
SynthDef("help-SendTrig",{
    SendTrig.kr(KeyState.kr(60, 0, 1, 0),0,1);
}).send(s);

o = OSCFunc({ arg msg, time;
    ~array.postln;
},'/tr');


Synth("help-SendTrig");
)

//Need to just pop one o
~python = NetAddr(127.0.0.1,12345);//IP address and port of python
~python.sendMsg("/values",~array);


