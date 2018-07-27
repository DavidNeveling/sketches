import peasy.*;
PeasyCam cam;
float change;
void setup() {
  size(1000, 1000, P3D);  
  cam = new PeasyCam(this, 200);
  change = 0;
}

void draw(){
  background(255);
  fill(255);
  lights();
  //sphere(200);
  int total = 200;
  float r = 200;
  int l = 100;
  int w = 100;
  //for(int x = 0; x < w; x++){
  //  for(int y = 0; y < l; y++){
  //    if(change >= 1)
  //      change = 0;
  //    strokeWeight(60);
  //    stroke(0, 0, 100 + noise(change) * 156);
  //    point(map(x, 0, w, -height * 2, height * 2), map(y, 0, l, -height * 2, height * 2), -400);
  //    change += .05;
  //  }
  //}
  //x = r sin theta cos phi
  //y = r sin theta sin phi
  //z = r cos theta
  for(int i = 0; i < total / 2; i++){
    float lon = map(i, 0, total / 2, -PI, PI);
    for(int j = 0; j < total / 2; j++){
      float lat = map(j, 0, total / 2, 0, 2 * PI);
      if(change >= 1)
        change = 0;
      float x = r * sin(lon) * cos(lat);
      float y = r * sin(lon) * sin(lat);
      float z = r * cos(lon);
      strokeWeight(30);
      stroke(100 + noise(change) * 156, 95, 100 + noise(change) * 156);
      point(x, y, z);
      change += .001;
    }
  }
}