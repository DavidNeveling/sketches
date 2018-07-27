from PIL import Image
import random
import operator
from datetime import datetime

idtocolor = {
    0 : 63,
    1 : 127,
    2 : 191,
    3 : 255
    }

class Pixle:
    def __init__(self,red,blue,green,alpha):
        self.r = red
        self.b = blue
        self.g = green
        self.a = alpha

    def __repr__(self):
        return str(self.PixleTuple())

    def PixleList (self):
        return [self.r,self.b,self.g,self.a]
    def PixleTuple (self):
        return (self.r,self.b,self.g,self.a)

class SuperPixle:
    def __init__(self,pixle, row, column):
        if isinstance(pixle, Pixle):
            self.p = pixle
        else:
            #Throw exception
            return
        self.np = pixle #initialize the second pixle
        self.r = row
        self.c = column
        self.s = int((pixle.r * 0.30) + (pixle.g * 0.59) + (pixle.b * 0.11)) #Grayscale equivalent
        self.id = 0 #Enumerated classification, assigned on algorithm run, 0->original
        #self.cl = 0 #classification

    def __repr__(self):
        return str((self.p,self.r,self.c,self.s,self.id))

class SuperImage:
    def __init__(self,image):
        self.columns = image.size[0]
        self.rows = image.size[1]
        self.matrix = self.GenerateMatrix(list(image.getdata()))
        self.gscthresh = 10

    def __repr__(self):
        return str(self.matrix)

    def GenerateMatrix(self,data):
        matrix = [[0 for x in range(self.columns)] for x in range(self.rows)]
        for r in range (self.rows):
            for c in range (self.columns):
                red = data[r*self.columns + c][0]
                blue = data[r*self.columns + c][1]
                green = data[r*self.columns + c][2]
                matrix[r][c] = SuperPixle(Pixle(red,blue,green,1),r,c)
        return matrix


    def GenerateBins(self):
        temp = [0] * 256
        for r in range (self.rows):
            for c in range (self.columns):
                temp[self.matrix[r][c].s] += 1
        return temp

    class ClusterGSCentroid:
        def __init__(self,ind,val):
            self.i = ind #bin index
            self.v = val #value of weights
        def __repr__(self):
            return str([self.i,self.v])

    #Main algorithm
    def ApplyClusterGS(self,n = 1, anim = True): #n number of clusters
        if n < 1: return #throw exception
        random.seed(datetime.now())
        centroids = []
        radius = 10 #kernel radius
        data = [0] * (radius) + self.GenerateBins() + [0] * (radius)

        #create centroids with radius compensation
        for i in range(0,256):
            #centroids.append(self.ClusterGSCentroid(random.randint(0,255) + radius,0))
            centroids.append(self.ClusterGSCentroid(i + radius,0))

        #shift centroids
        for centroid in centroids:
            cont = True
            prev = 0
            while cont:
                left = data[centroid.i] * .5
                right = data[centroid.i] * .5

                for i in range(1,radius + 1):
                    left += data[centroid.i - i] * (1/(1*i))#kernel
                    right += data[centroid.i + i] * (1/(1*i))#kernel

                if left > right:
                    centroid.i -= 1
                    if prev == 1:
                        cont = False
                        centroid.v = left + right
                    prev = -1

                if left < right:
                    centroid.i += 1
                    if prev == 1:
                        cont = False
                        centroid.v = left + right
                    prev = 1

                if left == right:
                    centroid.v = left + right
                    cont = False

        #remove radius compensation from centroids
        for centroid in centroids:
            centroid.i -= radius
            #print (centroid)

        print(len(centroids))

        #remove similar centroids
        self.RemoveSimularGSCentroids(centroids)

        print(len(centroids))

        #sort centroids by decending value
        centroids.sort(key=operator.attrgetter('v'), reverse = True)

        #remove extra centroids
        self.PruneGSCentroids(centroids,n)
        print(centroids)

        #label superpixles
        #centroids.sort(key=operator.attrgetter('i'), reverse = False)
        for r in range (self.rows):
            for c in range (self.columns):
                for i, centroid in enumerate(centroids, start=0):
                    if abs(self.matrix[r][c].s - centroid.i) < self.gscthresh:
                        self.matrix[r][c].id = i


	#Supporting
    def PruneGSCentroids(self,centroids,n):
        #thresh = 10
        while len(centroids) > n: self.PruneGSCentroid(centroids,n)

    def PruneGSCentroid(self,centroids,n):
        for i in range(0,len(centroids)):
            for ii in range(i+1,len(centroids)):
                if abs(centroids[i].i - centroids[ii].i) < self.gscthresh:
                    del centroids[ii]
                    return True
        if len(centroids) > n:
            self.gscthresh += 1 #increash threshold until you have only n centroids
            self.PruneGSCentroid(centroids,n)
        return False

    def RemoveSimularGSCentroids (self,centroids):
        while self.RemoveSimularGSCentroid(centroids): 0 == 0

    def RemoveSimularGSCentroid(self,centroids):
        for i in range(0,len(centroids)):
            for ii in range(i+1,len(centroids)):
                if centroids[i].i == centroids[ii].i :
                    del centroids[ii]
                    return True
        return False

def main():
	#Open image
    im = Image.open("nat_new_2.png")

	#Create superimage
    si = SuperImage(im)

	#Classify pixles
    si.ApplyClusterGS(4, True)

    return


if __name__== "__main__":
    main()
