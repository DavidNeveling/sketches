class EvenTask implements ThresholdTask {
    int[] acquire(int thresholds, PImage pic) {
        int[] array = new int[thresholds];
        for (int i = 0; i < thresholds; i++) {
            array[i] = int(map(i, 0, thresholds, 5, 250));    
        }
        return array;    
    }
}