/*
import java.util.Arrays;
import java.util.Collections;
int values;
float blockWidth;
int[] list;
int cycleI;
boolean inWhile;
int whileJ;
int key;
//void setup(){
    size(800, 800);
    values = 10;
    blockWidth = width / float(values);
    list = new int[values];
    for(int i = 1; i <= values; i++) {
        list[i-1] = i;
    }
    cycleI = 1;
    Collections.shuffle(list);
    inWhile = false;
    //for(int i : list){
    //    println(i);
    //}
    frameRate(1);
}

//void draw(){
    background(0);
    fill(255);
    noStroke();
    
    if (!inWhile) {
        key = list[cycleI];
        whileJ = cycleI - 1;
        inWhile = true;
    }
    else {
        if(whileJ >= 0 && list[cycleI] > key){
            list.set(whileJ + 1, list[whileJ]));
            whileJ = whileJ - 1;
        }
        else {
            inWhile = false;
            list.set(whileJ + 1, key);
            cycleI++;
        }
    }
    for(int i = 0; i < list.size(); i++){
        float x = map(i, 0, list.size(), 0, width);
        float y = height - map(list.get(i), 0, list.size(), 0, height);
        float h = map(list.get(i), 0, list.size(), 0, height);
        //println(x + ", " + y + ", " + h);
        
        if (!inWhile){
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
        println("done"); 
        noLoop();
    }
}

void insertSort(int arr[]){
    int n = arr.length;
    for (int i=1; i<n; ++i)
    {
        int key = arr[i];
        int j = i-1;
 
        /* Move elements of arr[0..i-1], that are
           greater than key, to one position ahead
           of their current position 
        while (j>=0 && arr[j] > key)
        {
            arr[j+1] = arr[j];
            j = j-1;
        }
        arr[j+1] = key;
    }
}

*/