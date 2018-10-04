import java.util.PriorityQueue;
import java.util.Arrays;

Integer[][] grid;
int size;
SlidePuzzleProblem problem;
float realWidth, realHeight, gridX, gridY, bY, buttonHeight, buttonWidth;
float blockWidth, blockHeight;
Mode mode, prevMode;
SlidePuzzleStateInfo goalCheck;
ArrayList<Integer> path;
Button start, shuffle, switchMode;
float fontSize, buttonFont;
int frameStart;
int shuffleDegree;

boolean fuckYou;

void setup(){
    size(800, 800);
    realWidth = width - (width / 10.0);
    realHeight = height - (height / 10.0);
    gridX = width / 20.0;
    gridY = height / 20.0;
    size = 4;
    blockWidth = realWidth / size;
    blockHeight = realHeight / size;
    buttonWidth = blockWidth / 2;
    buttonHeight = gridY - height / 100.0;
    bY = gridY / 2;
    problem = new SlidePuzzleProblem(size);
    grid = problem.getStartState();
    for (int i = 0; i < size*size - 1; i++){
        int row = i / size;
        int col = i % size;
        grid[row][col] = i+1;        
    }
    grid[size-1][size-1] = 0;
    frameStart = 1000000;
    shuffleDegree = 65;
    
    ////grid = problem.getSuccessors(grid).get(0).state;
    //for(int i = 0; i < 30; i++){
    //    ArrayList<SlidePuzzleStateInfo> successors = problem.getSuccessors(grid);
    //    grid = successors.get(int(random(successors.size()))).state;
    //}
    goalCheck = problem.getGoalCheckState();
    textAlign(CENTER, CENTER);
    rectMode(CENTER);
    mode = Mode.GAME; // THIS
    prevMode = mode;
    fontSize = (float)(64 * (Math.sqrt(width * height) / 800));
    buttonFont = (float)(20 * (Math.sqrt(width * height) / 800));
    
    
    start = new Button("START", gridX + buttonWidth, bY, buttonWidth, buttonHeight, false);
    shuffle = new Button("SHUFFLE", gridX + buttonWidth + 2 * blockWidth, bY, buttonWidth, buttonHeight, true);
    //gridShuffle();
    println(start);
    println(shuffle);
    fuckYou = false;
    if(!fuckYou){
        gridShuffle();
        frameStart = 100;
        path = aStar(getAStarPathMap());    
    }
}

void draw(){
    background(0);
    if (fuckYou){
        start.Draw();
        shuffle.Draw();
        //if (mode == Mode.GAME || mode == Mode.MOVING){
        //    drawGrid();
        //}
        //else{
        if(mode == Mode.PATHING) {
            println("pathing");
            path = aStar(getAStarPathMap());
            mode = Mode.SOLVING;
        }
        else if(mode == Mode.SOLVING){
            println("solving");
            
        }
        else{
        }
        
    }
    else{
        if (frameCount % 30 == 0 && frameCount > frameStart){
            //println("start size = " + path.size());
            if (path.size() > 0){
                //for(int act : path){
                //    //println(act);
                //}
                int action = path.remove(0);
                slideBlock(action);
                //println("start size = " + path.size());
            }
        }
        drawGrid();
    }
}
    

void drawGrid(){
    textFont(createFont("Mono", fontSize));
    strokeWeight(2);
    for(int r = 0; r < size; r++){
        for (int c = 0; c < size; c++){
            float x = gridX + c * blockWidth + blockWidth /2;
            float y = gridY + r * blockHeight + blockHeight / 2;
            if (grid[r][c] != 0){
                fill(120);
                stroke(0);
                rect(x, y, blockWidth, blockHeight);
                fill(0);
                noStroke();
                text("" + grid[r][c], x, y);
            }
            else{
                fill(20);
                rect(x, y, blockWidth, blockHeight);
            }
        }
    }
}

void slideBlock(int block){
    println("SLIDE");
    int row = block / size;
    int col = block % size;
    int changeR = 0;
    int changeC = 0;
    if(!(row - 1 < 0)){
        if (grid[row - 1][col] == 0){
            changeR--;
        }
    }
    if(!(row + 1 >= size)){
        if (grid[row + 1][col] == 0){
            changeR++;
        }
    }
    if(!(col - 1 < 0)){
        if (grid[row][col - 1] == 0){
            changeC--;
        }
    }
    if(!(col + 1 >= size)){
        if (grid[row][col + 1] == 0){
            changeC++;
        }
    }
    int temp = grid[row][col];
    grid[row][col] = grid[row + changeR][col + changeC];
    grid[row + changeR][col + changeC] = temp;
    mode = prevMode;
}

Integer[][] slideBlock(int block, Integer[][] state){
    
    Integer[][] stateCopy = new Integer[size][size];
    for(int i = 0; i < size; i++) {
        for(int j = 0; j < size; j++){
            stateCopy[i][j] = state[i][j];    
        }
    }
    int row = block / size;
    int col = block % size;
    int changeR = 0;
    int changeC = 0;
    if(!(row - 1 < 0)){
        if (state[row - 1][col] == 0){
            changeR--;
        }
    }
    if(!(row + 1 >= size)){
        if (state[row + 1][col] == 0){
            changeR++;
        }
    }
    if(!(col - 1 < 0)){
        if (state[row][col - 1] == 0){
            changeC--;
        }
    }
    if(!(col + 1 >= size)){
        if (state[row][col + 1] == 0){
            changeC++;
        }
    }
    //println("swap " + row + " & " + col + " with " + (row + changeR) + " & " + (col + changeC));
    int temp = stateCopy[row][col];
    stateCopy[row][col] = stateCopy[row + changeR][col + changeC];
    stateCopy[row + changeR][col + changeC] = temp;
    return stateCopy;
}

ArrayList<Integer> aStar(HashMap<SlidePuzzleStateInfo, SlidePuzzleStateInfo> map){
    ArrayList<Integer> path = new ArrayList<Integer>();
    println(problem.getGoalCheckState());
    SlidePuzzleStateInfo item = map.get(goalCheck);
    println(item);
    //for (SlidePuzzleStateInfo name : map.keySet()){
    //    SlidePuzzleStateInfo value = map.get(name);  
    //    System.out.println(name + "" + value);
    //}
    //while (!(item.equals(problem.getStartState()))){
    while (item != null){
        path.add(item.action);
        item = map.get(item);
        println(item);
    }
    
    Collections.reverse(path);
    mode = mode.SOLVING;
    frameStart = frameCount + 100;
    return path;
}

HashMap<SlidePuzzleStateInfo, SlidePuzzleStateInfo> getAStarPathMap(){
    //println("start");
    ArrayList<Integer[][]> closed = new ArrayList<Integer[][]>();
    HashMap<SlidePuzzleStateInfo, SlidePuzzleStateInfo> map = new HashMap<SlidePuzzleStateInfo, SlidePuzzleStateInfo>();
    HashMap<SlidePuzzleStateInfo, Integer> priorityMap = new HashMap<SlidePuzzleStateInfo, Integer>();
    PriorityQueue fringe = new PriorityQueue();
    SlidePuzzleStateInfoWithPriority start = new SlidePuzzleStateInfoWithPriority(new SlidePuzzleStateInfo(grid, 0, 0), 0);
    fringe.add(start);
    priorityMap.put(start.stateInfo, 0);
    while(!fringe.isEmpty()){
    //for (int poop = 0; poop < 5; poop++){
        //for (Object p : fringe.toArray()){
        //    SlidePuzzleStateInfoWithPriority ting = (SlidePuzzleStateInfoWithPriority)p;
        //    println(ting);
        //}
        //println("|||||||||||||||||||||||||");
        //for (SlidePuzzleStateInfo name : priorityMap.keySet()){
        //    String key = name.toString();
        //    String value = priorityMap.get(name).toString();  
        //    System.out.println(key + " " + value);
        //}
        SlidePuzzleStateInfoWithPriority node = (SlidePuzzleStateInfoWithPriority)fringe.poll();
        //println(node);
        if (problem.isGoalState(node.stateInfo.state)){
            map.put(goalCheck, node.stateInfo);  
            //println(goalCheck);
            return map;
        }
        if (!(closed.contains(node.stateInfo.state))){
            //println("not in closed");
            closed.add(node.stateInfo.state);
            for (SlidePuzzleStateInfo childNode : problem.getSuccessors(node.stateInfo.state)) {
                //println("begin child:\n"+childNode);
                if (!(closed.contains(childNode.state))){
                    map.put(childNode, node.stateInfo);
                    //for (SlidePuzzleStateInfo name : priorityMap.keySet()){
                    //    String key = name.toString();
                    //    String value = priorityMap.get(name).toString();  
                    //    System.out.println(key + "priority:" + value);
                    //}
                    priorityMap.put(childNode, childNode.cost + priorityMap.get(node.stateInfo));
                    int newCost = priorityMap.get(childNode);
                    fringe.add(new SlidePuzzleStateInfoWithPriority(childNode, newCost + problem.slidePuzzleHeuristic(childNode.state)));
                    //fringe.add(new SlidePuzzleStateInfoWithPriority(childNode, newCost));
                }
            }
        }
    }
    return map;
}

boolean containsState(ArrayList<Integer[][]> states, Integer[][] state){
    for (Integer[][] check : states){
        if (gridEquals(check, state))
            return true;
    }
    return false;
}

boolean gridEquals(Integer[][] grid1, Integer[][] grid2){
    if (grid1 == null) {
        return (grid2 == null);
    }
    if (grid2 == null) {
        return false;
    }
    if (grid1.length != grid2.length) {
        return false;
    }
    for (int i = 0; i < grid1.length; i++) {
        if (!Arrays.equals(grid1[i], grid2[i])) {
            return false;
        }
    }
    return true;
}

void mousePressed(){
    if (mode == Mode.GAME){
        for(int r = 0; r < size; r++){
            for (int c = 0; c < size; c++){
                float x = gridX + c * blockWidth;
                float y = gridY + r * blockHeight;
                if (mouseX > x && mouseX < x + blockWidth 
                    && mouseY > y && mouseY < y + blockHeight){
                    prevMode = mode;
                    mode = Mode.MOVING;
                    slideBlock(c + r * size);
                }
            }
        }
    }
    else {
        println("in else");
        if (start.clickable){
            if (start.mouseIsOver()){
                start.setClickable(false);
                mode = Mode.PATHING;
            }
        }
        if (shuffle.clickable){
            if (shuffle.mouseIsOver()){
                gridShuffle();
            }
        }
    }
}

void gridShuffle(){
    println("shulffing");
    shuffle.setClickable(false);
    for(int i = 0; i < shuffleDegree; i++){
        ArrayList<SlidePuzzleStateInfo> successors = problem.getSuccessors(grid);
        grid = successors.get(int(random(successors.size()))).state;
    }
    start.setClickable(true);
    shuffle.setClickable(true);
    println("shulffing doon");
}