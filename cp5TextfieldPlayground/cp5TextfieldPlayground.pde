import controlP5.*;

ControlP5 cp5;
String textValue = "";

void setup(){
    size(800, 800);
    cp5 = new ControlP5(this);
    PFont font = createFont("arial", 20);
    cp5.addTextfield("tots")
        .setPosition(50, 50)
        .setSize(200, 40)
        .setFont(font)
        .setFocus(true)
        .setLabelVisible(true)
        .setColor(color(0))                     // where?
        .setColorBackground(color(255))         // self explanatory
        .setColorCaptionLabel(color(0, 255, 0)) // words under
        .setColorActive(color(255, 0, 0))       // border
        .setColorForeground(color(0, 0, 255))   // where?
        .setColorValueLabel(color(0, 255, 255)) // text inside 
        ;
       
}

void draw() {
    background(0);
    fill(255);
    text(cp5.get(Textfield.class,"tots").getText(), 360,130);
    text(textValue, 360,180);
}

public void clear() {
  cp5.get(Textfield.class,"textValue").clear();
}

void controlEvent(ControlEvent theEvent) {
  if(theEvent.isAssignableFrom(Textfield.class)) {
    println("controlEvent: accessing a string from controller '"
            +theEvent.getName()+"': "
            +theEvent.getStringValue()
            );
  }
}


public void input(String theText) {
  // automatically receives results from controller input
  println("a textfield event for controller 'input' : "+theText);
}