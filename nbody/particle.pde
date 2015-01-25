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
