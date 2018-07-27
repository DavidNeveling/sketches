import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;  
AudioPlayer groove1;
AudioPlayer groove2;
AudioInput mic;
FFT fftLin;
FFT fftLog;
int scale;
int grow;
int length1;
int length2;
void setup() {
  size(1000, 800, P3D);  
  minim = new Minim(this);
  groove1 = minim.loadFile("Crypt of the Necrodancer - The Wight to Remain.mp3");
  groove2 = minim.loadFile("Animals as Leaders - The Brain Dance.mp3");
  mic = minim.getLineIn(Minim.STEREO, 512);
  scale = 1000;
  grow = scale / 10;
  //groove1.loop();
  length1 = groove1.length() / scale;
  length2 = groove2.length() / scale;
  grow = height / length1;
  groove1.loop();
}

void draw(){
  background(255);
  fill(255);
  
  rotateX(PI/8);
  strokeWeight(30);

  //float[] levels1 = new float[length1];
  //float[] levels2 = new float[length2];
  translate((width / 2) - (length1 * grow / 2), (height / 2) - (length2 * grow / 2));
 // groove1.play();
  //for(int i = 0; i < length1 && i * scale < groove1.bufferSize(); i++){
  //    levels1[i] = (groove1.left.level() + groove1.right.level()) / 2;
  //    //groove1.skip(scale);
  //}
  //groove1.pause();
  //groove2.play();
  //for(int i = 0; i < length2 && i * scale < groove2.bufferSize(); i++){
  //    levels2[i] = (groove2.left.level() + groove2.right.level()) / 2;
  //    //groove2.skip(scale);
  //}
 // groove2.pause();
  stroke(0);
  strokeWeight(1);
  fill(150);
  for(int i = 1; i < groove1.bufferSize(); i++){
      for(int j = 1; j < groove1.bufferSize(); j++){
          beginShape();
          vertex((i-1) * grow, (j-1) * grow, 10 * (groove1.left.get(i-1) + groove1.right.get(j-1)) / 2);
          vertex((i) * grow, (j-1) * grow, 10 * (groove1.left.get(i) + groove1.right.get(j-1)) / 2);
          vertex((i) * grow, (j) * grow, 10 * (groove1.left.get(i) + groove1.right.get(j)) / 2);
          vertex((i-1) * grow, (j) * grow, 10 * (groove1.left.get(i-1) + groove1.right.get(j)) / 2);
          vertex((i-1) * grow, (j-1) * grow, 10 * (groove1.left.get(i-1) + groove1.right.get(j-1)) / 2);
          endShape();
      }
  }
}

void keyPressed() {
  if ( key == ENTER || key == RETURN ) {
      groove1.loop();
  }
}