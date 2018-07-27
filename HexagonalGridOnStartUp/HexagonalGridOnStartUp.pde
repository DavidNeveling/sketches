boolean[][] hexGrid;
int scale;
int radius;
boolean delay;

void setup(){
    size(800, 800);
    scale = 50;
    hexGrid = new boolean[(3 * width / scale) + (3 * width / scale) / 4][height / scale];
    radius = int(width / (hexGrid[0].length * 3 - 1.5));
    delay = true;
    background(0);
    randomizeGrid();
    drawGrid();
}

void draw(){
    background(0);
    updateGrid();
    drawGrid();
    if (delay){
        delay(20);    
    }
        
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
            int x = 3 * radius * c;
            if(r % 2 == 1)
                x += int((3.0 / 2) * radius);
            color fillColor;
            if (hexGrid[r][c])
                fillColor = color(255, 0, 0);
            else
                fillColor = color(20);
            drawHexagon(x, int(cos(PI / 6) * radius * r), radius, true, true, fillColor, color(0));
        }
    }
}

void updateGrid(){
    for (int r = 0; r < hexGrid.length; r++){
        for (int c = 0; c < hexGrid[0].length; c++){
             int n = getNeighbors(r, c);
             if (hexGrid[r][c]){
                 if (n % 2 == 1) // old rules (n < 2 || n > 3)
                     hexGrid[r][c] = false;
             }
             else{
                 if (n % 3 == 0) // old rules (n == 3)
                     hexGrid[r][c] = true;
             }
        }
    }
}

int getNeighbors(int r, int c){
    int sum = 0;
    if (r % 2 == 0){
        try {
            if(hexGrid[r - 2][c])
                sum++;
        }
        catch (ArrayIndexOutOfBoundsException e){}
        try {
            if(hexGrid[r - 1][c])
                sum++;
        }
        catch (ArrayIndexOutOfBoundsException e){}
        try {
            if(hexGrid[r - 1][c - 1])
                sum++;
        }
        catch (ArrayIndexOutOfBoundsException e){}
        try {
            if(hexGrid[r + 1][c])
                sum++;
        }
        catch (ArrayIndexOutOfBoundsException e){}
        try {
            if(hexGrid[r + 1][c - 1])
                sum++;
        }
        catch (ArrayIndexOutOfBoundsException e){}
        try {
            if(hexGrid[r + 2][c])
                sum++;
        }
        catch (ArrayIndexOutOfBoundsException e){}
    }
    else {
        try {
            if(hexGrid[r - 2][c])
                sum++;
        }
        catch (ArrayIndexOutOfBoundsException e){}
        try {
            if(hexGrid[r - 1][c])
                sum++;
        }
        catch (ArrayIndexOutOfBoundsException e){}
        try {
            if(hexGrid[r - 1][c + 1])
                sum++;
        }
        catch (ArrayIndexOutOfBoundsException e){}
        try {
            if(hexGrid[r + 1][c])
                sum++;
        }
        catch (ArrayIndexOutOfBoundsException e){}
        try {
            if(hexGrid[r + 1][c + 1])
                sum++;
        }
        catch (ArrayIndexOutOfBoundsException e){}
        try {
            if(hexGrid[r + 2][c])
                sum++;
        }
        catch (ArrayIndexOutOfBoundsException e){}
    }
    
    return sum;
}

void randomizeGrid(){
    for (int r = 0; r < hexGrid.length; r++){
        for (int c = 0; c < hexGrid[0].length; c++){
             hexGrid[r][c] = random(0, 1) >= 0.5;
        }
    }
    drawGrid();
}

void mouseClicked(){
    if (mouseX >= 0 && mouseX < width && mouseY >= 0 && mouseY < height)
        randomizeGrid();
}