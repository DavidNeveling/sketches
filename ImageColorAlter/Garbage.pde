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
    /*
    for(int i = 0; i < thresh.length; i++){
        println(thresh[i]);    
    }
    */
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