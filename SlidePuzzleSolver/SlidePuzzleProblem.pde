import java.util.Collections;

class SlidePuzzleProblem{
    Integer[][] start;
    int size;
    SlidePuzzleProblem(int size){
        this.size = size;
        start = new Integer[size][size];
        ArrayList<Integer> temp = new ArrayList<Integer>();
        for (int i = 0; i < size*size; i++){
            temp.add(i);    
        }
        Collections.shuffle(temp);
        for (int i = 0; i < size; i++){
            for (int j = 0; j < size; j++){
                start[i][j] = temp.get(j + i * size);
            }
        }
    }
    
    SlidePuzzleProblem(Integer[][] state){
        start = state;
        size = start.length;
    }
    
    SlidePuzzleStateInfo getGoalCheckState(){
        Integer[][] checker = new Integer[size][size];
        for(int i = 0; i < size; i++){
            for(int j = 0; j < size; j++){
                checker[i][j] = -1;    
            }
        }
        return new SlidePuzzleStateInfo(checker, -1, -1);    
    }
    
    boolean isGoalState(Integer[][] state){
        for (int i = 0; i < size*size - 1; i++){
            int row = i / size;
            int col = i % size;
            if (state[row][col] != i+1){
                return false;
            }
        }
        if (state[size-1][size-1] != 0){
            return false;
        }
        return true;
    }
    
    Integer[][] getStartState(){
        return start;    
    }
    
    void setStartState(Integer[][] state){
        start = state;    
    }
    
    int slidePuzzleHeuristic(Integer[][] state){
        int sum = 0;
        for (int i = 1; i < size*size; i++){
            int gRow = (i-1) / size;
            int gCol = (i-1) % size;
            int val = state[gRow][gCol];
            int row = (val-1) / size;
            int col = (val-1) % size;
            int step = (int)Math.sqrt(Math.pow(gRow - row, 2) + Math.pow(gCol - col, 2));
            sum += step;
            //println(gRow + " " + gCol + " " + val + " " + row + " " + col + " " + step);
        }
        int gRow = size-1;
        int gCol = size-1;
        int val = state[gRow][gCol];
        int row = 0;
        int col = 0;
        if (val == 0) {
            row = size-1;
            col = size-1;
        }
        else{
            row = (val-1) / size;
            col = (val-1) % size;
        }
        
        int step = (int)Math.sqrt(Math.pow(gRow - row, 2) + Math.pow(gCol - col, 2));
        sum += step;
        //println(gRow + " " + gCol + " " + val + " " + row + " " + col + " " + step);
        return sum;
    }
    
    ArrayList<SlidePuzzleStateInfo> getSuccessors(Integer[][] state){
        ArrayList<SlidePuzzleStateInfo> successors = new ArrayList<SlidePuzzleStateInfo>();
        int row = -1;
        int col = -1;
        for(int i = 0; i < size; i++){
            for(int j = 0; j < size; j++){
                if(state[i][j] == 0){
                    row = i;
                    col = j;
                }
            }
        }
        
        if(!(row - 1 < 0)){
            successors.add(new SlidePuzzleStateInfo(slideBlock((col) + size * (row - 1), state), (col) + size * (row - 1), 1));
        }
        if(!(row + 1 >= size)){
            successors.add(new SlidePuzzleStateInfo(slideBlock((col) + size * (row + 1), state), (col) + size * (row + 1), 1));
        }
        if(!(col - 1 < 0)){
            successors.add(new SlidePuzzleStateInfo(slideBlock((col - 1) + size * (row), state), (col - 1) + size * (row), 1));
        }
        if(!(col + 1 >= size)){
            successors.add(new SlidePuzzleStateInfo(slideBlock((col + 1) + size * (row), state), (col + 1) + size * (row), 1));
        }
        return successors;
    }
    
    ArrayList<Integer> getLegalActions(int action){
        ArrayList<Integer> actions = new ArrayList<Integer>();
        return actions;
    }
    
    //int getAction(int action){
    //    int row = action / size;
    //    int col = action % size;
    //    for (int r = -1; r <= 1; r += 2){
    //        for (int c = -1; c <= 1; c += 2){
    //            int newR = row + r;
    //            int newC = col + c;
    //            if (newR < 0 || newR >= size || newC < 0 || newC >= size) {
                    
    //            }    
    //        }    
    //    }
    //}
    
}