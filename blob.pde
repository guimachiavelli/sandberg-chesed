class Blob {
    float x;
    float y;
    float width;

    Blob(float X, float Y) {
        x = X;
        y = Y;
        width = random(100);
    }

    Blob(float X, float Y, float init_width) {
        x = X;
        y = Y;
        width = init_width;
    }

    void draw() {
        pushMatrix();

        translate(x, y);
        stroke(random(255), random(127), random(255));
        fill(random(255), random(127), random(255));
        sphere(width/2);
        sphereDetail(int(random(10) + 2));

        popMatrix();
    }
}

