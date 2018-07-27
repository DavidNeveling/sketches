boolean[][] grid;
int scale, off;
Button sim, clear;
boolean play;

void setup(){
    size(800, 800);
    sim = new Button("PLAY", 0, 0, width / 16, height / 24);
    clear = new Button("CLEAR", width / 16, 0, width / 16, height / 24);
    scale = 16;
    off = 1;
    grid = new boolean[width / scale][height / scale];
    play = false;
}

void draw(){
    background(200);
    if (play)
        updateGrid();
      
    /*    
    if (sim.clicked()) {
        if (sim.label.compareTo("PLAY") == 0){
            sim.label = "PAUSE";
            play = true;
        }
        else{
            sim.label = "PLAY";
            play = false;
        }
    }
    
    if (clear.clicked()) {
        grid = new boolean[width / scale][height / scale];
        play = false;
        sim.label = "PAUSE";
    }
    */
    if (!play && mousePressed && !sim.MouseIsOver() && !clear.MouseIsOver() && mouseX >= 0 && mouseX < width && mouseY >= 0 && mouseY < height){
        int r = mouseX / scale;
        int c = mouseY / scale;
        grid[r][c] = !grid[r][c];
    }
    drawGrid();
    sim.show();
    clear.show();
}

void drawGrid(){
    for (int r = 0; r < grid.length; r++){
        for (int c = 0; c < grid[0].length; c++){
            if (grid[r][c] == false)
                fill(0);
            else
                fill(255, 0, 0);
            rect(r * scale + off, c * scale + off, scale - 2 * off, scale - 2 * off);
            
        }
    }
}

void updateGrid(){
    for (int r = 0; r < grid.length; r++){
        for (int c = 0; c < grid[0].length; c++){
             int n = getNeighbors(r, c);
             if (grid[r][c]){
                 if (n < 2 || n > 3)
                     grid[r][c] = false;
             }
             else{
                 if (n == 3)
                     grid[r][c] = true;
             }
        }
    }
}

int getNeighbors(int r, int c){
    int sum = 0;
    if (r == 0){
        if (grid[grid.length - 1][c])
            sum++;
    }
    else{
        if (grid[r - 1][c])
            sum++;
    }
    if (r == grid.length - 1){
        if (grid[0][c])
            sum++;
    }
    else{
        if (grid[r + 1][c])
            sum++;
    }
    if (c == 0){
        if (grid[r][grid[0].length - 1])
            sum++;
    }
    else{
        if (grid[r][c - 1])
            sum++;
    }
    if (c == grid[0].length - 1){
        if (grid[r][0])
            sum++;
    }
    else{
        if (grid[r][c + 1])
            sum++;
    }
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
        grid = new boolean[width / scale][height / scale];
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