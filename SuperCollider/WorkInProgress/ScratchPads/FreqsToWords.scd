/*

Writing a script to turn frequencies into words, for the second part of the performance

*/


//this sends a pitch value as an integer to python by using a Dust UGen
(
~python = NetAddr("127.0.0.1",7002);
~freq2words = { SendReply.kr(Dust.kr(1.2),'/freqgrab',Pitch.kr(SoundIn.ar(1))[0])}.play;
OSCdef(\f2wsend,{|msg| ~python.sendMsg("/freq2words",msg[3].asInt); "freq = ".post; msg[3].postln;},'/freqgrab');

//This is a function which grabs information about whether there is a full stop or not from Python, then if there is, sends data on to Arduino.
~sendToArduino2 = OSCFunc({ arg msg, time;
	~python.sendMsg("/soundInfo/array",~valuearray[0].asInt,~valuearray[1].asInt,~valuearray[2].asInt,~valuearray[3].asInt,~valuearray[4].asInt,~valuearray[5].asInt,~valuearray[6].asInt,~valuearray[7].asInt,~valuearray[8].asInt,~valuearray[9].asInt,~valuearray[10].asInt)},'/fullstop');
)
