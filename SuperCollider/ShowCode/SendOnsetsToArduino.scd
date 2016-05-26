(
//specify the net address of Python
~python = NetAddr("127.0.0.1",7002);

//synthDef to send a trigger when full stop is pressed
SynthDef(\sendTrig,{
    SendTrig.kr(KeyState.kr(60, 0, 1, 0),0,1);
}).send(s);

~index = 0;
~valuearray = Array.fill(11,1000);
~onsetBuf = Buffer.alloc(s,512);
~loudnessBuf = Buffer.alloc(s,1024);
~onset1 = { var sig, chain, onsets, loudness, pitch;
	sig = SoundIn.ar;
	chain = FFT(~onsetBuf,sig);
	onsets = SendReply.kr(Onsets.kr(chain,1.2,\rcomplex),'/onset',
		loudness = (Loudness.kr(FFT(~loudnessBuf,SoundIn.ar(0))))/60
	);
};
~iter = { |in| in = in+1; if ( in >= 11, {~index = 0},{~index = in})};
~onset1.play;
OSCdef(\onsetresponder,
	{|msg|
		~iter.value(~index);
		if (msg[3] > 0.05 ,
			{if (~index <= 1,
			{~valuearray[~index] = msg[3].explin(0.05,0.48,400,2)},
			{~valuearray[~index] = msg[3].explin(0.05,0.48,4000,50)});
		"grabbed: ".post;
			msg[3].postln;});
},'/onset');

//function to send thearray to Arduino
~sendToArduino = OSCFunc({ arg msg, time;
	~python.sendMsg("/soundInfo/array",~valuearray[0].asInt,~valuearray[1].asInt,~valuearray[2].asInt,~valuearray[3].asInt,~valuearray[4].asInt,~valuearray[5].asInt,~valuearray[6].asInt,~valuearray[7].asInt,~valuearray[8].asInt,~valuearray[9].asInt,~valuearray[10].asInt);
	"sent!".postln;
},'/tr');

//activate the synth
Synth(\sendTrig);
)