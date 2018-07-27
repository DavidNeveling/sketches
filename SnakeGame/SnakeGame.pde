int[][] grid;
int scale;
Point snakeFront;
Point pill;
int snakeSize;
Dir snakeDir;
boolean GameOver;
int updateCount, speed;

void setup(){
    size(1000, 1000);
    scale = 50;
    grid = new int[width / scale][height / scale];
    snakeSize = 1;
    snakeFront = new Point(0, 0);
    grid[snakeFront.y][snakeFront.x] = snakeSize;
    snakeDir = Dir.right;
    pill = randomPill();
    frameRate(60);
    updateCount = 0;
    speed = 4;
    keyPressed = true;
}

void draw(){
    background(0);
    if(keyPressed){
        println("pressed");
        if (keyCode == LEFT || key == 'a'){
            snakeDir = Dir.left;
        }
        else if (keyCode == RIGHT || key == 'd'){
            snakeDir = Dir.right;
        }
        else if (keyCode == UP || key == 'w'){
            snakeDir = Dir.up;
        }
        else if (keyCode == DOWN || key == 's'){
            snakeDir = Dir.down;
        }    
        else if (keyCode == ENTER && GameOver){
            grid = new int[width / scale][height / scale];
            snakeSize = 1;
            snakeFront = new Point(0, 0);
            grid[snakeFront.y][snakeFront.x] = snakeSize;
            snakeDir = Dir.right;
            pill = randomPill();
            GameOver = false;
        }
        keyPressed = false;
    }
    drawGrid();
    if (frameCount > updateCount + speed && !GameOver){
        updateGrid();
        updateCount = frameCount;
    }
    //println(snakeDir);
}
void drawGrid(){
    for (int r = 0; r < grid.length; r++){
        for (int c = 0; c < grid[0].length; c++){
            if (grid[r][c] > 0){
                fill(255);
                rect(c * scale, r * scale, scale, scale);    
            }
            if (grid[r][c] < 0){
                fill(0, 0, 255);
                rect(c * scale, r * scale, scale, scale);
            }
        }
    }
}

void updateGrid(){
    boolean changeSet = true;
    if (snakeDir == Dir.left && snakeFront.x == pill.x + 1 && snakeFront.y == pill.y || 
        snakeDir == Dir.right && snakeFront.x == pill.x - 1 && snakeFront.y == pill.y ||
        snakeDir == Dir.down && snakeFront.y == pill.y - 1 && snakeFront.x == pill.x ||
        snakeDir == Dir.up  && snakeFront.y == pill.y + 1 && snakeFront.x == pill.x){
        
        snakeFront = pill;
        snakeSize++;
        grid[snakeFront.y][snakeFront.x] = snakeSize;
        changeSet = false;
        pill = randomPill();
    }
    if (changeSet){

        for (int r = 0; r < grid.length; r++){
            for (int c = 0; c < grid[0].length; c++){
                
                if (grid[r][c] > 0){
                    grid[r][c]--;    
                }
            }
        }
        if (snakeDir == Dir.left){
            if (snakeFront.x <= 0 || grid[snakeFront.y][snakeFront.x - 1] > 0){
                GameOver = true; 
                //printGrid();
            }
            else{
                snakeFront.x--;
                grid[snakeFront.y][snakeFront.x] = snakeSize;
            }
        } 
        else if (snakeDir == Dir.right){
            if (snakeFront.x >= grid[0].length - 1  || grid[snakeFront.y][snakeFront.x + 1] > 0){
                GameOver = true;  
                //printGrid();
            }
            else{
                snakeFront.x++;
                grid[snakeFront.y][snakeFront.x] = snakeSize;
            }
        }
        else if (snakeDir == Dir.down){
            if (snakeFront.y >= grid.length - 1  || grid[snakeFront.y + 1][snakeFront.x] > 0){
                GameOver = true;  
                //printGrid();
            }
            else{
                snakeFront.y++;
                grid[snakeFront.y][snakeFront.x] = snakeSize;
            }
        }
        else if (snakeDir == Dir.up){
            if (snakeFront.y <= 0  || grid[snakeFront.y - 1][snakeFront.x] > 0){
                GameOver = true; 
                //printGrid();
            }
            else{
                snakeFront.y--;
                grid[snakeFront.y][snakeFront.x] = snakeSize;
            }
        }
    }
}

void printGrid(){
    for (int r = 0; r < grid.length; r++){
        for (int c = 0; c < grid[0].length; c++){
            print(grid[r][c] + "\t");
        }
        println();
    }   
    println(snakeDir);
}

Point randomPill(){
    boolean set = false;
    int r = Integer.MAX_VALUE;
    int c = Integer.MAX_VALUE;
    while (!set){
        r = int(random(grid.length));
        c = int(random(grid[0].length));
        if (grid[r][c] == 0){
            set = true;
            grid[r][c] = -1;
        }
    }
    return new Point(c, r);
}

class Point{
    int x;
    int y;
    
    public Point(int x, int y){
        this.x = x;
        this.y = y;
    }
}

enum Dir{
    up,
    down,
    left,
    right
}

void keyPressed(){
    if (keyCode == LEFT){
        snakeDir = Dir.left;
    }
    else if (keyCode == RIGHT){
        snakeDir = Dir.right;
    }
    else if (keyCode == UP){
        snakeDir = Dir.up;
    }
    else if (keyCode == DOWN){
        snakeDir = Dir.down;
    }
}