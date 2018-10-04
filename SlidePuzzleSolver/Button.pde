class Button {
  String label;
  float x;    // top left corner x position
  float y;    // top left corner y position
  float w;    // width of button
  float h;    // height of button
  boolean clickable;

  Button(String labelB, float xpos, float ypos, float widthB, float heightB) {
    label = labelB;
    x = xpos;
    y = ypos;
    w = widthB;
    h = heightB;
    clickable = true;
  }
  
  Button(String labelB, float xpos, float ypos, float widthB, float heightB, boolean clickable) {
    label = labelB;
    x = xpos;
    y = ypos;
    w = widthB;
    h = heightB;
    this.clickable = clickable;
  }

  void setY(float y) {
    this.y = y;
  }

  void Draw() {
    textFont(createFont("Mono", buttonFont));
    fill(218);
    stroke(141);
    rect(x, y, w, h, 10);
    textAlign(CENTER, CENTER);
    if(clickable)
        fill(0);
    else{
        fill(100);
    }
    
    text(label, x, y);
  }

  boolean mouseIsOver() {
    if (mouseX > x && mouseX < (x + w) && mouseY > y && mouseY < (y + h)) {
        println(label + " over");
      return true;
    }
    return false;
  }

  boolean clicked(){
    if(mouseIsOver() && (mousePressed && mouseButton == LEFT)){
      return true;
    }
    else{
      return false;
    }
  }
  
  void setClickable(boolean clickable){
      this.clickable = clickable;
  }
  
  String toString(){
      return "(" + label + "  " + x + "  " + y + "  " + w + "  " + h + "  " + clickable + ")";
  }
}