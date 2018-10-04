class SlidePuzzleStateInfo{
    Integer[][] state;
    int action;
    int cost;
    SlidePuzzleStateInfo(Integer[][] grid, int action, int cost){
        this.state = grid;
        this.action = action;
        this.cost = cost;
    }
    String toString(){
        String s = "Grid:\n";
        for (int i = 0; i < state.length; i++) {
            for (int j = 0; j < state[i].length; j++) {
                s += state[i][j] + " ";
            }
            s += "\n";
        }
        s += "Action: " + action;
        s += "\nCost: " + cost + "\n";
        return s;
    }
}

class SlidePuzzleStateInfoWithPriority implements Comparable{
//class SlidePuzzleStateInfoWithPriority{
    SlidePuzzleStateInfo stateInfo;
    int priority;
    
    SlidePuzzleStateInfoWithPriority(SlidePuzzleStateInfo state, int priority){
        this.stateInfo = state;
        this.priority = priority;
    }
    
    int compareTo(Object other){
        if (other instanceof SlidePuzzleStateInfoWithPriority){
            int otherP = ((SlidePuzzleStateInfoWithPriority)other).priority;
            if (otherP > priority)
                return -1;
            if (otherP < priority)
                return 1;
        }
        return 0;
    }
    
    String toString(){
        String s = ""+stateInfo;
        s += "State Priority: " + priority + "\n";
        return s;
    }
    
}