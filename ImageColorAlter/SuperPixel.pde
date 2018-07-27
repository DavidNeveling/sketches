class SuperPixel{
    Pixel p;
    int r, c; // row, column
    int s; // grayscale color val
    int id;
    
    SuperPixel(Pixel pixel, int row, int col) {
        p = pixel;
        r = row;
        c = col;
        s = int((p.r * 0.30) + (p.g * 0.59) + (p.b * 0.11));
        id = 0; // just a placeholder
        // add classification?
    }

    String toString(){
        return "[" + p.toString() + ", " + r + ", " + c + ", " + s + ", " + id + "]";
    }
}