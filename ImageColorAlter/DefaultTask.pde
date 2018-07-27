class DefaultTask implements ThresholdTask {
    int[] acquire() {
        return new int[3] {5, 80, 200};    
    }
}