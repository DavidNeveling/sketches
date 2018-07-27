int p;
int q;
float phi;
float track;
float track2;
float track3;
float angle;
float offset = 0.4;
float increment = PI / 8192;
void setup(){
    size(1900, 1080, P3D);
    p = 2;
    q = -7;
    track = 0;
    track2 = 2 * PI / 3;
    track3 = 2 * track2;
    angle = 0;
}
void draw(){
    translate(width / 2, height / 2);
    rotateX(angle);
    rotateZ(angle);
    rotateY(angle);
    background(0);
    stroke(255);
    noFill();
    strokeWeight(30);
    if(track > 2 * PI - offset)
        phi = offset;
    else
        phi = 0;
    if(track >= 2 * PI)
        track = 0;
    if(track2 >= 2 * PI)
        track2 = 0;
    if(track3 >= 2 * PI)
        track3 = 0;
    beginShape();
    while(phi <= 2 * PI + offset){
        float r = 40 * (cos(q * phi) + 2);
        float x = 4 * r * cos(p * phi);
        float y = 4 * r * sin(p * phi);
        float z = -r * sin(q * phi);
        if(track < phi && track > phi - offset)
            stroke(map(track, phi - offset, phi, 0, 255), map(track, phi - offset, phi, 0, 255), 255);
        else if(track2 < phi && track2 > phi - offset)
            stroke(map(track2, phi - offset, phi, 0, 255), 255, map(track2, phi - offset, phi, 0, 255));
        else if(track3 < phi && track3 > phi - offset)
            stroke(255, map(track3, phi - offset, phi, 0, 255), map(track3, phi - offset, phi, 0, 255));
        else
            stroke(255);    
        vertex(x, y, z);
        phi += increment;
    }
    endShape();
    //if(frameCount <= 18000)
        //saveFrame("frames/#####.png");
    track += 0.03;
    track2 += 0.03;
    track3 += 0.03;
    angle += 0.01;
}