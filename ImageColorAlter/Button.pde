class Button {
  String label;
  int x;    // top left corner x position
  int y;    // top left corner y position
  int w;    // width of button
  int h;    // height of button

  Button(String labelB, int xpos, int ypos, int widthB, int heightB) {
    label = labelB;
    x = xpos;
    y = ypos;
    w = widthB;
    h = heightB;
  }

  void setY(int y) {
    this.y = y;
  }

  void Draw() {
    fill(218);
    stroke(141);
    rect(x, y, w, h, 10);
    textAlign(CENTER, CENTER);
    fill(0);
    textSize(32);
    text(label, x + (w / 2), y + (h / 2));
  }

  boolean mouseIsOver() {
    if (mouseX > x && mouseX < (x + w) && mouseY > y && mouseY < (y + h)) {
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
}