import drop.*;

SDrop drop;
PImage pic;
boolean blur;

void setup(){
    size(1000, 1000);
    imageMode(CENTER);
    drop = new SDrop(this);
    surface.setTitle("RIGHT CLICK TO BLUR --- LEFT CLICK TO PAUSE");
    frameRate(10);
}

void draw(){
    background(0);
    if (pic != null){
        translate(width / 2, height / 2);
        image(pic, 0, 0);
        if(blur){
            color[] newPixels = new color[pic.width * pic.height];
            pic.loadPixels();
            for(int y = 0; y < pic.height; y++){
                for(int x = 0; x < pic.width; x++){
                    float r = 0;
                    float g = 0;
                    float b = 0;
                    int numChecked = 0;
                    int index;
                    for (int i = -1; i <= 1; i++){
                        for (int j = -1; j <= 1; j++){
                            index = (x + i) + (y + j) * pic.width;
                            if (index >= 0 && index < pic.pixels.length){
                                r += red(pic.pixels[index]);   
                                g += green(pic.pixels[index]);  
                                b += blue(pic.pixels[index]); 
                                numChecked++;
                            }
                        }
                    }
                    index = x + y * pic.width;
                    newPixels[index] = color(r / numChecked, g / numChecked, b / numChecked);
                }
            }
            pic.pixels = newPixels;
            pic.updatePixels();
        }
    }
}

void dropEvent(DropEvent event) {
    String type = "";
    String name = "";
    File file = null;
    if (event.isFile()){
        file = event.file();
        name = file.getName();
        type = name.substring(name.length() - 4, name.length());
    }
    
    if(event.isImage()) {
        noLoop();
        pic = event.loadImage();
        if(pic.width > width){
            pic.resize((int)((float)pic.width * ((float)width / (float)pic.width)), (int)((float)pic.height * ((float)width / (float)pic.width)));
        }
        if(pic.height > height){
            pic.resize((int)((float)pic.width * ((float)height / (float)pic.height)), (int)((float)pic.height * ((float)height / (float)pic.height)));
        }
        blur = false;
        loop();
    }
    else if(type.equalsIgnoreCase(".bmp")){
        noLoop();
        pic = loadImage(file.getPath());
        if(pic.width > width){
            pic.resize((int)((float)pic.width * ((float)width / (float)pic.width)), (int)((float)pic.height * ((float)width / (float)pic.width)));
        }
        if(pic.height > height){
            pic.resize((int)((float)pic.width * ((float)height / (float)pic.height)), (int)((float)pic.height * ((float)height / (float)pic.height)));
        }
        blur = false;
        loop();
    }
}

void mouseClicked(){
    if(mouseX >= 0 && mouseX < width && mouseY >= 0 && mouseY < height){
        if (mouseButton == LEFT){
            blur = false;
        }
        else if(mouseButton == RIGHT){
            blur = true;
        }
    }
}