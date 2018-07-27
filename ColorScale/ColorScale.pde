void setup(){
    size(800, 800);
    for(int c = 0; c < 256; c++){
        println(color(c) + "  " + (c * 65793 - 16777216));
    }
}

void draw(){
    
}