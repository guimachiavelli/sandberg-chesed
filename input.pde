import processing.video.*;
import gab.opencv.*;

class Input {
    OpenCV opencv;
    Capture cam;
    ArrayList<Contour> contours;

    int width = 320;
    int height = 180;

    int threshold = 100;
    int rightCounter = 0;
    int leftCounter = 0;

    Input(PApplet parent) {
        String[] cameras = Capture.list();
        cam = new Capture(parent, cameras[7]);
        cam.start();

        opencv = new OpenCV(parent, width, height);
        opencv.startBackgroundSubtraction(5, 3, 0.5);
    }

    void update() {
        if (cam.width <= 0 && cam.height <= 0) {
            return;
        }

        opencv.loadImage(cam);
        opencv.updateBackground();
        opencv.threshold(threshold);
        contours = opencv.findContours();

        for (Contour contour : contours) {
            if (contour.getBoundingBox().getCenterX() > width/2) {
                rightCounter += 1;
            } else if (contour.getBoundingBox().getCenterX() <= width/2) {
                leftCounter += 1;
            }
        }
    }

    int getState() {
        int state = rightCounter - leftCounter;

        rightCounter = 0;
        leftCounter = 0;

        if (state > 0) {
            return 1;
        } else if (state < 0) {
            return 2;
        }

        return 0;
    }


}
