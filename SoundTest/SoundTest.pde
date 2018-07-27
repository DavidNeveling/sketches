import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;  
AudioPlayer groove;
FFT fftLin;
FFT fftLog;

void setup() {
  size(800, 800, P3D);
  minim = new Minim(this);
  groove = minim.loadFile("Gusty Gardens Panda.mp3");
}

void draw() {
  background(0); 
  stroke(255);
  for(int i = 0; i < groove.bufferSize() - 1; i += 10) {
    float left = groove.left.get(i)*200;
    float right = groove.right.get(i)*200;
    float nextLeft = groove.left.get(i)*200;
    float nextRight = groove.right.get(i)*200;
    rect(i, 200 - (left / 2), 1, nextLeft);
    rect(i, 500 - (right / 2), 1, nextRight);
  }
}

void keyPressed() {
  if ( key == ENTER || key == RETURN ) groove.loop();
}