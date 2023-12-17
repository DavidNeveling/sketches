class Walker {
  float x, y, s;
  Direction d;
  
  Walker(float x, float y) {
    this.x = x;
    this.y = y;
    d = Direction.UP;
    s = 10;
  }
  
  Walker(float x, float y, Direction d) {
    this(x, y);
    this.d = d;
  }
  
  Walker(float x, float y, float s) {
    this(x, y);
    this.s = s;
  }
  
  Walker(float x, float y, Direction d, float s) {
    this(x, y);
    this.d = d;
    this.s = s;
  }
  
  void setDirection() {
      Direction[] newDirection;// = new Direction[3];
      switch (d) {
        case UP:
          newDirection = new Direction[]{Direction.UP, Direction.RIGHT, Direction.LEFT};
          d = newDirection[int(random(3))];
          break;
        case DOWN:
          newDirection = new Direction[]{Direction.DOWN, Direction.RIGHT, Direction.LEFT};
          d = newDirection[int(random(3))];
          break;
        case LEFT:
          newDirection = new Direction[]{Direction.UP, Direction.DOWN, Direction.LEFT};
          d = newDirection[int(random(3))];
          break;
        case RIGHT:
          newDirection = new Direction[]{Direction.UP, Direction.RIGHT, Direction.DOWN};
          d = newDirection[int(random(3))];
          break;
        default:
          break;
      }
  }
  
  void update() {
      switch (d) {
        case UP:
          break;
        case DOWN:
          break;
        case LEFT:
          break;
        case RIGHT:
          break;
        default:
          break;
      }
  }

}
 
enum Direction {
  UP, DOWN, LEFT, RIGHT;
}
