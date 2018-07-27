import processing.pdf.*;
import java.util.Arrays;

ArrayList<String> phrases;
int boardSize;

void setup(){
    size(1000, 1000, PDF, "bingo.pdf");
    boardSize = 3;
    phrases = new ArrayList<String>(Arrays.asList(loadStrings("montagephrases.txt")));
    textAlign(CENTER, CENTER);
}

void draw(){
    background(255);
    stroke(0);
    float size = width / float(boardSize);
    for(int i = 0; i < boardSize; i++){
        for(int j = 0; j < boardSize; j++){
            noFill();
            rect(i * size, j * size, size, size);
            fill(0);
            if(i == boardSize / 2 && j == boardSize / 2){
                text("FREE SPACE", i * size, j * size, size, size);
            }
            else{
                int index = floor(random(phrases.size()));
                String phrase = phrases.remove(index);
                text(phrase, i * size, j * size, size, size);
            }
        }   
    }
    print("done");
    exit();
    noLoop();    
}