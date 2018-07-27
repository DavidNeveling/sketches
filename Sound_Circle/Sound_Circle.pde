import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;  
AudioPlayer groove;
AudioInput mic;
FFT fftLin;
FFT fftLog;
void setup() {
  size(1920, 1080);  
  minim = new Minim(this);
  groove = minim.loadFile("debidep2.mp3");
  mic = minim.getLineIn(Minim.STEREO, 512);
  //groove.loop();
}

void draw(){
  background(255);
  fill(255);
  translate(width / 2, height / 2);
  float x;
  float y;
  strokeWeight(30);
  
  for(float r = 0; r < 500; r += 25){
    //stroke(100 + Math.abs((groove.left.level() + groove.right.level()) / 2) * 156, 95, 100 + Math.abs((groove.left.level() + groove.right.level()) / 2) * 156);
    //stroke(256 - Math.abs((groove.left.level() + groove.right.level()) / 2) * 256); // song grayscale
    //stroke(256 - Math.abs((mic.left.level() + mic.right.level()) / 2) * 256); // mic grayscale
    //stroke(0, (20 * log((1 + (Math.abs((mic.left.level() + mic.right.level()) / 2)) / (1 + (20 * log(1 + (Math.abs((mic.left.level() + mic.right.level()) / 2))))))) * 256), 256 - Math.abs((mic.left.level() + mic.right.level()) / 2) * 256); // mic log scaling from blue to green
    //stroke(0, (((20 * Math.abs((mic.left.level() + mic.right.level()) / 2)))) / (1 + ((20 * Math.abs((mic.left.level() + mic.right.level()) / 2)))) * 256, 256 - Math.abs((mic.left.level() + mic.right.level()) / 2) * 256); // mic x / 1 + x scaling from blue to green 
    //stroke(0, (20 * log((1 + (Math.abs((groove.left.level() + groove.right.level()) / 2)) / (1 + (20 * log(1 + (Math.abs((groove.left.level() + groove.right.level()) / 2))))))) * 256), 256 - Math.abs((groove.left.level() + groove.right.level()) / 2) * 256); // song log scaling from blue to green
    //stroke((20 * log((1 + (Math.abs((groove.left.level() + groove.right.level()) / 2)) / (1 + (20 * log(1 + (Math.abs((groove.left.level() + groove.right.level()) / 2))))))) * 256), 0, 256 - Math.abs((groove.left.level() + groove.right.level()) / 2) * 256); // song log scaling from blue to red
    //stroke(255, 126 + (20 * log((1 + (Math.abs((groove.left.level() + groove.right.level()) / 2)) / (1 + (20 * log(1 + (Math.abs((groove.left.level() + groove.right.level()) / 2))))))) * 129), 0); // song log scaling from blue to red
    // stroke(64 - (Math.abs((mic.left.level() + mic.right.level()) / 2) * 191), 0, (20 * log((1 + (Math.abs((mic.left.level() + mic.right.level()) / 2)) / (1 + (20 * log(1 + (Math.abs((mic.left.level() + mic.right.level()) / 2))))))) * 138)); // christian
    // stroke(220 - (20 * log((1 + (Math.abs((groove.left.level() + groove.right.level()) / 2)) / (1 + (20 * log(1 + (Math.abs((groove.left.level() + groove.right.level()) / 2))))))) * 207), 88 + (Math.abs((groove.left.level() + groove.right.level()) / 2) * 63), 141 + (Math.abs((groove.left.level() + groove.right.level()) / 2) * 89)); // eddie
    //stroke(255 - (20 * (((Math.abs((groove.left.level() + groove.right.level()) / 2)) / (1 + (20 * ((Math.abs((groove.left.level() + groove.right.level()) / 2))))))) * 255), 70 - (20 * (((Math.abs((groove.left.level() + groove.right.level()) / 2)) / (1 + (20 * ((Math.abs((groove.left.level() + groove.right.level()) / 2))))))) * 70), 0); // vincent
    //stroke((20 * (((Math.abs((mic.left.level() + mic.right.level()) / 2)) / (1 + (20 * ((Math.abs((mic.left.level() + mic.right.level()) / 2))))))) * 255), 255 - (9 * (((Math.abs((mic.left.level() + mic.right.level()) / 2)) / (1 + (9 * ((Math.abs((mic.left.level() + mic.right.level()) / 2))))))) * 255), 255 - (9 * (((Math.abs((mic.left.level() + mic.right.level()) / 2)) / (1 + (9 * ((Math.abs((mic.left.level() + mic.right.level()) / 2))))))) * 255)); //Ed
    stroke(0, (20 * log((1 + (Math.abs((groove.left.level() + groove.right.level()) / 2)) / (1 + (20 * log(1 + (Math.abs((groove.left.level() + groove.right.level()) / 2))))))) * 256), 256 - Math.abs((groove.left.level() + groove.right.level()) / 2) * 256); // david
    for(float th = 0; th < 2 * PI; th += (2 * PI) / r){
      x = r * cos(th);
      y = r * sin(th);
      point(x, y);
    }
  }
}

void keyPressed() {
  if ( key == ENTER || key == RETURN ) {
      groove.loop();
  }
}

//Christian: burgundy and blue // stroke(64 - (Math.abs((groove.left.level() + groove.right.level()) / 2) * 191), 0, (20 * log((1 + (Math.abs((groove.left.level() + groove.right.level()) / 2)) / (1 + (20 * log(1 + (Math.abs((groove.left.level() + groove.right.level()) / 2))))))) * 138)); // christian
//Vincent: orange and black // stroke(255 - (20 * (((Math.abs((groove.left.level() + groove.right.level()) / 2)) / (1 + (20 * ((Math.abs((groove.left.level() + groove.right.level()) / 2))))))) * 255), 70 - (20 * (((Math.abs((groove.left.level() + groove.right.level()) / 2)) / (1 + (20 * ((Math.abs((groove.left.level() + groove.right.level()) / 2))))))) * 70), 0); // vincent
//David: blue and green // stroke(0, (20 * log((1 + (Math.abs((groove.left.level() + groove.right.level()) / 2)) / (1 + (20 * log(1 + (Math.abs((groove.left.level() + groove.right.level()) / 2))))))) * 256), 256 - Math.abs((groove.left.level() + groove.right.level()) / 2) * 256); // david
//Eddie: oregairu // stroke(220 - (20 * log((1 + (Math.abs((groove.left.level() + groove.right.level()) / 2)) / (1 + (20 * log(1 + (Math.abs((groove.left.level() + groove.right.level()) / 2))))))) * 207), 88 + (Math.abs((groove.left.level() + groove.right.level()) / 2) * 63), 141 + (Math.abs((groove.left.level() + groove.right.level()) / 2) * 89)); // eddie
//Ed: cyan and red // stroke((20 * (((Math.abs((groove.left.level() + groove.right.level()) / 2)) / (1 + (20 * ((Math.abs((groove.left.level() + groove.right.level()) / 2))))))) * 255), 255 - (9 * (((Math.abs((groove.left.level() + groove.right.level()) / 2)) / (1 + (9 * ((Math.abs((groove.left.level() + groove.right.level()) / 2))))))) * 255), 255 - (9 * (((Math.abs((groove.left.level() + groove.right.level()) / 2)) / (1 + (9 * ((Math.abs((groove.left.level() + groove.right.level()) / 2))))))) * 255)); //Ed