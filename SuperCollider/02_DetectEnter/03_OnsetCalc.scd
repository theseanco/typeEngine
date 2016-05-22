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

//this holds the answer. Specify all of these values in a SendTrig
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





git