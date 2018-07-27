/*
*    This is just a dump of code segments that don't have a lot of purpose, but I wanted to keep for various reasons
*/

// oreBlue color midColor = color(13, 151, 230);

// orePink color highColor = color(220, 88, 141);

/*void updateImg(){

  pic.loadPixels();
  if(names[index].equals("oregairuNew.png") && oLines){
    for(int i = 0; i < (pic.width * pic.height); i++){
      // set grayscale( (0.3 * R) + (0.59 * G) + (0.11 * B) )

      // These comments are specifically for the oregairuNew.png pic to add black outlines
      if((red(pic.pixels[i]) > 70 - offset && red(pic.pixels[i]) < 70 + offset) && (green(pic.pixels[i]) > 54 - offset && green(pic.pixels[i]) < 54 + offset) && (blue(pic.pixels[i]) > 163 - offset && blue(pic.pixels[i]) < 163 + offset)){
        pic.pixels[i] = color(0);
      }
      //color(174, 21, 109)){
      else if((red(pic.pixels[i]) > 174 - offset && red(pic.pixels[i]) < 174 + offset) && (green(pic.pixels[i]) > 21 - offset && green(pic.pixels[i]) < 21 + offset) && (blue(pic.pixels[i]) > 109 - offset && blue(pic.pixels[i]) < 109 + offset)){
        pic.pixels[i] = color(0);
      }
      //color(73, 131, 172)){
      else if((red(pic.pixels[i]) > 73 - offset && red(pic.pixels[i]) < 73 + offset) && (green(pic.pixels[i]) > 131 - offset && green(pic.pixels[i]) < 131 + offset) && (blue(pic.pixels[i]) > 172 - offset && blue(pic.pixels[i]) < 172 + offset)){
        pic.pixels[i] = color(0);
      }
      else{
        pic.pixels[i] = color((red(pic.pixels[i]) * .3) + (green(pic.pixels[i]) * .59) + (blue(pic.pixels[i]) * .11));
      }
    }
  }
  else {
    for(int i = 0; i < (pic.width * pic.height); i++){
    // set grayscale( (0.3 * R) + (0.59 * G) + (0.11 * B) )
      int colorVal = int((red(pic.pixels[i]) * .3) + (green(pic.pixels[i]) * .59) + (blue(pic.pixels[i]) * .11));
      pic.pixels[i] = color(colorVal);
      thresh[colorVal]++;
    }
    
    for(int i = 0; i < thresh.length; i++){
        println(thresh[i]);    
    }
    
  }
  //
  // DETERMINE THRESHOLDS
  //
  for(int i = 0; i < (pic.width * pic.height); i++){
    if(pic.pixels[i] <= color(lowerThreshold)){
      pic.pixels[i] = lowerColor;
    }
    else if(pic.pixels[i] < color(midThreshold)){
      pic.pixels[i] = midColor;
    }
    else if(pic.pixels[i] < color(highThreshold)){
      pic.pixels[i] = highColor;
    }
    else{
      pic.pixels[i] = topColor;
    }
  }
  pic.updatePixels();
}
*/

/*
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
*/

/*
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
*/

/*
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
*/