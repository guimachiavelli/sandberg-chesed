Input input;
Kindness kindness;
Song song;

void setup() {
    size(600, 600, P3D);
    pixelDensity(displayDensity());

    input = new Input(this);
    kindness = new Kindness(width/2, height/2);
    song = new Song(this);
}

void draw() {
    input.update();
    kindness.update(input.getState());
    song.update(kindness);

    background(160);
    drawBox();
    kindness.draw();
    song.play(kindness);
}

void drawBox() {
    pushMatrix();
    translate(width/2, height/2);
    stroke(0);
    noFill();
    rotateY(millis() / (PI * 1000));
    box(width/3);
    popMatrix();
}

int fullnessStatus() {
    int size = kindness.size();

    if (size > 500) {

    }

    return 0;
}

void captureEvent(Capture c){
    c.read();
}
