float g;

void setup(){
  size(800, 800);
  g = 255;
}

void draw(){
  background(color(255, g, 0));
  g -= 0.1;
}
