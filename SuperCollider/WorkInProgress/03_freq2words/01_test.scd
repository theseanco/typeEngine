/*

Writing a script to turn frequencies into words, for the second part of the performance

*/


//this sends a pitch value as an integer to python by using a Dust UGen
(
~python = NetAddr("127.0.0.1",7002);
~freq2words = { SendReply.kr(Dust.kr(3),'/freqgrab',Tartini.kr(SoundIn.ar(1))[0])}.play;
OSCdef(\f2wsend,{|msg| ~python.sendMsg("/freq2words/freq",msg[3].asInt)},'/freqgrab');
)

