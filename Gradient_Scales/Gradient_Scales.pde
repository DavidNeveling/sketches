color c1;
color c2;
int squareWidth;
int numSquares;
void setup(){
    size(400, 400);
    surface.setResizable(true);
    squareWidth = 200;
    numSquares = 5;
    surface.setSize(numSquares*squareWidth, squareWidth);
    c1 = color(200, 200, 255);
    c2 = color(0);
}

void draw(){
    float split = width/numSquares;
    int x = (int)split;
    // compare the 2 colors
    noStroke();
    fill(c1);
    rect(0, 0, split, height/2);
    fill(c2);
    rect(0, height/2, split, height/2);
    
    // add separator
    stroke(0);
    strokeWeight(2);
    line(x, 0, x, height);
    strokeWeight(1);
    
    
    for(int i = 0; i < height; i++){ // sin() gradient
        stroke(lerpColor(c1, c2, sin(map(i, 0, height, 0, HALF_PI))));
        line(x, i, x + split, i);
    }
    
    x += split;
    stroke(0);
    strokeWeight(2);
    line(x, 0, x, height);
    strokeWeight(1);
    
    
    for(int i = 0; i < height; i++){ // cos() gradient
        stroke(lerpColor(c1, c2, 1 - cos(map(i, 0, height, 0, HALF_PI))));
        line(x, i, x + split, i);
    }
    
    x += split;
    stroke(0);
    strokeWeight(2);
    line(x, 0, x, height);
    strokeWeight(1);
    
    for(int i = 0; i < height; i++){ // linear gradient
        stroke(lerpColor(c1, c2, map(i, 0, height, 0, 1)));
        line(x, i, x + split, i);
    }
    
    x += split;
    stroke(0);
    strokeWeight(2);
    line(x, 0, x, height);
    strokeWeight(1);
    
    for(int i = 0; i < height; i++){ // half circle gradient
        stroke(lerpColor(c1, c2, sin(map(i, 0, height, 0, PI))));
        line(x, i, x + split, i);
    }
    saveFrame("gradients.png");
    noLoop();
}