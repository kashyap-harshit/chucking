100 => float bpm;
(60.0 / bpm)::second => dur beat;
4 * beat => dur measure;
0.4=>float gain;

TriOsc s1 => Gain g1 => dac;
TriOsc s2 => Gain g2 => dac;
TriOsc s3 => Gain g3 => dac;

// gain => g.gain;


fun void playChord(float root, float third, float fifth, dur length){
    root => s1.freq;
    third => s2.freq;
    fifth => s3.freq;
    // 1=>s1.noteOn;
    // 1=>s2.noteOn;
    // 1=>s3.noteOn;
    // length=>now;
    // 0=>s1.noteOff;
    // 0=>s2.noteOff;
    // 0=>s3.noteOff;
    
    // fade in
    0 => g1.gain => g2.gain => g3.gain;
    0.3 => g1.gain => g2.gain => g3.gain;

    // hold the chord
    length - (100::ms) => now;

    // fade out quickly
    0 => g1.gain => g2.gain => g3.gain;

    100::ms => now;
}


[
     [261.63, 329.63, 392.00],
     [220.00,261.63, 329.63],
      [174.61, 220.00, 261.63],
      [196.00, 246.94, 392.00] 
] @=>float chords[][];


while(true){
    for(0=>int i;i<chords.size(); i++){
        playChord(chords[i][0], chords[i][1], chords[i][2], measure);
    }
}