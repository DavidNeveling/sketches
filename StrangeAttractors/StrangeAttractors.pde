import peasy.*;

float x = 0;
float y = 0;
float z = 0;

float a = 0.2;
float b = 0.2;
float c = 5.7;

ArrayList<PVector> points = new ArrayList<PVector>();

PeasyCam cam;

void setup() {
  size(800, 600, P3D);
  colorMode(HSB);
  cam = new PeasyCam(this, 1200);
}

void draw() {
  background(0);
  float dt = 0.01;
  // Lorenz
  //float dx = (a * (y - x))*dt;
  //float dy = (x * (b - z) - y)*dt;
  //float dz = (x * y - c * z)*dt;
  // Rossler
    float dx = (- (y + z)) * dt;
    float dy = (x + a * y) * dt;
    float dz = (b + x * z + c * z) * dt;
      x = x + dx;
      y = y + dy;
      z = z + dz;
    
      points.add(new PVector(x, y, z));
    
      translate(0, 0, -80);
      //translate(width/2, height/2);
      scale(5);
      stroke(255);
      noFill();
    
      float hu = 0;
      beginShape();
      for (PVector v : points) {
    stroke(hu, 255, 255);
    vertex(v.x, v.y,v.z);
    //PVector offset = PVector.random3D();
    //offset.mult(0.1);
    //v.add(offset);
    
    hu += 0.1;
    if (hu > 255) {
      hu = 0;
    }
      }
      endShape();
}

    // Rossler
    //float dx = (- (y + z)) * dt;
    //float dy = (x + a * y) * dt;
    //float dz = (b + x * z + c * z) * dt;