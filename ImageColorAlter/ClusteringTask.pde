//
// CONVERT CENTROIDS TO ARRAYLIST
//

class ClusteringTask implements ThresholdTask {
    
    /*
        idtocolor
        0 : 63
        1 : 127
        2 : 191
        3 : 255
    */
    int[] idtocolor = new int[] {63, 127, 191, 255};
    
    int[] acquire(int thresholds, PImage pic) {
        SuperImage si = new SuperImage(pic);
        //try {
        //    return si.applyClusterGS(thresholds, true);   
        //}
        //catch (Exception e){
        //    return (new EvenTask()).acquire(thresholds, pic);
        //}{
        int[] ret = si.applyClusterGS(thresholds, true);
        if (ret.length <= 0) {
            return (new EvenTask()).acquire(thresholds, pic);
        }
        return ret;
    }
}

class SuperImage {
    int cols, rows;
    SuperPixel[][] matrix;
    int gscthresh;
    
    SuperImage(PImage pic){
        cols = pic.width;
        rows = pic.height;
        matrix = genMatrix(pic);
        gscthresh = 10;
    }
    
    SuperPixel[][] genMatrix(PImage pic){
        SuperPixel[][] mat = new SuperPixel[pic.height][pic.width];
        pic.loadPixels();
        for (int r = 0; r < mat.length; r++) {
            for (int c = 0; c < mat[0].length; c++) {
                color pix = pic.pixels[r * pic.width + c];
                mat[r][c] = new SuperPixel(new Pixel(int(red(pix)), int(green(pix)), int(blue(pix)), 1), r, c);
            }
        }
        return mat;
    }
    
    int[] generateBins() {
        int[] temp = new int[256];
        for (int r = 0; r < matrix.length; r++) {
            for (int c = 0; c < matrix[0].length; c++) {
                temp[matrix[r][c].s]++;
            }
        }
        return temp;
    }
    
    class ClusterGSCentroid {
        int i;
        float v;
        
        ClusterGSCentroid (int ind, float val) {
            i = ind;
            v = val;
        }
        
        String toString() {
            return "[" + i + ", " + v + "]";
        }
    }
    
    
    // Main algorithm
    
    int[] applyClusterGS(int n, boolean anim) {
        if (n < 1) {
            return new int[0];    
        }
        
        int seed = int(System.currentTimeMillis());
        ClusterGSCentroid[] centroids = new ClusterGSCentroid[256];
        int radius = 10;
        int[] data = new int[radius * 2 + 256];
        int[] temp = generateBins();
        for (int i = 0; i < temp.length; i++) {
            data[i + 10] = temp[i];    
        }
        for (int i = 0; i < centroids.length; i++) {
            centroids[i] = new ClusterGSCentroid(i + radius, 0);
        }
        for (int i = 0; i < centroids.length; i++) {
            boolean cont = true;
            int prev = 0;
            while (cont) {
                float left = data[centroids[i].i] * .5;
                float right = data[centroids[i].i] * .5;

                for (int j = 1; j <= radius; j++) {
                    left += data[centroids[i].i - j] * (1/(1*j)); // kernel
                    right += data[centroids[i].i + j] * (1/(1*j)); // kernel
                }

                if (left > right) {
                    centroids[i].i--;
                    if (prev == 1) {
                        cont = false;
                        centroids[i].v = int(left + right);
                    }
                    prev = -1;
                }

                if (left < right) {
                    centroids[i].i += 1;
                    if (prev == 1) {
                        cont = false;
                        centroids[i].v = left + right;
                    }
                    prev = 1;
                }

                if (left == right) {
                    centroids[i].v = left + right;
                    cont = false;
                }
            }
        }
        
        for (int i = 0; i < centroids.length; i++) {
            centroids[i].i -= radius;
        }
        
        removeSimularGSCentroids(centroids);
        
        // centroids.sort(key=operator.attrgetter('v'), reverse = true); // fix with comparable
        
        pruneGSCentroids(centroids, n);
        
        for (int r = 0; r < rows; r++) {
            for (int c = 0; c < cols; c++) {
                for (int i = 0; i < centroids.length; i++) {
                    if (abs(matrix[r][c].s - centroids[i].i) < gscthresh){
                        matrix[r][c].id = i;    
                    }
                }
            }
        }
        
        int[] ret = new int[n];
        for (int i = centroids.length - 1; i >= 0; i--) {
            ret[n - i - 1] = centroids[i].i;    
        }
        return ret;
    }
    
    void applyClusterGS(int n) {
        applyClusterGS(n, true);
    }
    
    void applyClusterGS(boolean anim) {
        applyClusterGS(1, anim);
    }
    
    void applyClusterGS() {
        applyClusterGS(1, true);
    }
    
    // Supporting
    void pruneGSCentroids(ClusterGSCentroid[] centroids, int n){
        while (centroids.length > n) { 
            pruneGSCentroid(centroids, n);
        }
    }
    
    boolean pruneGSCentroid(ClusterGSCentroid[] centroids, int n) {
        for (int i = 0; i < centroids.length; i++){
            for (int j = i + 1; j < centroids.length; j++){
                if (abs(centroids[i].i - centroids[j].i) < gscthresh) {
                    // del centroids[j]; // convert to Arraylist
                    return true;
                }
            }
        }
        if (centroids.length > n) {
            gscthresh++; // #increash threshold until you have only n centroids
            pruneGSCentroid(centroids, n);
        }
        return false;
    }
    
    void removeSimularGSCentroids (ClusterGSCentroid[] centroids) {
        while (removeSimularGSCentroid(centroids));
    }
    
    boolean removeSimularGSCentroid(ClusterGSCentroid[] centroids) {
        for (int i = 0; i < centroids.length; i++){
            for (int j = i + 1; j < centroids.length; j++){
                if (centroids[i].i == centroids[j].i) {
                    // del centroids[j]; // convert to Arraylist
                    return true;
                }
            }
        }
        return false;
    }
}