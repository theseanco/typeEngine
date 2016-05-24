
//this sends a pitch value as an integer to python by using a Dust UGen
(
Task({
	10.wait;
~freq2words = { SendReply.kr(Impulse.kr(57/60),'/freqgrab',Pitch.kr(SoundIn.ar(1))[0])}.play;
OSCdef(\f2wsend,{|msg| ~python.sendMsg("/freq2words",msg[3].asInt); "freq = ".post; msg[3].postln;},'/freqgrab');
~sendToArduino2 = OSCFunc({ arg msg, time;
	~python.sendMsg("/soundInfo/array",~valuearray[0].asInt,~valuearray[1].asInt,~valuearray[2].asInt,~valuearray[3].asInt,~valuearray[4].asInt,~valuearray[5].asInt,~valuearray[6].asInt,~valuearray[7].asInt,~valuearray[8].asInt,~valuearray[9].asInt,~valuearray[10].asInt)},'/fullstop');
	(57/60)*650.wait;
	~freq2words = {SinOsc.kr(0)};
	~sendToArduino2 = OSCFunc({|msg|});
	~onset1.clear;
	OSCdef(\f2wsend,{|msg|},'/freqgrab');
	~python.sendMsg("/soundInfo/array",30000,30000,30000,30000,30000,30000,30000,30000,30000,30000,30000);
	"Done!".postln;
}).start;
)

