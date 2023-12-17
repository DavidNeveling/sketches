float g;
Walker w;

void setup(){
  size(800, 800);
  g = 255;
  w = new Walker(width/2, height/2);
}

void draw(){
  background(color(255, g, 0));
  g -= 0.1;
  w.update();
}
