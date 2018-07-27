int[][] pile;
int scale;
int pileSize;
int pileMax;
int pass;
int advance;
boolean delay;
void setup(){
    size(800, 800);
    scale = 4;
    pile = new int[width / scale][height / scale];
    pileSize = 1000000;
    pileMax = 4; // some number >= 4
    pass = 1;
    advance = 1000;
    initPile();
    delay = false;
}

void draw(){
    for (int i = 0; i < advance; i++){
        //advancePile();         // unsafe: pile values are changed per unit rather than per cycle
        //advancePileAux();      // works w/ >= 8
        //advancePileInToOut();  // unsafe: pile values are changed per unit rather than per cycle
        advancePileInToOutAux(); // works w/ >= 4
    }
    noStroke();
    drawPile();
    pass++;
    if(delay)
        delay(50);
}

void advancePile(){
    for (int i = 0; i < pile.length; i++){
        for (int j = 0; j < pile[0].length; j++){
            if (pile[i][j] > pileMax){
                int inc;
                if (pass % 2 == 0){
                    pile[i][j] -= pileMax;
                    inc = pileMax / 4;
                }
                else{
                    pile[i][j] -= pileMax / 2;
                    inc = pileMax / 8;
                }
                if (i > 0)
                    pile[i-1][j] += inc;
                if (j > 0)
                    pile[i][j-1] += inc;
                if (i < pile.length-1)
                    pile[i+1][j] += inc;
                if (j < pile[0].length-1)
                    pile[i][j+1] += inc;
            }
            else if (pile[i][j] > pileMax / 2){
                pile[i][j] -= pileMax / 2;
                if (i > 0)
                    pile[i-1][j] += pileMax / 8;
                if (j > 0)
                    pile[i][j-1] += pileMax / 8;
                if (i < pile.length-1)
                    pile[i+1][j] += pileMax / 8;
                if (j < pile[0].length-1)
                    pile[i][j+1] += pileMax / 8;
            }
        }
    }    
}

void advancePileInToOut(){
    int radius = pile.length / 2;
    int centerX = (pile.length / 2) + 1;
    int centerY = (pile.length / 2) + 1;
    for (int r = 0; r < radius - 1; r++){
        for (int x = centerX - r; x <= centerX + r; x++){
            if (pile[centerY - r][x] > pileMax){
                pile[centerY - r][x] -= pileMax;
                if (centerY - r > 0)
                    pile[centerY - r-1][x] += 1;
                if (x > 0)
                    pile[centerY - r][x-1] += 1;
                if (centerY - r < pile.length-1)
                    pile[centerY - r+1][x] += 1;
                if (x < pile[0].length-1)
                    pile[centerY - r][x+1] += 1;
            }
            if (pile[centerY + r][x] > pileMax && centerY - r != centerY + r){
                pile[centerY + r][x] -= pileMax;
                if (centerY + r > 0)
                    pile[centerY + r-1][x] += 1;
                if (x > 0)
                    pile[centerY + r][x-1] += 1;
                if (centerY + r < pile.length-1)
                    pile[centerY + r+1][x] += 1;
                if (x < pile[0].length-1)
                    pile[centerY + r][x+1] += 1;
            }
        }
        for (int y = centerY - r + 1; y < centerY + r; y++){
             if (pile[y][centerX - r] > pileMax){
                pile[y][centerX - r] -= pileMax;
                if (y > 0)
                    pile[y-1][centerX - r] += 1;
                if (centerX - r > 0)
                    pile[y][centerX - r-1] += 1;
                if (y < pile.length-1)
                    pile[y+1][centerX - r] += 1;
                if (centerX - r < pile[0].length-1)
                    pile[y][centerX - r+1] += 1;
            }
            if (pile[y][centerX + r] > pileMax && centerX - r != centerX + r){
                pile[y][centerX + r] -= pileMax;
                if (y > 0)
                    pile[y-1][centerX + r] += 1;
                if (centerX + r > 0)
                    pile[y][centerX + r-1] += 1;
                if (y < pile.length-1)
                    pile[y+1][centerX + r] += 1;
                if (centerX + r < pile[0].length-1)
                    pile[y][centerX + r+1] += 1;
            }
        }
    }
}

void advancePileAux(){
    int[][] changes = new int[pile.length][pile[0].length];
    for (int i = 0; i < pile.length; i++){
        for (int j = 0; j < pile[0].length; j++){
            if (pile[i][j] > pileMax){
                int inc;
                if (pass % 2 == 0){
                    changes[i][j] -= pileMax;
                    inc = pileMax / 4;
                }
                else{
                    changes[i][j] -= pileMax / 2;
                    inc = pileMax / 8;
                }
                if (i > 0)
                    changes[i-1][j] += inc;
                if (j > 0)
                    changes[i][j-1] += inc;
                if (i < pile.length-1)
                    changes[i+1][j] += inc;
                if (j < pile[0].length-1)
                    changes[i][j+1] += inc;
            }
            else if (pile[i][j] > pileMax / 2){
                changes[i][j] -= pileMax / 2;
                if (i > 0)
                    changes[i-1][j] += pileMax / 8;
                if (j > 0)
                    changes[i][j-1] += pileMax / 8;
                if (i < pile.length-1)
                    changes[i+1][j] += pileMax / 8;
                if (j < pile[0].length-1)
                    changes[i][j+1] += pileMax / 8;
            }
        }
    }    
    for (int r = 0; r < pile.length; r++){
        for (int c = 0; c < pile[0].length; c++){
            pile[r][c] += changes[r][c];    
        }
    }
}

void advancePileInToOutAux(){
    int[][] changes = new int[pile.length][pile[0].length];
    int radius = pile.length / 2;
    int centerX = (pile.length / 2) + 1;
    int centerY = (pile.length / 2) + 1;
    for (int r = 0; r < radius - 1; r++){
        for (int x = centerX - r; x <= centerX + r; x++){
            if (pile[centerY - r][x] > pileMax){
                changes[centerY - r][x] -= pileMax;
                if (centerY - r > 0)
                    changes[centerY - r-1][x] += 1;
                if (x > 0)
                    changes[centerY - r][x-1] += 1;
                if (centerY - r < pile.length-1)
                    changes[centerY - r+1][x] += 1;
                if (x < pile[0].length-1)
                    changes[centerY - r][x+1] += 1;
            }
            if (pile[centerY + r][x] > pileMax && centerY - r != centerY + r){
                changes[centerY + r][x] -= pileMax;
                if (centerY + r > 0)
                    changes[centerY + r-1][x] += 1;
                if (x > 0)
                    changes[centerY + r][x-1] += 1;
                if (centerY + r < pile.length-1)
                    changes[centerY + r+1][x] += 1;
                if (x < pile[0].length-1)
                    changes[centerY + r][x+1] += 1;
            }
        }
        for (int y = centerY - r + 1; y < centerY + r; y++){
             if (pile[y][centerX - r] > pileMax){
                changes[y][centerX - r] -= pileMax;
                if (y > 0)
                    changes[y-1][centerX - r] += 1;
                if (centerX - r > 0)
                    changes[y][centerX - r-1] += 1;
                if (y < pile.length-1)
                    changes[y+1][centerX - r] += 1;
                if (centerX - r < pile[0].length-1)
                    changes[y][centerX - r+1] += 1;
            }
            if (pile[y][centerX + r] > pileMax && centerX - r != centerX + r){
                changes[y][centerX + r] -= pileMax;
                if (y > 0)
                    changes[y-1][centerX + r] += 1;
                if (centerX + r > 0)
                    changes[y][centerX + r-1] += 1;
                if (y < pile.length-1)
                    changes[y+1][centerX + r] += 1;
                if (centerX + r < pile[0].length-1)
                    changes[y][centerX + r+1] += 1;
            }
        }
    }
    for (int r = 0; r < pile.length; r++){
        for (int c = 0; c < pile[0].length; c++){
            pile[r][c] += changes[r][c];    
        }
    }
}

void drawPile(){
    for (int i = 0; i < pile.length; i++){
        for (int j = 0; j < pile[0].length; j++){
            fill(mapColor(pile[i][j]));
            rect(i * scale, j * scale, scale, scale);
        }
    }
}

color mapColor(int size){
    color ret;
    switch (size){
        case 1: ret = color(255);
                break;
        
        case 2: ret = color(255, 0, 0);
                break;
        
        case 3: ret = color(0, 255, 0);
                break;
        
        case 4: ret = color(0, 0, 255);
                break;
        
        case 5: ret = color(255, 255, 0);
                break;
        
        case 6: ret = color(255, 0, 255);
                break;
        
        case 7: ret = color(0, 255, 255);
                break;
        
        default: ret = color(0);
                 break;
    }
    return ret; 
}

void initPile(){
    pile[(pile.length / 2) + 1][(pile[0].length / 2) + 1] = pileSize;
    
    //pile[((pile.length / 2) + 1) - 10][((pile[0].length / 2) + 1)] = pileSize / 2;
    //pile[((pile.length / 2) + 1)][((pile[0].length / 2) + 1) - 10] = pileSize / 2;
    //pile[((pile.length / 2) + 1) + 10][((pile[0].length / 2) + 1)] = pileSize / 2;
    //pile[((pile.length / 2) + 1)][((pile[0].length / 2) + 1) + 10] = pileSize / 2;
    
}

void printPile(){
  for (int i = 0; i < pile.length; i++){
    for (int j = 0; j < pile[0].length; j++){
      System.out.printf("%5d", pile[i][j]);  
    }
    System.out.println();
  }
}

void keyPressed(){
    if (key == ' ') {
      delay = !delay;
    }
}