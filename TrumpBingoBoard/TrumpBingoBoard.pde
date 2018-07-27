import processing.pdf.*;
import java.net.URL;
import java.util.Scanner;
import java.net.MalformedURLException;

ArrayList<String> phrases = new ArrayList<String>();
int boardSize;
boolean goodData;

void setup(){
    size(1000, 1000, PDF, "bingo.pdf");
    boardSize = 5;
    try{
        URL url = new URL("https://raw.githubusercontent.com/harshilkamdar/trump-tweets/master/trump.txt");
        InputStream stream = url.openStream();
        int ch = stream.read();
        while(ch != -1 && phrases.size() < 1000){
            StringBuilder phrase = new StringBuilder();
            while(ch != '\n'){
                phrase.append(char(ch));
                ch = stream.read();
            }
            if (random(1) > .8)
                phrases.add(phrase.toString());
            ch = stream.read();
        }
        if (phrases.size() > (boardSize * boardSize) - 1)
            goodData = true;
        else
            goodData = false;
        println("loaded data, " + phrases.size() + " phrases");
    }
    catch(MalformedURLException e){
        println(e.getMessage());
        goodData = false;
    }
    catch (IOException e){
        println(e.getMessage());  
        goodData = false;
    }
    textAlign(CENTER, CENTER);
}

void draw(){
    if (goodData){
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
    }
    else
        print("bad data");
    exit();
    noLoop();    
}