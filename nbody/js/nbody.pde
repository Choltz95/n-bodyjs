int spread = 1000;
int fps = 30;
int num = 50; 
float G = 0.5;
float lastTime = 0.0;
boolean initialSpin = false;

float threshold = 2.0; // lower is slower and closer to the O(n^2), higher is faster but less accurate. Used for Barnes-Hut Estimation
float brightness = 2.0; // lower is dimmer

ArrayList<Particle> particles = new ArrayList<Particle>(num);
void setup(){
  size(800, 700);
  frameRate(60);
  noStroke();
  /*
  for(int i = 0; i < 800; i++){
   //ps.add(new Particle(new PVector(random(width), random(height))));
   //ps.add(new Particle(new PVector(400,350)));
   particles.add(new Particle(new PVector(random(380,420), random(330,370))));
  }*/
  
  addParticles(
    num, // how many
    new PVector(400, 350), // where
    spread/2, // spread
    0 // tangential velocity
  );
}

void draw(){
  background(0);
  float start = millis();
  computeBodies();
  float diff = millis() - start;
  float avg = (lastTime + diff)/2;
  lastTime = diff;

  fill(255);
  text("Particle count: " + particles.size(), 3, 15);
  text("Frame time: " + int(avg) + " ms", 3, 30);
  //  saveFrame("frame/####.png");
}

void addParticles(int howMany, PVector where, float spread, float tangentialVelocity){
  int[] rand = new int[]{int(random(100, 255)), int(random(100, 255)), int(random(100, 255))};
  float mass = (rand[0] + rand[1] + rand[2])/765f;
  for (int i = 0; i < howMany; i++){
    float theta = random(0, 6.283184);
    float cosine = cos(theta);
    float sine = sin(theta);

    PVector position = new PVector(where.x, where.y);
    PVector displace = new PVector(cosine, sine); // randomly rotated unit vector
    PVector velocity = PVector.mult(new PVector(-displace.y, displace.x), tangentialVelocity);

    displace.mult(random(0, spread));
    position.add(displace);

    particles.add(new Particle(random(-1, 2), rand, position, velocity));
  }
}

void computeBodies(){
  for (Particle p : particles){
    for (Particle p2 : particles){
      if (p == p2)//particle is being compared to itself
        continue;

      PVector v = PVector.sub(p2.pos, p.pos);//vector in direction of p2
      float r = v.mag();//magnitude = distance

      float mag = G*p2.mass/(r*fps);

      v.normalize();//gravitational attraction in the direction of p2
      v.mult(mag);

      p.vel.add(v);//add sum acceleration to velocity
    }
    p.move();
    set((int)p.pos.x, (int)p.pos.y, color(p.Pcolor[0], p.Pcolor[1], p.Pcolor[2]));
  }
}

class Particle{
  float mass;
  int Pcolor [];
  PVector pos;
  PVector vel;
  Particle(float mass, int Pcolor[], PVector pos, PVector vel){
    this.mass  = mass;
    this.Pcolor = Pcolor;
    this.pos   = pos;
    this.vel   = vel;
  }
  
  void move(){
    // add velocity to position
    this.pos.add(this.vel);
  }

  void constr(float min, float max){
    // constrain particle position to window boundary
    this.pos.x = constrain(this.pos.x, min, max);
    this.pos.y = constrain(this.pos.y, min, max);
  }

  float x(){
    return this.pos.x;
  }

  float y(){
    return this.pos.y;
  }
}
