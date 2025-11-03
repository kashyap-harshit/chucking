TriOsc s1 => Gain g1 => dac;
440.0/2 => s1.freq;
0.3 => s1.gain;
1::second => now;
220.0/2 => s1.freq;
1::second => now;
