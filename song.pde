import processing.sound.*;
import java.util.Collections;

class Song {
    SinOsc voice;
    ArrayList<float[]> sheet;
    int currentNote = 0;
    int currentDuration = 0;
    float[] notes = { 65.406, 69.296, 69.296, 73.416, 77.782, 77.782, 82.407,
                      87.307, 92.499, 92.499, 97.999, 103.826, 103.826, 110,
                      116.541, 116.541, 123.471
                    };


    Song(PApplet parent) {
        sheet = new ArrayList<float[]>();
        voice = new SinOsc(parent);
        voice.amp(0);
        voice.play();
    }

    float randomNote() {
        return notes[int(random(notes.length))];
    }

    void update(Kindness kindness) {
        int diff = kindness.size() - sheet.size();

        if (diff > 0) {
            addNotes(diff, kindness.size());
        } else if (diff < 0) {
            removeNotes(abs(diff));
        }

        if (currentNote >= sheet.size()) {
            currentNote = sheet.size() - 1;
        }
    }

    void addNotes(int amount, int size) {
        while (amount > 0) {
            float duration = noise(size) * 500;
            float freq = randomNote();
            freq = freq;

            float[] note = {
                duration,
                freq
            };

            sheet.add(note);

            amount -= 1;
        }
    }

    void removeNotes(int amount) {
        while (amount > 0) {
            sheet.remove(sheet.size() - amount);
            amount -= 1;
        }
    }

    void play(Kindness kindness) {
        if (sheet.size() < 1) {
            return;
        }

        int now = millis();
        float[] note = sheet.get(currentNote);


        float freq = note[1];

        if (kindness.state() == 1) {
            freq += 400;
        }

        if (kindness.state() == 2) {
            freq += 600;
        }

        if (now - currentDuration > note[0]) {
            currentDuration = now;
            currentNote += 1;

            if (currentNote >= sheet.size() - 1) {
                Collections.reverse(sheet);
                currentNote = 0;
            }
        }
        voice.freq(freq);
        voice.amp(0.25);
    }

    void pause() {
        voice.amp(0);
    }

    void stop() {
        voice.stop();
    }
}
