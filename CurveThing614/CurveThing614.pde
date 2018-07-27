boolean[] numberLine;
int pos;
int size;
int move;
boolean curveUp;
void setup(){
    size(600, 600);
    size = 20;
    numberLine = new boolean[size];
    pos = 0;
    move = 0;
    textAlign(CENTER, CENTER);
}

void draw(){
    background(0);
    noStroke();
    drawLine();
    if(pos < size){
        advance();
        delay(500);
    }
}

void drawLine(){
    for(int i = 0; i < size; i++){
        if (numberLine[i])
            fill(255);
        else
            fill(0, 255, 0);
        float x = map(i, 0, size, width / 10, 9 * width / 10);
        ellipse(x, height / 2, 200 / size, 200 / size);    
        text(""+i, x, height / 2 + 220 / size );
    }
}

void advance(){
    if (pos - move < 0 || numberLine[pos - move]){
        pos += move;
        if(pos < size)
            numberLine[pos] = true;
    }
    else {
        pos -= move;    
        numberLine[pos] = true;
    }
    move++;
}