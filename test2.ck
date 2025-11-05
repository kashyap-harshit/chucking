100 => float bpm;
(60.0 / bpm)::second => dur beat;
4 * beat => dur measure;
0.4 => float gain;

// === CHORD OSCILLATORS ===
TriOsc s1 => Gain g1 => dac;
TriOsc s2 => Gain g2 => dac;
TriOsc s3 => Gain g3 => dac;

// === MELODY OSCILLATOR ===
SinOsc lead => Gain glead => dac;
0.2 => glead.gain;

fun void playChord(float root, float third, float fifth, dur length) {
    root => s1.freq;
    third => s2.freq;
    fifth => s3.freq;

    0.3 => g1.gain => g2.gain => g3.gain;
    length - (100::ms) => now;
    0 => g1.gain => g2.gain => g3.gain;
    100::ms => now;
}

// === CHORDS (C → Am → F → G) ===
[
    [261.63, 329.63, 392.00], // C major
    [220.00, 261.63, 329.63], // A minor
    [174.61, 220.00, 261.63], // F major
    [196.00, 246.94, 392.00]  // G major
] @=> float chords[][];

// === MELODY (in C major scale) ===
// Corresponding melody for each chord (4 beats per measure)
[
    [523.25, 587.33, 659.26, 587.33], // over C
    [440.00, 493.88, 523.25, 493.88], // over Am
    [349.23, 392.00, 440.00, 392.00], // over F
    [392.00, 440.00, 493.88, 440.00]  // over G
] @=> float melody[][];

// === Melody player ===
fun void playMelody() {
    while(true) {
        for (0 => int i; i < melody.size(); i++) {
            for (0 => int j; j < melody[i].size(); j++) {
                melody[i][j] => lead.freq;
                0.3 => glead.gain;
                beat => now;
            }
        }
    }
}

// === Run melody and chords in parallel ===
spork ~ playMelody();

while(true) {
    for(0 => int i; i < chords.size(); i++) {
        playChord(chords[i][0], chords[i][1], chords[i][2], measure);
    }
}
