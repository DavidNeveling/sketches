import drop.*;
import test.*;

SDrop drop;
PImage pic1, pic2;
PImage thumb1, thumb2;
float percent;
DropBound left, right;
LeftDropListener ldl;
RightDropListener rdl;
int x, y;
ScreenState currentState;
boolean set;
Button next, prev;

void setup(){
    size(1300, 800);
    
    int tempDim = width / 8;
    left = new DropBound(tempDim, tempDim, tempDim, tempDim);
    right = new DropBound(6 * tempDim, tempDim, tempDim, tempDim);
    
    next = new Button("Shift >", 6 * tempDim, (7 * height) / 8, tempDim, tempDim / 2);
    prev = new Button("< Back", tempDim, (7 * height) / 8, tempDim, tempDim / 2);
    
    drop = new SDrop(this);
    ldl = new LeftDropListener();
    ldl.setTargetRect(left.x, left.y, left.w, left.h);
    rdl = new RightDropListener();
    rdl.setTargetRect(right.x, right.y, right.w, right.h);
    
    drop.addDropListener(ldl);
    drop.addDropListener(rdl);
    
    imageMode(CENTER);
    
    percent = 0;
    currentState = ScreenState.LOAD;
    set = false;
    
    frameRate(15);
}

void draw() {
    
    if (currentState == ScreenState.LOAD) {
        background(255);
        
        textAlign(CENTER, CENTER);
        fill(0);
        textSize(48);
        
        text("Drag Images into the Boxes", width / 2, height / 10);
        
        noFill();
        stroke(0);
        
        rect(left.x, left.y, left.w, left.h);
        rect(right.x, right.y, right.w, right.h);
        
        if (thumb1 != null) {
            constrainPImageToBounds(thumb1, left.w, left.h);
            image(thumb1, left.x + (left.w / 2), left.y + (left.h / 2));
        }
        
        if (thumb2 != null) {
            constrainPImageToBounds(thumb2, right.w, right.h);
            image(thumb2, right.x + (right.w / 2), right.y + (right.h / 2));
        }
        
        if (set) {
            next.Draw();
            if (next.clicked()) {
                constrainPImageToBounds(pic1, width, height);
                x = (width / 2) - (pic1.width / 2);
                y = (height / 2) - (pic1.height / 2);
                if (pic1.width != pic2.width && pic1.height != pic2.height) {
                    pic2.resize(pic1.width, pic1.height);   
                }
                currentState = ScreenState.SHIFT;
            }
        }
    }
    
    if (currentState == ScreenState.SHIFT) {
        if (percent < 1) {
            background(0);
            loadPixels();
            pic1.loadPixels();
            pic2.loadPixels();
            for (int i = 0; i < pic1.height; i++) {
                for (int j = 0; j < pic1.width; j++) {
                    color c1 = pic1.pixels[j + pic1.width * i];
                    color c2 = pic2.pixels[j + pic2.width * i];
                    pixels[(j + x) + width * (i + y)] = lerpColor(c1, c2, percent);
                }
            }
            
            updatePixels();
            percent += 0.01;
        }
        
        else {
            prev.Draw();
            if (prev.clicked()){
                percent = 0;
                currentState = ScreenState.LOAD;    
            }
        }
    }
    
}

void constrainPImageToBounds(PImage img, float boundsWidth, float boundsHeight) {
    if (img.width > boundsWidth) {
        float scaleFactor = boundsWidth / img.width;
        img.resize(int(img.width * scaleFactor), int(img.height * scaleFactor));
    }
    if (img.height > boundsHeight) {
        float scaleFactor = boundsHeight / img.height;
        img.resize(int(img.width * scaleFactor), int(img.height * scaleFactor));
    }
}

// a custom DropListener class.
class LeftDropListener extends DropListener { 
    LeftDropListener() {}
    
    void dropEvent(DropEvent event) {
        String type = "";
        String name = "";
        File file = null;
        if (event.isFile()){
            file = event.file();
            name = file.getName();
            type = name.substring(name.lastIndexOf('.'), name.length());
        }
        
        if(event.isImage()) {
            noLoop();
            pic1 = event.loadImage();
            thumb1 = event.loadImage();
            
            if (pic2 != null) {
                set = true;
            }
            
            loop();
        }
        else if(type.equalsIgnoreCase(".bmp")){
            noLoop();
            pic1 = loadImage(file.getPath());
            thumb1 = loadImage(file.getPath());
            
            if (pic2 != null) {
                set = true;
            }
            
            loop();
        }
    }
}

class RightDropListener extends DropListener { 
    RightDropListener() {}
    
    void dropEvent(DropEvent event) {
        String type = "";
        String name = "";
        File file = null;
        if (event.isFile()){
            file = event.file();
            name = file.getName();
            type = name.substring(name.lastIndexOf('.'), name.length());
        }
        
        if(event.isImage()) {
            noLoop();
            pic2 = event.loadImage();
            thumb2 = event.loadImage();
            
            if (pic1 != null) {
                set = true;
            }
            loop();
        }
        else if(type.equalsIgnoreCase(".bmp")){
            noLoop();
            pic2 = loadImage(file.getPath());
            thumb2 = loadImage(file.getPath());
            
            if (pic1 != null) {
                set = true;
            }
            loop();
        }
        
    }
}