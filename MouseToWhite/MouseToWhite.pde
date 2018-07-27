PImage pic;
PImage pic2;
int rh, rl, gh, gl, bh, bl;

void setup(){
    size(1800, 1000);
    pic = loadImage("invPic.png");
    rh = 250;
    rl = 0;
    gh = 160;
    gl = 0;
    bh = 250;
    bl = 0;
}

void draw(){
    //image(pic, 0, 0);
    loadPixels();
    int w = pic.width;
    int h = pic.height;
    for(int i = 0; i < h; i++){
        for(int j = 0; j < w; j++){
            if(i > 300 && i < 800 && j < 800 && j > 680 && red(pic.pixels[i * w + j]) <= rh && red(pic.pixels[i * w + j]) >= rl && green(pic.pixels[i * w + j]) >= gl && green(pic.pixels[i * w + j]) <= gh && blue(pic.pixels[i * w + j]) <= bh && blue(pic.pixels[i * w + j]) >= bl){
                pic.pixels[i * w + j] = color(0, 255, 0);
            }
        }
    }
    //for(int i = 0; i < (w * h); i++){
    //// set grayscale( (0.3 * R) + (0.59 * G) + (0.11 * B) )
    //  pic2.pixels[i] = color((red(pic2.pixels[i]) * .3) + (green(pic2.pixels[i]) * .59) + (blue(pic2.pixels[i]) * .11));
    //}
    ////for(int i = 0; i < h; i++){
    ////    for(int j = 0; j < w; j++){
    ////        if(pic.pixels[i * w + j] < 90)
    ////            pic.pixels[i * w + j] = color(map(pic.pixels[i * w + j], color(15), color(90), color(180), color(255)));
    ////    }
    ////}
    image(pic, 0, 0);
    saveFrame("natha.png");
    noLoop();
}