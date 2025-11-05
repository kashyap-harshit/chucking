80 => float bpm;
(60.0/bpm)::second => dur beat;
4*beat => dur measure;
0.4=>float gain;

TriOsc s1 => Gain g1 => dac;
TriOsc s2 => Gain g2 => dac;
TriOsc s3 => Gain g3 => dac;

[
    // [ 349.23, 440.00,523.25],
    // [ 329.63, 440.00,523.25],
    // [ 311.13,440.00,523.25],
    // [392.00, 466.16],
    // [369.99, 440.00],
    // [293.66, 392.00,466.16],
    // [261.63, 349.23,440.00],
    [233.08, 311.13, 392.00],
    [233.08, 293.66, 349.23],




] @=>float chords[][];

fun void playChord4(float root, float third, float fifth, dur length){
    root => s1.freq;
    third => s2.freq;
    fifth => s3.freq;

    0 => g1.gain => g2.gain => g3.gain;
    0.3 => g1.gain => g2.gain => g3.gain;
    length/8=>now;
    0 => g2.gain => g3.gain;
    length/8=>now;

}

fun void playChord(float root, float third, float fifth, dur length){
    root => s1.freq;
    third => s2.freq;
    fifth => s3.freq;

    0 => g1.gain => g2.gain => g3.gain;
    0.3 => g1.gain => g2.gain => g3.gain;
    length/8=>now;
    0 => g2.gain => g3.gain;
    length/8=>now;

    0.3 => g2.gain => g3.gain;
    length/8=>now;
    0 => g2.gain => g3.gain;
    length/8=>now;
    
}

fun void playChord2(float root, float third, dur length){
     root => s1.freq;
    third => s2.freq;
    0 => g1.gain => g2.gain;
    0.3 => g1.gain => g2.gain;
    length/4=>now;
}

fun void playChord3(float root, float third, float fifth, dur length){
    root => s1.freq;
    third => s2.freq;
    fifth => s3.freq;
    0 => g1.gain => g2.gain => g3.gain;
    0.3 => g1.gain;
    length/8=>now;
    
    0.3 => g2.gain;
    length/8=>now;
    
    0.3 => g3.gain;
    length/4=>now;

    
}


while(true){
    for(0=>int i;i<chords.size(); i++){
        playChord4(chords[i][0], chords[i][1], chords[i][2], measure);
        // if(i<3){

        // playChord(chords[i][0], chords[i][1], chords[i][2], measure);
        // }else if(i>=3 && i<5){

        // playChord2(chords[i][0], chords[i][1], measure);
        // }else{
        // playChord3(chords[i][0], chords[i][1], chords[i][2], measure);

        // }
    }
}