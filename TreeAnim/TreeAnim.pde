float length = 240;
float angle = 0;
float offset = PI / 64;
boolean grow = true;
void setup(){
  size(1080, 1080);
}

void draw(){
  background(135, 206, 250);
  strokeWeight(3);
  stroke(0, 15, 250);
  line(width / 2, height * 3 / 5, width / 2, height);
  translate(width / 2, height * 4 / 5);
  branch(length);
  if(angle < 0)
    grow = true;
  if(angle > PI / 2)
    grow = false;
  if(grow)
    angle += noise(1) * PI / 128;
  else
    angle -= noise(1) * PI / 128;
}

void branch(float len){
  line(0, 0, 0, 0 - len);
  translate(0, -len);
  if(len > 20){
    pushMatrix();
    //rotate(random(-angle - offset, -angle + offset));
    rotate(-angle);
    branch(len * .67);
    popMatrix();
    
    pushMatrix();
    //rotate(random(angle - offset, angle + offset));
    rotate(angle);
    branch(len * .67);
    popMatrix();
  }
}