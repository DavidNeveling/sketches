boolean[][] hexGrid;
int scale;
int radius;
Button sim, clear;
boolean play;

void setup(){
    size(800, 800);
    scale = 50;
    hexGrid = new boolean[(3 * width / scale) + (3 * width / scale) / 4][height / scale];
    radius = int(width / (hexGrid[0].length * 3 - 1.5));
    sim = new Button("PLAY", 0, 0, width / 16, height / 24);
    clear = new Button("CLEAR", width / 16, 0, width / 16, height / 24);
    play = false;
}

void draw(){
    background(0);
    if (play)
        updateGrid();
    if (!play && mousePressed && !sim.MouseIsOver() && !clear.MouseIsOver() && mouseX >= 0 && mouseX < width && mouseY >= 0 && mouseY < height){
        int r = mouseX / scale;
        int c = mouseY / scale;
        hexGrid[r][c] = !hexGrid[r][c];
    }
    drawGrid();
    sim.show();
    clear.show();
}

void drawHexagon(int x, int y, int r, boolean fill, boolean stroke, color fCol, color sCol){
    if (fill)
        fill(fCol);
    else
        noFill();
    if (stroke)
        stroke(sCol);
    else
        noStroke();
        
    float angle = 0;
    beginShape();
    
    while(angle < TWO_PI){
        vertex(x + r * cos(angle), y + r * sin(angle));    
        angle += (PI / 3);
    }
    endShape();
}

void drawGrid(){
    for(int r = 0; r < hexGrid.length; r++){
        for (int c = 0; c < hexGrid[0].length; c++){
            if(r % 2 == 0){
                drawHexagon(3 * radius * c, int(cos(PI / 6) * radius * r), radius, false, true, 0, color(255));
            }
            else{
                drawHexagon(int((3.0 / 2) * radius) + 3 * radius * c, int(cos(PI / 6) * radius * r), radius, false, true, 0, color(255));
            }
        }
    }
}

void updateGrid(){
    for (int r = 0; r < hexGrid.length; r++){
        for (int c = 0; c < hexGrid[0].length; c++){
             int n = getNeighbors(r, c);
             if (hexGrid[r][c]){
                 if (n < 2 || n > 3)
                     hexGrid[r][c] = false;
             }
             else{
                 if (n == 3)
                     hexGrid[r][c] = true;
             }
        }
    }
}

int getNeighbors(int r, int c){
    int sum = 0;
    
    return sum;
}

void mouseClicked() {
    if (sim.MouseIsOver()) {
        if (sim.label.compareTo("PLAY") == 0){
            sim.label = "PAUSE";
            play = true;
        }
        else{
            sim.label = "PLAY";
            play = false;
        }
    } 
    else if (clear.MouseIsOver()){
        hexGrid = new boolean[width / scale][height / scale];
        play = false;
        sim.label = "PAUSE";
    }
}

class Button {
    String label;
    float x;    // top left corner x position
    float y;    // top left corner y position
    float w;    // width of button
    float h;    // height of button
      
    Button(String labelB, float xpos, float ypos, float widthB, float heightB) {
        label = labelB;
        x = xpos;
        y = ypos;
        w = widthB;
        h = heightB;
    }
      
    void show() {
        
        fill(218);
        stroke(141);
        rect(x, y, w, h, 10);
        textAlign(CENTER, CENTER);
        fill(255);
        text(label, x + (w / 2), y + (h / 2));
        
    }
      
    boolean MouseIsOver() {
        if (mouseX > x && mouseX < (x + w) && mouseY > y && mouseY < (y + h)) {
          return true;
        }
        return false;
    }
    
    boolean clicked(){
        return MouseIsOver() && mousePressed;
    }
}