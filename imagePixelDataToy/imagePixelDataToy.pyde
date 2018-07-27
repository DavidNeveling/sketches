list = []
f = 0
def setup():
    size(800, 800)
    global f
    f = open("spiralData.txt", "r")
    for line in f:
        list.append(line)
def draw():
    background(0)
    for i in range(0, 256):
        rect(float(width) * i / 256, height - int(list[i]) / 50, float(width) / 256, int(list[i]))
    saveFrame(f.name[0:f.name.rfind(".")] + ".png")    
    noLoop()
    