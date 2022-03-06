class Car{
  Brain brain;
  PVector a;
  PVector v;
  PVector pos;
  int dir=UP;
  float rot=270;
  float limV=3;
  float fitness;
  boolean dead=false;
  boolean reachedGoal=false;
  boolean best=false;
  //////////////////////////////////////////////////////////////////////////////////////////////
  Car(){
    brain=new Brain(1000);
    a=new PVector (0,0);
    v=new PVector (0,0);
    pos=new PVector (width/2,height*9/10);
  }
  //////////////////////////////////////////////////////////////////////////////////////////////
  void move(){
    if(brain.step<brain.directions.length&&!dead &&!reachedGoal){
      if(brain.directions[brain.step]==0){
        rot-=5;
      }
      if(brain.directions[brain.step]==1){
        rot+=5;
      }
      if(brain.directions[brain.step]==2){
      }
      a=PVector.fromAngle(radians(rot));
      a.mult(0.1);
      v.add(a);
      v.limit(limV); 
      pos.add(v);
      brain.step++;
     }
  }
  //////////////////////////////////////////////////////////////////////////////////////////////
  void show(){
    if(best){fill(255,255,0);}
     else{fill(255,100,100);}
     pushMatrix();
     translate(pos.x,pos.y);
     rotate(radians(rot-270));
     rect(-10,0,10,20);
     popMatrix();
  }
  //////////////////////////////////////////////////////////////////////////////////////////////
  void update(){
    move();
   if(pos.x<5||pos.x>width-5||pos.y<5||pos.y>height-5){
     dead=true;
   }
   
   if(dist(pos.x,pos.y,width/2,5)<50){
     reachedGoal=true;
   }
   
   //obstacles
   if(pos.x<width-450 && pos.x>0 && pos.y>height*2/4&&pos.y<(height*2/4)+10){
     dead=true;
   }
   if(pos.x<width && pos.x>width-550 && pos.y>height/4 && pos.y<(height*1/4)+10){
     dead=true;
   }
   if(pos.x<width && pos.x>width-550 && pos.y>height*3/4 && pos.y<(height*3/4)+10){
     dead=true;
   }
   
  }
  //////////////////////////////////////////////////////////////////////////////////////////////
  void calculateFitness(){
    if (reachedGoal){
      fitness=10.0+100000.0/(float)(brain.step*brain.step);
    }
    else {
      float dIst=dist(pos.x,pos.y,width/2,50);
      fitness=1/(dIst*dIst*dIst*dIst*dIst*dIst*dIst*dIst*dIst*dIst*dIst*dIst);
    }
  }
  Car clon(){
    Car clon=new Car();
    clon.brain=brain.clone();
    return clon;
  }
  
}
