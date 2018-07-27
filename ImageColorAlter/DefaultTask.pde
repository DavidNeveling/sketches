class DefaultTask implements ThresholdTask {
    int[] acquire(int thresholds, PImage pic) {
        return new int[] {5, 80, 200};    
    }
}