ArrayList ps = new ArrayList();
void setup(){
  size(640, 640);
  frameRate(30);
  for(int i = 0; i < 2000; i++){
    ps.add(new Particle(new PVector(random(width), random(height))));
  }
}

void draw(){
  background(0);
  for(int i = 0; i < ps.size(); i++){
     Particle p = (Particle) ps.get(i);
     p.draw();
     p.boundary();
  }
  saveFrame("frames/####.tga");
}

class Particle {
  PVector loc, vel, acc;

  Particle(PVector loc){
    this.loc = loc;
    vel = new PVector();
    acc = new PVector();
  }

  void draw(){
    PVector m = new PVector(mouseX, mouseY);
//    if(mousePressed){
      PVector a = new PVector();
      for(int i=0; i<ps.size(); i++){
        Particle p = (Particle) ps.get(i);
        PVector d = PVector.sub(p.loc, loc);
        float r = d.mag();
        r = constrain(r,5,25);
        r = 1/(r*r);
        d.normalize();
        d.mult(r);
        a.add(d);
      }
      acc = a;
//    }else{

//    }
    vel.add(acc);
    loc.add(vel);
    acc.mult(0);
    vel.mult(0.99);
    stroke(255, 0, 0, map(vel.mag(), 0, 20, 50, 200));
    point(loc.x, loc.y);
  }

  void boundary(){
    if(loc.x < 0) vel.x *= -1;
    if(loc.x > width) vel.x *= -1;
    if(loc.y < 0) vel.y *= -1;
    if(loc.y > height) vel.y *= -1;
  }
}
