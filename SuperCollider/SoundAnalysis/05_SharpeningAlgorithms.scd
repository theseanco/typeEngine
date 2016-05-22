/*

The above has the propensity to scale the values detected to the higher ranges always, and maybe this is not such a good thing? - do i need an alternative scaling method? Perhaps.

Now going to add the arduino fullstop send script and test the entire setup out.

*/


//THIS WORKS VERY VERY WELL. NICE ONE.
(
//specify the net address of Python
~python = NetAddr("127.0.0.1",7001);

//synthDef to send a trigger when full stop is pressed
SynthDef(\sendTrig,{
    SendTrig.kr(KeyState.kr(60, 0, 1, 0),0,1);
}).send(s);

~lowest = 10.0;
~highest = 10.0;
~valuearray = Array.fill(11,0);
~onsetBuf = Buffer.alloc(s,512);
~loudnessBuf = Buffer.alloc(s,1024);
~onset1 = { var sig, chain, onsets, loudness, pitch;
	sig = SoundIn.ar;
	chain = FFT(~onsetBuf,sig);
	onsets = SendReply.kr(Onsets.kr(chain,0.86,\rcomplex),'/onset',
		((Loudness.kr(FFT(~loudnessBuf,SoundIn.ar(0))))/60) * Pitch.kr(SoundIn.ar,440,10)
	);
};
~iter = { |in| in = in+1; if ( in >= 11, {~index = 0},{~index = in})};
~maxmin = { |in| if ( in < ~lowest, {~lowest = in} ); if ( in > ~highest, {~highest = in})};
~onset1.play;
OSCdef(\onsetresponder,
	{|msg|
		~maxmin.value(msg[3]);
		~iter.value(~index);
		~valuearray[~index] = msg[3].explin(~lowest,~highest,2000,1);
},'/onset');

//function to send thearray to Arduino
~sendToArduino = OSCFunc({ arg msg, time;
	~python.sendMsg("/soundInfo/array",~valuearray[0],~valuearray[1],~valuearray[2],~valuearray[3],~valuearray[4],~valuearray[5],~valuearray[6],~valuearray[7],~valuearray[8],~valuearray[9],~valuearray[10]);
	"sent!".postln;
},'/tr');

//activate the synth
Synth(\sendTrig);
)

/*

The above code works very well, but there's a significant problem with the pitch/amplitude detection, it perhaps isn't necessary to focus on pitch AND amplitude, maybe just the one on the keyboard because the data isn't diverse enough for pitch?

*/

/*

As an amplitude follower, Amplitude is actually great but i have to be quite careful to turn the sensitivity of the microphone up quite high.

*/



//Code with dependency upon pitch removed. I've also upped the threshold of the Onsets UGen to get around false positives and actually reign in the number of to get rid of some false positives, as well as changing Loudness to Amplitude. I have to make sure the contact mic is turned way up in this processs, thats kinda important.
(
//specify the net address of Python
~python = NetAddr("127.0.0.1",7001);

//synthDef to send a trigger when full stop is pressed
SynthDef(\sendTrig,{
    SendTrig.kr(KeyState.kr(60, 0, 1, 0),0,1);
}).send(s);

~lowest = 0.5;
~highest = 0.5;
~valuearray = Array.fill(11,0);
~onsetBuf = Buffer.alloc(s,512);
~onset1 = { var sig, chain, onsets, loudness, pitch;
	sig = SoundIn.ar;
	chain = FFT(~onsetBuf,sig);
	onsets = SendReply.kr(Onsets.kr(chain,1.9,\rcomplex),'/onset',
		Amplitude.kr(SoundIn.ar(0))
	);
};
~iter = { |in| in = in+1; if ( in >= 11, {~index = 0},{~index = in})};
~maxmin = { |in| if ( in < ~lowest, {~lowest = in} ); if ( in > ~highest, {~highest = in})};
~onset1.play;
OSCdef(\onsetresponder,
	{|msg|
		~maxmin.value(msg[3]);
		~iter.value(~index);
		~valuearray[~index] = msg[3].explin(~lowest,~highest,2000,50);
		"grabbed".post;
		rrand(1,10).postln;
},'/onset');

//function to send thearray to Arduino
~sendToArduino = OSCFunc({ arg msg, time;
	~python.sendMsg("/soundInfo/array",~valuearray[0].asInt,~valuearray[1].asInt,~valuearray[2].asInt,~valuearray[3].asInt,~valuearray[4].asInt,~valuearray[5].asInt,~valuearray[6].asInt,~valuearray[7].asInt,~valuearray[8].asInt,~valuearray[9].asInt,~valuearray[10].asInt);
	"sent!".postln;
},'/tr');

//activate the synth
Synth(\sendTrig);
)



/*

The above works, but it could use with an if statement to up the rate of the motors working inside the floppy drives, the relays can be quite slow, for a polymetric effect

*/

(
//specify the net address of Python
~python = NetAddr("127.0.0.1",7001);

//synthDef to send a trigger when full stop is pressed
SynthDef(\sendTrig,{
    SendTrig.kr(KeyState.kr(60, 0, 1, 0),0,1);
}).send(s);

~lowest = 0.5;
~highest = 0.5;
~valuearray = Array.fill(11,0);
~onsetBuf = Buffer.alloc(s,512);
~onset1 = { var sig, chain, onsets, loudness, pitch;
	sig = SoundIn.ar;
	chain = FFT(~onsetBuf,sig);
	onsets = SendReply.kr(Onsets.kr(chain,1.9,\rcomplex),'/onset',
		Amplitude.kr(SoundIn.ar(0))
	);
};
~iter = { |in| in = in+1; if ( in >= 11, {~index = 0},{~index = in})};
~maxmin = { |in| if ( in < ~lowest, {~lowest = in} ); if ( in > ~highest, {~highest = in})};
~onset1.play;
OSCdef(\onsetresponder,
	{|msg|
		~maxmin.value(msg[3]);
		~iter.value(~index);
		if (~index <= 1,
			{~valuearray[~index] = msg[3].explin(~lowest,~highest,200,1)},
			{~valuearray[~index] = msg[3].explin(~lowest,~highest,4000,50)});
		"grabbed".post;
		rrand(1,10).postln;
},'/onset');

//function to send thearray to Arduino
~sendToArduino = OSCFunc({ arg msg, time;
	~python.sendMsg("/soundInfo/array",~valuearray[0].asInt,~valuearray[1].asInt,~valuearray[2].asInt,~valuearray[3].asInt,~valuearray[4].asInt,~valuearray[5].asInt,~valuearray[6].asInt,~valuearray[7].asInt,~valuearray[8].asInt,~valuearray[9].asInt,~valuearray[10].asInt);
	"sent!".postln;
},'/tr');

//activate the synth
Synth(\sendTrig);
)

