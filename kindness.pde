class Kindness {
    ArrayList<Blob> blobs = new ArrayList<Blob>();
    float x;
    float y;
    float blobSize = 50;
    int blobLimit = int((width/2));

    Kindness(float X, float Y) {
        x = X;
        y = Y;
        blobs.add(new Blob(x, y, blobSize));
    }

    void update(int state) {
        int size = blobs.size();
        if (state == 1) {
            blobs.add(new Blob(
                        newBlobX(size),
                        newBlobY(size),
                        random(blobSize)
                     ));
        } else if (state == 2 && size > 2) {
            blobs.remove(size - 1);
        }
    }

    float newBlobX(int index) {
        int direction = random(10) > 5 ? 1 : -1;
        return abs((x * direction) - random(index/2));
    }

    float newBlobY(int index) {
        int direction = random(10) > 5 ? 1 : -1;
        return abs((y * direction) - random(index/2));
    }

    void draw() {
        for (Blob blob : blobs) {
            blob.draw();
        }
    }

    int size() {
        return blobs.size();
    }

    int state() {
        int size = blobs.size();

        if (size >= blobLimit * 0.75 && size <= blobLimit * 2) {
            return 1;
        }

        if (size > blobLimit * 2) {
            return 2;
        }

        return 0;
    }
}
