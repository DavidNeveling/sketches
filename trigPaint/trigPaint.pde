import java.util.Arrays;
float[][] grid;
String equation;
int left, right;
boolean debug = true;
void setup(){
    size(600, 600);
    grid = new float[width][height];
    equation = "---SC---";
    int scale = 4;
    left = -scale;
    right = scale;
}

void draw(){
    background(0);
    for(int x = 0; x < 1; x++){
        //equation = genEq();
        println(equation);
        loadPixels();
        stroke(255);
        for(int i = 0; i < width; i++){
            float y = makeEq(map(i, 0, width, left, right));
            for(int j = 0; j < height; j++){
                float match = map(y, left, right, height, 0);
                float blegh = 255 - abs(j - int(match));
                if(blegh < 0) blegh = 0;
                if(match >= 0 && match < height){
                    pixels[i + width * j] = color(blegh); 
                }
            }
        }
        updatePixels();
        saveFrame("art/" + equation + ".png");
    }
    println("done");
    noLoop();
}

String genEq(){
    int len = int(randomGaussian() * 7) + 3;  
    
    String possible = "SCTKEO+-";
    String result = "";
    for(int i = 0; i < len; i++){
        int index = int(random(possible.length()));
        result += "" + possible.charAt(index);
    }
    boolean check = false;
    for(int i = 0; i < result.length() && !check; i++){
        check = Character.isLetter(result.charAt(i));
    }
    if(!check)
        result += "" + possible.charAt(int(random(6)));
    return result;
}

float makeEq(float x){
    float y = 0;
    boolean check = false;
    int indoox;
    for(indoox = 0; indoox < equation.length() && !check; indoox++){
        check = Character.isLetter(equation.charAt(indoox));
    }
    equation = equation.substring(indoox);
    String[] segs = equation.split("[+-]");
    ArrayList<String> ops = new ArrayList(Arrays.asList(equation.split("[^+-]+")));
    //if(ops.size() > 0){
    //     ops.remove(0);   
    //}
    String op = "+";
    for(int i = 0; i < segs.length; i++){
        float temp = x;
        if(segs[i].equals(""))
            i++;
        if(debug)
            println("making seg: " + segs[i]);
        for(int j = segs[i].length() - 1; j >= 0; j--){
            char segPart = segs[i].charAt(j);
            if(debug){
                print("\t");
                println("making segPart: " + segPart);
                print("\t");
            }
            if(segPart == 'S'){
                temp = sin(temp);
                if(debug)
                    println("it made sin");
            }
            else if(segPart == 'C'){
                temp = cos(temp);
                if(debug)
                    println("it made cos");
            }
            else if(segPart == 'T'){
                temp = tan(temp);
                if(debug)
                    println("it made tan");
            }
            else if(segPart == 'K'){
                temp = 1 / sin(temp);
                if(debug)
                    println("it made csc");
            }
            else if(segPart == 'E'){
                temp = 1 / cos(temp);
                if(debug)
                    println("it made sec");
            }
            else if(segPart == 'O'){
                temp = 1 / tan(temp);
                if(debug)
                    println("it made cot");
            }
        }
        if(debug)
            println("\t\tabout to test op: " + op);
        if(op.equals("+")){
            y += temp;
            if(debug)
                println("\t\tadding to y");
        }
        else if(op.equals("-")){
            y -= temp;
            if(debug)
                println("\t\tsubtracting from y");
        }
        if(ops.size() > 0){
            op = ops.remove(0);
            if(debug)
                println("\t\tremoving/updating op: " + op + " | " + op.length());
        }
        if(op.length() > 1){
            op = "" + op.charAt(0);
            if(debug)
                println("\t\tfixing length of op: " + op);
        }
    }
    return y;
}