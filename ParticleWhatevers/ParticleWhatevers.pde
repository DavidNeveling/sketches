import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

ArrayList<Particle> dots;
float G;
float speed;
//PeasyCam cam;

void setup(){
    size(800, 800, P3D);
    speed = .5;
    G = 0.0000000000667408 * pow(width * height, 2) * speed;
    dots = new ArrayList<Particle>();
    //cam = new PeasyCam(this, width / 2, height / 2, 0, 800);
    for (int i = 0; i < 100; i++){
        dots.add(new Particle(new PVector(int(random(width)), int(random(height)), int(random(-sqrt(width * height)))), new PVector(int(random(10)), int(random(10))), new PVector(int(random(1)), int(random(1))), int(random(sqrt(width * height) / 100, sqrt(width * height) / 50)), color(random(255), random(255), random(255))));    
    }
}

void draw(){
    background(0);
    noStroke();
    pointLight(100, 100, 100, -100, 100, 500);
    ambientLight(255, 255, 255);
    for (Particle p : dots){
        PVector newdir = new PVector(0, 0);
        float avgF = 0;
        for (Particle p2 : dots){
            if (p2 != p){
                float F = G * p.mass * p2.mass / pow(dist(p.p.x, p.p.y, p2.p.x, p2.p.y), 2);
                avgF += F;
                newdir.add((new PVector((p2.p.x - p.p.x), (p2.p.y - p.p.y))).normalize().mult(F));
            }
        }
        avgF /= dots.size();
        newdir.normalize().mult(avgF);
        p.v = newdir;
    }
    for (int p = dots.size() - 1; p >= 0; p--){
        boolean set = false;
        for (int p2 = dots.size() - 1; p2 >= 0 && !set; p2--){
            Particle one = dots.get(p);
            Particle two = dots.get(p2);
            if (p2 != p){
                if (dist(one.p.x, one.p.y, two.p.x, two.p.y) <= max(one.mass, two.mass) / 2){
                    set = true;
                    
                    PVector newV;
                    if (one.v.mag() > two.v.mag())
                        newV = one.v;    
                    else
                        newV = two.v;
                    float lerp;
                    if (one.mass > two.mass)
                        lerp = 1-(one.mass - two.mass) / one.mass;
                    if (one.mass < two.mass)
                        lerp = (two.mass - one.mass) / two.mass;
                    else
                        lerp = .5;
                    dots.add(new Particle(new PVector(one.p.x, one.p.y, one.p.z), newV, new PVector(0, 0, 0), max(one.mass, two.mass) + min(one.mass, two.mass) / 4, lerpColor(one.c, two.c, lerp)));
                    dots.remove(two);
                    dots.remove(one);
                }
            }
           
        }
    }
    for (Particle p : dots){
        p.update();
        p.show();    
    }
     
}

class Particle{
    int mass;
    PVector p;
    PVector v;
    PVector a;
    color c;
    public Particle(PVector p, PVector v, PVector a, int mass, color c){
        this.p = p;
        this.v = v;
        this.a = a;
        this.mass = mass;
        this.c = c;
    }
    
    public void show(){
        
        pushMatrix();
        translate(p.x, p.y, p.z);
        ambient(c);
        sphere(mass);    
        popMatrix();
    }
    
    public void update(){
        p.x += v.x;
        p.y += v.y;
    }
}