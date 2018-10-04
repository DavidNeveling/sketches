import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import java.util.Arrays;
import java.util.Collections;

int values;
float blockWidth;
ArrayList<Integer> list;
int cycleI;
boolean inWhile;
int whileJ;
int key;
boolean sortState;
Minim       minim;
AudioOutput out;
Oscil       wave;
void setup(){
    size(1600, 900);
    minim = new Minim(this);
    out = minim.getLineOut();
    wave = new Oscil( 440, 0.5f, Waves.SINE );
    wave.patch( out );
    values = 50;
    blockWidth = width / float(values);
    list = new ArrayList<Integer>();
    for(int i = 1; i <= values; i++) {
        list.add(i);
    }
    cycleI = 1;
    Collections.shuffle(list);
    sortState = true;
}

void draw(){
    background(0);
    fill(255);
    noStroke();
    if (sortState) {
        if (!inWhile) {
            key = list.get(cycleI);
            whileJ = cycleI - 1;
            inWhile = true;
        }
        else {
            if(whileJ >= 0 && list.get(whileJ) > key){
                list.set(whileJ + 1, list.get(whileJ));
                whileJ = whileJ - 1;
            }
            else {
                inWhile = false;
                list.set(whileJ + 1, key);
                cycleI++;
            }
        }
    }
    else {
        cycleI++;
    }
    for(int i = 0; i < list.size(); i++){
        float x = map(i, 0, list.size(), 0, width);
        float y = height - map(list.get(i), 0, list.size(), 0, height);
        float h = map(list.get(i), 0, list.size(), 0, height);
        if (!inWhile || !sortState){
            if (i == cycleI)
                fill(0, 255, 0);
            rect(x, y, blockWidth, h);
            if (i == cycleI)
                fill(255);
        }
        else {
            if (i == whileJ)
                fill(0, 255, 0);
            rect(x, y, blockWidth, h);
            if (i == whileJ)
                fill(255);
        }
    }
    if(cycleI >= list.size()) {
        if (sortState) {
            sortState = false;
            cycleI = 0;
        }
        else {
            wave.setFrequency(0);
            println("done");
            noLoop();
        }
    }
    if (sortState && inWhile) {
        if (whileJ >= 0 )
            wave.setFrequency(map( list.get(whileJ), 0, list.size(), 110, 880 ));
        else
            wave.setFrequency(map( list.get(cycleI), 0, list.size(), 110, 880 ));
    }
    else {
        if (cycleI < list.size() )
            wave.setFrequency(map( list.get(cycleI), 0, list.size(), 110, 880 ));
        else
            wave.setFrequency(0);
    }
}