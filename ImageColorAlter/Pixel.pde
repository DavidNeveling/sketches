class Pixel{
    int r, g, b, a;
    Pixel(int red, int green, int blue, int alpha){
        r = red;
        g = green;
        b = blue;
        a = alpha;
    }

    int[] pixelAsList() {
        return new int[] {r, b, g, a};
    }
    
    String toString(){
        return "[" + r + ", " + g + ", " + b + ", " + a + "]";
    }
}