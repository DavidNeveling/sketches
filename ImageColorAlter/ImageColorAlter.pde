import java.io.FilenameFilter;
import java.io.File.*;
import static java.lang.System.*;

static final FilenameFilter FILTER = new FilenameFilter() {
    static final String JPG = ".jpg", JPEG = ".jpeg", PNG = ".png", GIF = ".gif", bJPG = ".JPG"; //only first frame of gif

    @ Override boolean accept(File path, String name) {
        return name.endsWith(JPG) || name.endsWith(JPEG) || name.endsWith(PNG) || name.endsWith(GIF) || name.endsWith(bJPG);
    }
};


File p = dataFile(dataPath(""));
File f = new File("D:\\processing-3.3.6\\sketches\\ImageColorAlter\\data");
String[] names = f.list(FILTER);
Button[] files = new Button[names.length];
PImage pic;
int index = 0;
int offset = 30;


int numThresholds;
int[] thresholds;
int[] thresholdColors;
int[] scrollbars;


int lowerThreshold = 5;
color lowerColor = color(0);
int midThreshold = 80;

color midColor = color(139, 137, 140);
int highThreshold = 200;

color highColor = color(228, 2, 4);
color topColor = color(255);
boolean fileSelected = false;
boolean colorSelected = false;
int filesStart = 0;
int maxEnd;
boolean set = false;
int[] thresh = new int[256];
Button load;
HScrollbar lcR;
HScrollbar lcG;
HScrollbar lcB;
HScrollbar mcR;
HScrollbar mcG;
HScrollbar mcB;
HScrollbar hcR;
HScrollbar hcG;
HScrollbar hcB;
HScrollbar tcR;
HScrollbar tcG;
HScrollbar tcB;
void setup() {
    //size(400, 400);
    //surface.setResizable(true);
    //surface.setSize(displayWidth, displayHeight);
    fullScreen();
    for (int i = 0; i < names.length; i++) {
        files[i] = new Button(names[i], 0, 0, width, 100);
    }
    load = new Button("LOAD IMAGE", (7 * width) / 8, (7 * height) / 8, width / 8, height / 8);
    maxEnd = names.length * 100;
    lcR = new HScrollbar(0, (3 * height) / 20, (6 * width) / 7, height / 20, 1);
    lcG = new HScrollbar(0, (4 * height) / 20, (6 * width) / 7, height / 20, 1);
    lcB = new HScrollbar(0, (5 * height) / 20, (6 * width) / 7, height / 20, 1);
    mcR = new HScrollbar(0, (7 * height) / 20, (6 * width) / 7, height / 20, 1);
    mcG = new HScrollbar(0, (8 * height) / 20, (6 * width) / 7, height / 20, 1);
    mcB = new HScrollbar(0, (9 * height) / 20, (6 * width) / 7, height / 20, 1);
    hcR = new HScrollbar(0, (11 * height) / 20, (6 * width) / 7, height / 20, 1);
    hcG = new HScrollbar(0, (12 * height) / 20, (6 * width) / 7, height / 20, 1);
    hcB = new HScrollbar(0, (13 * height) / 20, (6 * width) / 7, height / 20, 1);
    tcR = new HScrollbar(0, (15 * height) / 20, (6 * width) / 7, height / 20, 1);
    tcG = new HScrollbar(0, (16 * height) / 20, (6 * width) / 7, height / 20, 1);
    tcB = new HScrollbar(0, (17 * height) / 20, (6 * width) / 7, height / 20, 1);
}

void draw() {
    if (colorSelected) {
        background(0);
        pic = loadImage(names[index]);
        updateImg();
        //if(names[index].endsWith(".gif")){
        //  pic.save("" + names[index] + ".changed.gif");
        //}
        //else{
        pic.save("" + names[index] + ".changed.png");
        //}
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
        background(150);
        textAlign(CENTER);
        text("Select your colors", width/2, height/20);
        lcR.update();
        lcR.display();
        lcG.update();
        lcG.display();
        lcB.update();
        lcB.display();
        lowerColor = color(lcR.getPos(), lcG.getPos(), lcB.getPos());
        fill(lowerColor);
        rect(lcR.swidth + lcR.sheight, lcR.ypos, 3 * lcR.sheight, 3 * lcR.sheight);
        mcR.update();
        mcR.display();
        mcG.update();
        mcG.display();
        mcB.update();
        mcB.display();
        midColor = color(mcR.getPos(), mcG.getPos(), mcB.getPos());
        fill(midColor);
        rect(lcR.swidth + lcR.sheight, mcR.ypos, 3 * lcR.sheight, 3 * lcR.sheight);
        hcR.update();
        hcR.display();
        hcG.update();
        hcG.display();
        hcB.update();
        hcB.display();
        highColor = color(hcR.getPos(), hcG.getPos(), hcB.getPos());
        fill(highColor);
        rect(lcR.swidth + lcR.sheight, hcR.ypos, 3 * lcR.sheight, 3 * lcR.sheight);
        tcR.update();
        tcR.display();
        tcG.update();
        tcG.display();
        tcB.update();
        tcB.display();
        topColor = color(tcR.getPos(), tcG.getPos(), tcB.getPos());
        fill(topColor);
        rect(lcR.swidth + lcR.sheight, tcR.ypos, 3 * lcR.sheight, 3 * lcR.sheight);
        load.Draw();
        if (load.clicked()) {
            colorSelected = true;
        }
    } else {
        background(100);

        // For debugging purposes, need to fix auto path
        //out.println(dataPath(""));
        //out.println(sketchPath(""));
        //out.println(f.getPath());
        //out.println(p.getPath());

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


    //
    // DETERMINE THRESHOLDS
    //
    
    
    for (int i = 0; i < (pic.width * pic.height); i++) {
        if (pic.pixels[i] <= color(lowerThreshold)) {
            pic.pixels[i] = lowerColor;
        } else if (pic.pixels[i] < color(midThreshold)) {
            pic.pixels[i] = midColor;
        } else if (pic.pixels[i] < color(highThreshold)) {
            pic.pixels[i] = highColor;
        } else {
            pic.pixels[i] = topColor;
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