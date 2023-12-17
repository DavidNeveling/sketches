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
