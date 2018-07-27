boolean[] numberLine;
int pos;
int size;
int move;
int curveUp;
int state;
float x1;
float x2;
float xMid;
float r;
float a_p;
float a;
float speed;
float nose1;
float nose2;
void setup(){
    size(600, 600);
    size = 250;
    speed = .1;
    numberLine = new boolean[size];
    numberLine[0] = true;
    pos = 0;
    move = 1;
    background(0);
    curveUp = 1;
    state = 0;
    strokeWeight(1);
    x1 = 0;
    x2 = 0;
    xMid = 0;
    r = 0;
    a_p = 0;
    a = 0;
    speed = 0.1;
    nose1 = 0;
    nose2 = 0;
}

void draw(){
    if(state == 0){
        x1 = map(pos, 0, size, width / 10, 9 * width / 10);
        if(pos >= size)
            noLoop();
        if (pos - move < 0 || numberLine[pos - move]){
            pos += move;
            if(pos < size)
                numberLine[pos] = true;
        }
        else {
            pos -= move;    
            numberLine[pos] = true;
        }
        x2 = map(pos, 0, size, width / 10, 9 * width / 10);
        xMid = (x1 + x2) / 2;
        r = abs(x2 - xMid);
        if (x2 > x1){
            state = 1;
            a_p = PI;
            a = PI;
        }
        else{
            state = 2;
            a_p = TWO_PI;
            a = TWO_PI;
        }
        curveUp *= -1;
        move += 1 + frameCount % 2;
    }
    if(state == 1){
        pushMatrix();
        translate(xMid, height / 2);
        line(r * cos(a_p), curveUp * r * sin(a_p), r * cos(a), curveUp * r * sin(a));
        popMatrix();
        a_p = a;
        a += speed;
        if (a > TWO_PI + speed)
            state = 0;
    }
    if(state == 2){
        pushMatrix();
        translate(xMid, height / 2);
        line(r * cos(a_p), curveUp * r * sin(a_p), r * cos(a), curveUp * r * sin(a));
        popMatrix();
        a_p = a;
        a -= speed;
        if (a < PI - speed)
            state = 0;
    }
    nose1 += 0.01;
    nose2 += 0.05;
    stroke(noise(nose1) * 255, 0, noise(nose2) * 255);
}