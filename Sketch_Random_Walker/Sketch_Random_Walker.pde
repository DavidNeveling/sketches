Walker w;
float r, g, b;
void setup(){
  size(1200, 1200);
  w = new Walker(width/2, height/2, 30);
  background(0);
  strokeWeight(5);
}

void draw(){
  stroke(20 + noise(r, 0, 0)*235, 20 + noise(0, g, 0)*235, 20 + noise(0, 0, b)*235);
  w.update();
  r += 0.01;
  g += 0.01;
  b += 0.01;
}
