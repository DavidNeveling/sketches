ArrayList<Point> points;
float scalar;
int randRange;
void setup(){
    size(600, 600);
    points = new ArrayList<Point>();
    scalar = 30;
    colorMode(HSB);
    randRange = 2;
    for (int i = 0; i < 6; i++){
        float x, y;
        x = random(width);
        y = random(height);
        while (x < width * .3 || x > width * .7)
            x = random(width);
        points.add(new Point(new PVector(x, y), new PVector(random(-randRange, randRange), random(-randRange, randRange))));
    }
}

void draw(){
    loadPixels();
    for(int j = 0; j < height; j++){
        for(int i = 0; i < width; i++){
            float sum = 0;
            for (Point p : points){
                sum += scalar * p.size / dist(i, j, p.pos.x, p.pos.y);
            }
            pixels[i + width * j] = color(constrain(sum, 90, map(240, 0, 360, 0, 255)), 255, 255);
        }
    }
    updatePixels();
    noStroke();
    fill(0);
    beginShape();
        vertex(0, 0);
        vertex(width * .3, 0);
        vertex(width * .1, height * .7);
        vertex(width * .3, height);
        vertex(0, height);
        vertex(0, 0);
    endShape();
    beginShape();
        vertex(width * .7, 0);
        vertex(width, 0);
        vertex(width, height);
        vertex(width * .7, height);
        vertex(width * .9, height * .7);
        vertex(width * .7, 0);
    endShape();
    for (Point p : points){
        p.update();    
    }
}

class Point{
    PVector pos, vec;
    float size;
    public Point(PVector a, PVector b){
        pos = a;
        vec = b;
        size = random(100, 200);
    }
    
    public void update(){
        pos.x += vec.x;
        pos.y += vec.y;
        //a
        if(pos.y < ((-7.0/2) * pos.x + height * 1.05) + (randRange * 2) && pos.y > ((-7.0/2) * pos.x + height * 1.05) - (randRange * 2)){
            vec.x *= -1;
            pos.x += vec.x;
            pos.y += vec.y;
        }
        //b
        else if(pos.y < ((3.0/2) * pos.x + height * .55) + (randRange * 2) && pos.y > ((3.0/2) * pos.x + height * .55) - (randRange * 2)){
            vec.x *= -1;
            pos.x += vec.x;
            pos.y += vec.y;
        }
        //c
        else if(pos.y < (-(3.0/2) * pos.x + height * 2.05) + (randRange * 2) && pos.y > (-(3.0/2) * pos.x + height * 2.05) - (randRange * 2)){
            vec.x *= -1;
            pos.x += vec.x;
            pos.y += vec.y;
        }
        //d
        else if(pos.y < ((7.0/2) * pos.x - height * 2.45) + (randRange * 2) && pos.y > ((7.0/2) * pos.x - height * 2.45) - (randRange * 2)){
            vec.x *= -1;
            pos.x += vec.x;
            pos.y += vec.y;
        }
        else if(pos.y < 0 || pos.y > height){
            vec.y *= -1;
            pos.x += vec.x;
            pos.y += vec.y;
        }
    }
}