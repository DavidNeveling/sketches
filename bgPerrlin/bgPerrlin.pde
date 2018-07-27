int bgw, bgh;
int bgCol, bgRow;
int scale;
float move;
float[][] bg;
void setup() {
    size(1000, 1000);
    bgw = width;
    bgh = height;
    scale = 1;
    bgCol = bgw / scale;
    bgRow = bgh / scale;
    bg = new float[bgCol][bgRow];
}

void draw(){
    strokeWeight(1);
    move -= 0.5;
    float y = move;
    for (int i = 0; i < bgRow; i++) {
        float x = 0;
        for (int j = 0; j < bgCol; j++) {
            bg[j][i] = map(noise(x, y), 0, 1, 0, 256);
            stroke(0, 256 - bg[i][j], bg[i][j]);
            rect(i * scale, j * scale, scale, scale);
            x += 0.1;
        }
        y += 0.1;
    }
    saveFrame("frames/frame_####.png");
}