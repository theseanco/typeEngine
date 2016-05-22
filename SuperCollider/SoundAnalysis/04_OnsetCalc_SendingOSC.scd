//This is a function based on the example file for Onsets which I have used to create the keyboard sensing mechanism
(
b = Buffer.alloc(s, 512);
x = {
    var sig, chain, onsets, pips;

    // A simple generative signal
    sig = SoundIn.ar;
    // or, uncomment this line if you want to play the buffer in
    //sig = PlayBuf.ar(1, d, BufRateScale.kr(d), loop: 1);

    chain = FFT(b, sig);

	    onsets = Onsets.kr(chain, 0.86, \rcomplex);

    // You'll hear percussive "ticks" whenever an onset is detected
    pips = WhiteNoise.ar(EnvGen.kr(Env.perc(0.001, 0.1, 0.2), onsets));
    Out.ar(0, Pan2.ar(sig, -0.75, 0.2) + Pan2.ar(pips, 0.75, 1));
}.play;
)


//Now i need this mechanism to trigger maybe a printline when an onset is found.


//this sends an OSC message to localhost '/onset' when an onset is detected
(
~onsetBuf = Buffer.alloc(s,512);
~loudnessBuf = Buffer.alloc(s,1024);
~onset1 = { var sig, chain, onsets;

	sig = SoundIn.ar;

	chain = FFT(~onsetBuf,sig);

	onsets = SendReply.kr(Onsets.kr(chain,0.86,\rcomplex),'/onset',1);
};
~onset1.play;
)

/*

TODO:

- Make an OSCFunc which, when '/onset' recieves a message, grabs data using PITCH and LOUDNESS.
- This data then needs to be condensed into a single datapoint
- This datapoint then needs to be written to one of ten values
- These values then need to be iterated over, so each onset sends this datapoint to a new value
- Then, when all of the values have been written etc, the array needs to be dumped wholesale on to Python, which will deal with it and send it to the Arduino for animating.

Then the vast majority of the project is done, the feedback loop then becomes a trivial matter of enabling a second input and feeding it through the funamental pitch tracker.

Maybe then do some kind of typing thing so that i actually have to fight with my machine, but i havent figured that one out yet.

*/


// a synthdef to test out the onset detection engine
(
SynthDef(\sinfb, {
	arg freq = 440, atk = 0.01, sus = 0, rel = 1, fb = 0, amp = 0.3, out = 0, pan=0;
	var sig, env;
	env = EnvGen.ar(Env.linen(atk,sus,rel),1,1,0,1,2);
	sig = SinOscFB.ar(freq,fb,1);
	sig = sig*env;
	Out.ar(out,Pan2.ar(sig,pan,amp));
}).add;
);

//this just works. Now to figure out how to get this to work with onset and pitch detection in one fell swoop
OSCdef(\onsetResponder,{Synth(\sinfb)},'/onset')

(
//a whole bunch of super ugly global variables to hold sound values
~v1 = 2000; ~v2 = 2000; ~v3 = 2000; ~v4 = 2000; ~v5 = 2000; ~v6 = 2000; ~v7 = 2000; ~v8 = 2000; ~v9 = 2000; ~v10 = 2000; ~currentamp = 0; ~currentpitch = 0;
OSCdef(\onsetResponder,{}))

//This, when an onset is detected, grabs loudness and frequency data, scales loudness to 0-1 and multiplies frequency by it.
(
~onsetBuf = Buffer.alloc(s,512);
~loudnessBuf = Buffer.alloc(s,1024);
~onset1 = { var sig, chain, onsets, loudness, pitch;

	sig = SoundIn.ar;

	chain = FFT(~onsetBuf,sig);

	onsets = SendReply.kr(Onsets.kr(chain,0.86,\rcomplex),'/onset',
		//calculate loudness
		((Loudness.kr(FFT(~loudnessBuf,SoundIn.ar(0))))/60) * Pitch.kr(SoundIn.ar,440,10)
	);
};
~onset1.play;
)

//The previous set of functions outputs a datapoint at index three. I will go from here tomorrow.
//I need to make an OSCdef which translates data point 3 into one of the indices of the array which will be sent to Arduino.









/* NEW AS OF 22nd May

*/


//built in an iterator, then added it to the OSCdef which controls the array
(
~valuearray = Array.fill(10,0);
~onsetBuf = Buffer.alloc(s,512);
~loudnessBuf = Buffer.alloc(s,1024);
~onset1 = { var sig, chain, onsets, loudness, pitch;
	//sound coming in
	sig = SoundIn.ar;
	//initialising FFT for the onset detection
	chain = FFT(~onsetBuf,sig);
	//Sends an OSC message when an onset is detected
	onsets = SendReply.kr(Onsets.kr(chain,0.86,\rcomplex),'/onset',
		//calculate loudness and pitch, then multiply pitch by normalised loudness value
		((Loudness.kr(FFT(~loudnessBuf,SoundIn.ar(0))))/60) * Pitch.kr(SoundIn.ar,440,10)
	);
};
//a simple iterator
~iter = { |in| in = in+1; if ( in >= 10, {~index = 0},{~index = in})};
~onset1.play;
//calls the iterator, then pushes the sound value calculated during onset1 to the iterated array index
OSCdef(\onsetresponder,
	{|msg|
		~iter.value(~index);
		~valuearray[~index] = msg[3];
},'/onset');
)

/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
//The above works perfectly. I now need to scale these values.
//need to work out meaningful max and min values to scale this array to be usable by the arduino program
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////


(
//initialising lowest and highest
~lowest = 10.0;
~highest = 10.0;
~valuearray = Array.fill(10,0);
~onsetBuf = Buffer.alloc(s,512);
~loudnessBuf = Buffer.alloc(s,1024);
~onset1 = { var sig, chain, onsets, loudness, pitch;
	sig = SoundIn.ar;
	chain = FFT(~onsetBuf,sig);
	onsets = SendReply.kr(Onsets.kr(chain,0.86,\rcomplex),'/onset',
		//calculate loudness
		((Loudness.kr(FFT(~loudnessBuf,SoundIn.ar(0))))/60) * Pitch.kr(SoundIn.ar,440,10)
	);
};
//a simple iterator
~iter = { |in| in = in+1; if ( in >= 10, {~index = 0},{~index = in})};
//calculates a rolling max/min value, which are scaled dynamically, could potentially have a reset of these at some point in the performance if needs be
~maxmin = { |in| if ( in < ~lowest, {~lowest = in} ); if ( in > ~highest, {~highest = in})};
~onset1.play;
//calls the iterator, then pushes the sound value calculated during onset1 to the iterated array index
OSCdef(\onsetresponder,
	{|msg|
		~maxmin.value(msg[3]);
		~iter.value(~index);
		//uses the new lowest and highest values to scale the reaction from 2s to 1ms
		~valuearray[~index] = msg[3].explin(~lowest,~highest,2000,1);
		//test line to post the results
		msg[3].linlin(~lowest,~highest,2000,1).postln;
},'/onset');
)

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


