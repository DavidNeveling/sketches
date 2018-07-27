class SuperHScrollbar {
    HScrollbar r, g, b;
    HScrollbar[] bars;
    
    SuperHScrollbar(HScrollbar r, HScrollbar g, HScrollbar b) {
        this.r = r;
        this.g = g;
        this.b = b;
        bars = new HScrollbar[] {r, g, b};
    }
}