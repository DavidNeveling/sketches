var grid;
var scale, off;
var sim, clear, randomize;
var speedSlider;
var play;

function setup(){
    createCanvas(800, 800);
    
    sim = createButton('PLAY/PAUSE');
    sim.label = "PLAY";
    sim.mousePressed(advancePlay);
    
    clear = createButton('CLEAR');
    clear.mousePressed(clearGrid);
    
    randomize = createButton('RANDOMIZE');
    randomize.mousePressed(randomizeGrid);
    
    scale = 8;
    off = 0;
    grid = freshGrid();
    play = false;
    speedSlider = createSlider(0, 999, 999);
    
}

function draw(){
    background(200);
    if (play)
        updateGrid();
    drawGrid();
    if (play)
        delay(1000 - speedSlider.value());
}

function drawGrid(){
    for (var r = 0; r < grid.length; r++){
        for (var c = 0; c < grid[0].length; c++){
            if (grid[r][c] == false)
                fill(0);
            else
                fill(255, 0, 0);
            rect(r * scale + off, c * scale + off, scale - 2 * off, scale - 2 * off);
        }
    }
}

function printGrid(){
    for (var r = 0; r < grid.length; r++){
        for (var c = 0; c < grid[0].length; c++){
            if (grid[r][c] == false)
                fill(0);
            else
                fill(255, 0, 0);
            text("" + getNeighbors(r, c), r * scale + off, c * scale + off, scale - 2 * off, scale - 2 * off);
            
        }
    }
}

function updateGrid(){
    var temp = freshGrid();
    for (var r = 0; r < grid.length; r++){
        for (var c = 0; c < grid[0].length; c++){
             var n = getNeighbors(r, c);
             if (grid[r][c]){
                 if (n == 2 || n == 3)
                     temp[r][c] = true;
             }
             else{
                 if (n == 3)
                     temp[r][c] = true;
             }
        }
    }
    grid = temp;
}

function getNeighbors(r, c){
    var sum = 0;  
    for (var rc = -1; rc <= 1; rc++){
        var rCheck;
        if (r + rc < 0)
            rCheck = grid.length - 1;
        else if(r + rc >= grid.length)
            rCheck = 0;
        else
            rCheck = r + rc;
        for (var cc = -1; cc <= 1; cc++){
            if (!(rc == 0 && cc == 0)) {
                var cCheck;
                if (c + cc < 0)
                    cCheck = grid[0].length - 1;
                else if(c + cc >= grid[0].length)
                    cCheck = 0;
                else
                    cCheck = c + cc;
                if (grid[rCheck][cCheck])
                    sum++;
            }
        }
    }
    return sum;
}

function randomizeGrid(){
    if (!play) {
        for (var r = 0; r < grid.length; r++){
            for (var c = 0; c < grid[0].length; c++){
                 grid[r][c] = random(0, 1) >= 0.5; 
            }
        }
        updateGrid();
        drawGrid();
    }
}

function advancePlay(){
    if (sim.label == "PLAY"){
        sim.label = "PAUSE";
        play = true;
    }
    else{
        sim.label = "PLAY";
        play = false;
    }
}

function clearGrid(){
    grid = freshGrid();
    play = false;
    sim.label = "PLAY";
}

function freshGrid(){
    var newGrid = [];
    for (var r = 0; r < width / scale; r++) {
        newGrid[r] = [];
        for (var c = 0; c < height / scale; c++) {
            newGrid[r][c] = false;
        }
    }
    return newGrid;
}

function delay(ms) {
    var cur_d = new Date();
    var cur_ticks = cur_d.getTime();
    var ms_passed = 0;
    while(ms_passed < ms) {
        var d = new Date();
        var ticks = d.getTime();
        ms_passed = ticks - cur_ticks;
    }
}