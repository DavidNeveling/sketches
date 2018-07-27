float angle;
int length;
int x, y, s;
int circSize;
void setup(){
    size(400, 400);
    angle = HALF_PI;
    s = 100;
    x = 0;
    y = 0;
    circSize = 20;
    rectMode(CENTER);
}

void draw(){
    background(0);
    float r;
    if (angle > PI / 4 && angle < 3 * PI / 4 || angle > 5 * PI / 4 && angle < 7 * PI / 4)
        r = abs((s / 2) / sin(angle));
    else
        r = abs((s / 2) / cos(angle));
    translate(width / 2, height / 2);
    noStroke();
    fill(0, 255, 255);
    ellipse(0, 0, circSize, circSize);
    translate(0, - r - circSize / 2);
    
    rotate(-angle - PI/2);
    fill(255);
    rect(x, y, s, s);
    strokeWeight(4);
    stroke(255, 100, 100);
    line(x, y, x - r * cos(angle), y - r * sin(angle));
    angle += 0.01;
    if (angle > TWO_PI)
        angle = 0;
}

//class Square{
//    public int x, y, s;
//    public Square(int x, int y, int s){
//        this.x = x;
//        this.y = y;
//        this.s = s;
//    }
    
//    public void Draw(){
//        rect(x - s / 2, y - s / 2, s, s);
//    }
//}