class population{
  Car[] cars;
  int qsize;
  float sum=0;
  float max;
  int maxLocate;
  int gen=1;
  float minStep=1000;
  population(int size){
    cars=new Car[size];
    for(int i=0;i<size;i++){
      cars[i]=new Car();
    }
    qsize=size;
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  void update(){
    for(int i=0;i<qsize;i++){
      if(cars[i].brain.step<minStep){
        cars[i].update();
      }
      else{cars[i].dead=true;}
    }
  }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  void show(){
    for(int i=1;i<qsize;i++){
      cars[i].show();
    }
    cars[0].show();
  }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  boolean allDie(){
    for(int i=0;i<qsize;i++){
      if(!cars[i].dead && !cars[i].reachedGoal){//not dead
        return false;
      } 
    }
    return true;
  }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  void calculateSum(){
    for(int i=0;i<qsize;i++){
      cars[i].calculateFitness();
      sum+=cars[i].fitness;
    }
  }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Car selectParent(){
    float hlpr=0;
    for(int i=0;i<qsize;i++){
      hlpr+=cars[i].fitness;
      if(hlpr>random(sum)){
        return cars[i];
      }
    }
    return null;
  }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  void elimination(){
    Car[] news=new Car[cars.length];
    findBest();
    calculateSum();
    news[0]=cars[maxLocate].clon();
    news[0].best=true;
    for(int i=1;i<cars.length;i++){
      if(i<cars.length/4){
      Car parent=selectParent();
      news[i]=parent.clon();
      }
      else{
        news[i]=cars[maxLocate].clon();
    }
    }
    cars=news.clone();
    gen++;
    
  }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  void findBest(){
    float hlpr=0;
    for(int i=0;i<qsize;i++){
       if (cars[i].fitness>hlpr){
         hlpr=cars[i].fitness;
         maxLocate=i;
       }
       max=hlpr;
    }
    if(cars[maxLocate].reachedGoal){
    minStep=cars[maxLocate].brain.step;
    println("min Step: ",minStep);
    }
  }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  void mutate(){
    for(int i=1;i<qsize;i++){
      cars[i].brain.mutate();
    }
  }
  void extract(){
    print("$$");
    for(int i=0;i<minStep;i++){
      print(cars[maxLocate].brain.directions[i],",");
    }
    print("$$");
  }
}
