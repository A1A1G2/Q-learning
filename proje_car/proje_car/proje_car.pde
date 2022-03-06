population pop;
int size=1000;
boolean fnsh=false;
boolean load=false;
void setup(){
  size(1000,1000);
  pop=new population(1000);

}
void draw(){
  background(255);
  fill(0,255,0);
  ellipse(width/2,5,100,100);
  fill(0,0,255);
  rect(width-550,height/4,550,10);
  rect(0,height*2/4,width-450,10);
  rect(width-550,height*3/4,550,10);
  if(!pop.allDie()){
    pop.update();
    pop.show();
 }
 else{
   if(fnsh){pop.extract();noLoop();}
   pop.calculateSum();
   pop.elimination();
   pop.mutate();
 }
}
void keyPressed(){
  println(keyCode);
  if(keyCode==32){
    fnsh=true;
   }
}
