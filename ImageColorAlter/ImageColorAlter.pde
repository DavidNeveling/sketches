import controlP5.*;

import java.io.FilenameFilter;
import java.io.File.*;
import java.lang.Exception;
import java.util.Collections;
import static java.lang.System.*;

static final FilenameFilter FILTER = new FilenameFilter() {
    static final String JPG = ".jpg", JPEG = ".jpeg", PNG = ".png", GIF = ".gif", bJPG = ".JPG"; //only first frame of gif

    @ Override boolean accept(File path, String name) {
        return name.endsWith(JPG) || name.endsWith(JPEG) || name.endsWith(PNG) || name.endsWith(GIF) || name.endsWith(bJPG);
    }
};

File p = dataFile(dataPath(""));
File f = new File("D:\\Code\\processing-4.3\\sketches\\ImageColorAlter\\data");
String[] names;
Button[] files;

PImage pic;
int index;
int offset;

int numThresholds;
int[] thresholds;
int[] thresholdColors;
SuperHScrollbar[] scrollbars;
ArrayList<ThresholdTask> tasks;

boolean fileSelected;
boolean scrollSelected;
boolean colorSelected;

int filesStart;

int maxEnd;
boolean set;
int[] thresh;

Button load;
ControlP5 cp5;

void setup() {
    size(400, 400);
    surface.setResizable(true);
    surface.setSize(displayWidth, displayHeight);
    //fullScreen();
    cp5 = new ControlP5(this);
    names = f.list(FILTER);
    files = new Button[names.length];
    fileSelected = false;
    colorSelected = false;
    filesStart = 0;
    set = false;
    
    for (int i = 0; i < names.length; i++) {
        files[i] = new Button(names[i], 0, 0, width, 100);
    }
    
    tasks = new ArrayList<ThresholdTask>();
    tasks.add(new DefaultTask());
    tasks.add(new EvenTask());
    tasks.add(new ClusteringTask());
    
    load = new Button("LOAD IMAGE", (7 * width) / 8, (7 * height) / 8, width / 8, height / 8);
    maxEnd = names.length * 100;
    
    index = 0;
    offset = 30;
    
    numThresholds = 5; // originally designed around 3
    thresholds = new int[numThresholds];
    thresholdColors = new int[numThresholds + 1];
    scrollbars = new SuperHScrollbar[numThresholds + 1];
    
    int scrollbarHeight = int((.75 * height) / (4 * (numThresholds + 1)));
    int scrollbarWidth = (6 * width) / 7;
    int scrollbarStart = (3 * height) / 20;
    
    for (int i = 0; i <= numThresholds; i++) {
        thresholdColors[i] = color(map(i, 0, 3, 0, 255));    
        int temp = i * 4;
        scrollbars[i] = new SuperHScrollbar(
            new HScrollbar(0, scrollbarStart + (temp) * scrollbarHeight, scrollbarWidth, scrollbarHeight, 1), 
            new HScrollbar(0, scrollbarStart + (temp + 1) * scrollbarHeight, scrollbarWidth, scrollbarHeight, 1),
            new HScrollbar(0, scrollbarStart + (temp + 2) * scrollbarHeight, scrollbarWidth, scrollbarHeight, 1)
        );
    }
    scrollSelected = false;
    thresh = new int[256];
}

void draw() {
    if (colorSelected) {
        background(0);
        pic = loadImage(names[index]);
        updateImg();

        pic.save("changed/" + names[index] + "_changed.png");

        if (pic.width > width) {
            pic.resize((int)((float)pic.width * ((float)width / (float)pic.width)), (int)((float)pic.height * ((float)width / (float)pic.width)));
        }
        if (pic.height > height) {
            pic.resize((int)((float)pic.width * ((float)height / (float)pic.height)), (int)((float)pic.height * ((float)height / (float)pic.height)));
        }
        
        translate(width / 2, height / 2);
        imageMode(CENTER);
        image(pic, 0, 0);
        noLoop();
    } else if (fileSelected) {
        /*thresholds = new int[numThresholds];
        thresholdColors = new int[numThresholds + 1];
        scrollbars = new SuperHScrollbar[numThresholds + 1];
        
        int scrollbarHeight = int((.75 * height) / (4 * (numThresholds + 1)));
        int scrollbarWidth = (6 * width) / 7;
        int scrollbarStart = (3 * height) / 20;
        
        for (int i = 0; i <= numThresholds; i++) {
            thresholdColors[i] = color(map(i, 0, 3, 0, 255));    
            int temp = i * 4;
            scrollbars[i] = new SuperHScrollbar(
                new HScrollbar(0, scrollbarStart + (temp) * scrollbarHeight, scrollbarWidth, scrollbarHeight, 1), 
                new HScrollbar(0, scrollbarStart + (temp + 1) * scrollbarHeight, scrollbarWidth, scrollbarHeight, 1),
                new HScrollbar(0, scrollbarStart + (temp + 2) * scrollbarHeight, scrollbarWidth, scrollbarHeight, 1)
            );
        }*/
        background(150);
        textAlign(CENTER);
        text("Select your colors", width/2, height/20);
        
        for (int i = 0; i <= numThresholds; i++) {
            for (int j = 0; j < scrollbars[0].bars.length; j++) {
                scrollbars[i].bars[j].update();
                scrollbars[i].bars[j].display();
            }
            thresholdColors[i] = color(scrollbars[i].r.getPos(), scrollbars[i].g.getPos(), scrollbars[i].b.getPos());
            fill(thresholdColors[i]);
            rect(scrollbars[i].r.swidth + scrollbars[i].r.sheight, scrollbars[i].r.ypos, 3 * scrollbars[i].r.sheight, 3 * scrollbars[i].r.sheight);
        }
        
        load.Draw();
        if (load.clicked()) {
            colorSelected = true;
        }
  
    } else {
        background(100);

        // For debugging purposes, need to fix auto path
        out.println(dataPath(""));
        out.println(sketchPath(""));
        out.println(f.getPath());
        out.println(p.getPath());

        for (int i = 0; i < names.length; i++) {
            files[i].setY((i * 100) + filesStart);
            files[i].Draw();
            if (files[i].clicked()) {
                delay(100);
                index = i;
                fileSelected = true;
            }
        }
    }
}

void updateImg() {
    pic.loadPixels();
    for (int i = 0; i < (pic.width * pic.height); i++) {
        // set grayscale( (0.3 * R) + (0.59 * G) + (0.11 * B) )
        int colorVal = int((red(pic.pixels[i]) * .3) + (green(pic.pixels[i]) * .59) + (blue(pic.pixels[i]) * .11));
        pic.pixels[i] = color(colorVal);
        thresh[colorVal]++;
    }
    
    /*
    for(int i = 0; i < thresh.length; i++){
         println(thresh[i]);    
         }
     */

    int taskIndex = 2;
    
    //
    // DETERMINE THRESHOLDS
    //
    
    thresholds = tasks.get(taskIndex).acquire(numThresholds, pic);
    
    for (int i = 0; i < thresholds.length; i++) {
        for (int j = i; j < thresholds.length; j++) {
            if (thresholds[j] < thresholds[i]) {
                int temp = thresholds[j];
                thresholds[j] = thresholds[i];
                thresholds[i] = temp;
            }
        }
    }
    
    print("[");
    print(thresholds[0]);
    for (int i = 1; i < thresholds.length; i++) {
        print(", " + thresholds[i]);
    }
    println("]");
    
    for (int i = 0; i < (pic.width * pic.height); i++) {
        boolean found = false;
        for (int j = 0; j < thresholds.length && !found; j++){
            if (pic.pixels[i] <= color(thresholds[j])) {
                pic.pixels[i] = thresholdColors[j];
                found = true;
            }
        }
        if(!found) {
            pic.pixels[i] = thresholdColors[thresholdColors.length - 1];
        }
        
    }
    pic.updatePixels();
}

void mouseWheel(MouseEvent event) {
    filesStart -= (event.getCount() * 10);
    if (filesStart > (maxEnd - names.length * 100)) {
        filesStart = 0;
    } else if (filesStart < (0 - (maxEnd - height))) {
        filesStart = (0 - (maxEnd - height));
    }
}

void mousePressed() {
    if (mouseButton == RIGHT && colorSelected) {
        colorSelected = false;
        loop();
        redraw();
    } else if (mouseButton == RIGHT && fileSelected && !colorSelected) {
        fileSelected = false;
    }
}

void mouseReleased() {
    scrollSelected = false;
}
