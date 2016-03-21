import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;

class Emoji {
  float x;
  float y;
  float diameter;
  PImage img;
  Emoji(PImage tempImg, float tempX, float tempY, float tempD){
    x = tempX;
    y = tempY;
    diameter = tempD;
    img = tempImg;
  }
  void display(){
    stroke(0);
    image(img, x, y, diameter, diameter);
  }
}

PImage[] emoji = new PImage[78];
Emoji[] emojis = new Emoji[78];


void setup() {
  size(1280, 960);
  for (int i = 0; i<emoji.length; i++) {
    emoji[i] = loadImage("emoji-" + i + ".png");
  }
  video = new Capture(this, 1280/4, 960/4);
  opencv = new OpenCV(this, 1280/4, 960/4);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  video.start();
}

void draw() {
  scale(4);
  opencv.loadImage(video);
  Rectangle[] faces = opencv.detect();
  image(video, 0,0);

  for (int i = 0; i < faces.length; i++) {
    int index = int(random(0, emoji.length));
    emojis[i] = new Emoji(emoji[index], faces[i].x, faces[i].y, faces[i].height);
  }
  for(int i = 0; i < faces.length; i++) {
     emojis[i].display();
  }
}
void captureEvent(Capture c) {
  c.read();
}