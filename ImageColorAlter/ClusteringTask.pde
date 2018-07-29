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
    
    class ClusterGSCentroid implements Comparable {
        int i;
        float v;
        
        ClusterGSCentroid (int ind, float val) {
            i = ind;
            v = val;
        }
        
        int compareTo(Object other) {
            if (other instanceof ClusterGSCentroid){
                if(((ClusterGSCentroid)other).v > v) {
                    return 1;
                }
                else if (((ClusterGSCentroid)other).v < v) {
                    return -1;
                }
                else {
                    return 0;    
                }
            }
            else {
                return 0; 
            }
               
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
        
        ArrayList<ClusterGSCentroid> centroids = new ArrayList<ClusterGSCentroid>();
        int radius = 10;
        int[] data = new int[radius * 2 + 256];
        int[] temp = generateBins();
        for (int i = 0; i < temp.length; i++) {
            data[i + 10] = temp[i];    
        }
        for (int i = 0; i < 256; i++) {
            centroids.add(new ClusterGSCentroid(i + radius, 0));
        }
        for (int i = 0; i < centroids.size(); i++) {
            boolean cont = true;
            int prev = 0;
            while (cont) {
                float left = data[centroids.get(i).i] * .5;
                float right = data[centroids.get(i).i] * .5;

                for (int j = 1; j <= radius; j++) {
                    left += data[centroids.get(i).i - j] * (1/(1*j)); // kernel
                    right += data[centroids.get(i).i + j] * (1/(1*j)); // kernel
                }

                if (left > right) {
                    centroids.get(i).i--;
                    if (prev == 1) {
                        cont = false;
                        centroids.get(i).v = int(left + right);
                    }
                    prev = -1;
                }

                if (left < right) {
                    centroids.get(i).i += 1;
                    if (prev == 1) {
                        cont = false;
                        centroids.get(i).v = left + right;
                    }
                    prev = 1;
                }

                if (left == right) {
                    centroids.get(i).v = left + right;
                    cont = false;
                }
            }
        }
        
        for (int i = 0; i < centroids.size(); i++) {
            centroids.get(i).i -= radius;
        }
        
        //println(centroids.size());
        
        removeSimularGSCentroids(centroids);
        //println(centroids.size());
        
        Collections.sort(centroids);
        
        pruneGSCentroids(centroids, n);
        
        //print("[");
        //print(centroids.get(0));
        //for (int i = 0; i < centroids.size(); i++) {
        //    print(", " + centroids.get(i));
        //}
        //println("]");
        
        for (int r = 0; r < rows; r++) {
            for (int c = 0; c < cols; c++) {
                for (int i = 0; i < centroids.size(); i++) {
                    if (abs(matrix[r][c].s - centroids.get(i).i) < gscthresh){
                        matrix[r][c].id = i;    
                    }
                }
            }
        }
        
        int[] ret = new int[n];
        for (int i = centroids.size() - 1; i >= 0; i--) {
            ret[n - i - 1] = centroids.get(i).i;
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
    void pruneGSCentroids(ArrayList<ClusterGSCentroid> centroids, int n){
        while (centroids.size() > n) { 
            pruneGSCentroid(centroids, n);
        }
    }
    
    boolean pruneGSCentroid(ArrayList<ClusterGSCentroid> centroids, int n) {
        for (int i = 0; i < centroids.size(); i++){
            for (int j = i + 1; j < centroids.size(); j++){
                if (abs(centroids.get(i).i - centroids.get(j).i) < gscthresh) {
                    centroids.remove(j);
                    j--;
                    return true;
                }
            }
        }
        if (centroids.size() > n) {
            gscthresh++; // #increash threshold until you have only n centroids
            pruneGSCentroid(centroids, n);
        }
        return false;
    }
    
    void removeSimularGSCentroids (ArrayList<ClusterGSCentroid> centroids) {
        while (removeSimularGSCentroid(centroids));
    }
    
    boolean removeSimularGSCentroid(ArrayList<ClusterGSCentroid> centroids) {
        for (int i = 0; i < centroids.size(); i++){
            for (int j = i + 1; j < centroids.size(); j++){
                if (centroids.get(i).i == centroids.get(j).i) {
                    centroids.remove(j);
                    j--;
                    return true;
                }
            }
        }
        return false;
    }
}