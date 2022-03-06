class Brain {
  int[] directions;
  float dir=270;
  float hlprdir;
  float[] dirHist;
  int step=0;
  int qsize;
  Brain(int size){
    directions=new int[size];
    dirHist=new float[size];
    qsize=size;
    randomize();
    }
  void randomize(){
    for(int i=0;i<qsize;i++){
      hlprdir=dir;
      dir=dir+(random(60)-30);
      dir=(hlprdir+dir)/2;
      dirHist[i]=dir;
      directions[i]=(int)random(3);
    }
  }
  void mutate(){
    float chance=0.05;
    for(int i=0;i<qsize;i++){
      if (random(1)<chance){
        directions[i]=(int)random(3);
      }
    }
  }
  Brain clone(){
    Brain clone =new Brain(directions.length);
    for(int i=0;i<directions.length;i++){
      clone.directions[i]=directions[i];
    }
    return clone;
  }
}
