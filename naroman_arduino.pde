//importing libraries for arduino and sound
import processing.serial.*;
import cc.arduino.*;
Arduino arduino;
import processing.sound.*;

SoundFile chakra;
SoundFile fightingspirit;
SoundFile rasengan;

// animating pacman's mouth variable
boolean mouth = false; //if opening mouth
float MW = PI/4; // mouth width
boolean right = false, left = false,up=false,down=false,aa=false,dd=false,ss=false,ww=false,endgame=false,start=true,screen1=false,screen2=false;;
int a=1;
// pacman variables
float move=40;
float direction = 0 ,direction1 = 0 ,direction2 = 0 ,direction3 = 0;
int c=0;
int score1;
int score2;
move ghost;
move sghost;
move s1ghost;
move s2ghost;
// dot variables
Dot[] dotGenerate;
PImage img;
PImage img1;

float Size;
Dot dot1;
PFont myFont;
PFont myF;
int score = 0;

long  cg;
int x1=60;
int y1=60;
void setup()
{
  //initializing arduino port and pins
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  arduino.pinMode(0, Arduino.INPUT);
  arduino.pinMode(1, Arduino.INPUT);
  arduino.pinMode(2, Arduino.INPUT);
  arduino.pinMode(3, Arduino.INPUT);
  arduino.pinMode(4, Arduino.INPUT);
  arduino.pinMode(5, Arduino.INPUT);
  arduino.pinMode(6, Arduino.INPUT);
  arduino.pinMode(7, Arduino.INPUT);
  ellipseMode (RADIUS);
  //calling in all sounds
  chakra = new SoundFile(this, "chakra.wav");
  fightingspirit = new SoundFile(this, "fightingspirit.wav");
  rasengan = new SoundFile(this, "rasengan.wav");
  
  fightingspirit.loop();
  
  size (1950, 930);
  background (0, 0,0);
  img = loadImage("df.png"); 
  img1=loadImage("nar.png");
  myFont=createFont("Chiller",150);
  myF=createFont("Times New Roman",50);
  ghost= new move();
  sghost=new move();
  s1ghost=new move();
  s2ghost=new move();
  dotGenerate = new Dot[5];

  for (int i = 0; i < dotGenerate.length; i = i + 1)
  {
    dotGenerate[i] = new Dot();
  }
}


void draw()
{

  background(0, 0, 0);

 image(img,x1,y1,100,100);
 if(a==1)
    ghost.show();
    if(a==2)
    {
    sghost.show1();
    s1ghost.show2();
    s2ghost.show3();
    }
if(start)
  {
   fill(100,100,200);
   stroke(255,0,0,200);
   strokeWeight(10);
   rect(500,200,1000,600);
   textFont(myFont);
   fill(0,0,0);
   textSize(50);
   text("Git, Lol & Kone present......",1050,350);
   fill(250,170,100);
   image(img1,600,450,800,300);
   text("Step FORWARD to conitnue...", 1475,775);
  
   if(arduino.analogRead(0)>900)
     {
       screen1=true;
       start=false;
       
       
     }  
  }
  if(screen1)
  {
    fill(52, 235, 153);
   stroke(255,0,0,200);
   strokeWeight(10);
   rect(400,100,1200,700);
   
   textFont(myF);
   textSize(40);
   fill(71, 68, 97);
   text("Naruto, the young shinobi (ninja) of Konoha village, aspires to be the\n Hokage(leader and strongest shinobi) of his village, for which he must \ncollect chakra points to get stronger. However, the evil organization, \nAkatsuki,headed by Madara Uchiha, wants to apprehend Naruto to \nextract the Nine Tailed Spirit Kurama sealed inside him. They release\n several Akatsuki pacmans to capture Naruto. Play as Naruto and evade\n akatsuki pacmans while collecting chakra points. Do you have what it\n takes to be the HOKAGE?\n\n Step BACKWARD to continue!",1570,200); 
   fill(250,170,100);
   if(arduino.analogRead(1)>900)
     {
       screen1=false;
       screen2=true;
       
     }
  }
 if(screen2)
  {
   fill(52, 235, 153);
   stroke(255,0,0,200);
   strokeWeight(10);
   rect(400,100,1200,700);
   
   textFont(myF);
   textSize(35);
   fill(71, 68, 97);
   text("Sage mode (single player) - Naruto is confronted by Deidara, Kakuzu and Hidan\n Pacmans of Akatsuki while collecting chakra points. Collect as many chakra points\n",1570,200);
   text("as you can while evading them.                                                           \n",1370,300);
   text("6 Paths mode (multiplayer) - Naruto has defeated all the akatsuki members except\n the Pain Pacman. Player 1 plays as Naruto and player 2 plays as Pain in round 1. In\n round 2, they switch avatars. Player with maximum chakra points as Naruto wins.\n",1570,360); 
   text("Controls - for both Naruto and Pain Pacman (in multiplayer) - step on forward or\n backward platform to move up or down. Obstruct the laser to your right or left to \nmove right or left. You are free to use any portion of your body as well as the kunai\n to initiate these movements, like using your foot to obstruct the laser and what not.\n You might even end up creating your very own jutsu for Naruto!\nObstruct RIGHT laser for multiplayer and LEFT laser for single player!            ",1570,530);

   fill(250,170,100);
   if(arduino.analogRead(2)<400)
     { 
       a=2;
       screen2=false;
      
     }
      if(arduino.analogRead(3)<400)
     { 
       a=1;
       screen2=false;
      
     }
  }
  if (endgame) {  
  // if game ends
  
    if(c<=1&& a==1)
      {   
          score1=score;
          clear();
          textSize(50);
          fill(235, 52, 98);
          text("Round 1 Over", width/2+120, height/2-50);        
          text("Step FORWARD When Ready For Round 2", width/2+width/4-80, height/2+50);        
          ghost.x=60;
          ghost.y=60;
          x1=60;
          y1=60;
      
    if(arduino.analogRead(0)>900)
       endgame=false;
        
      } 
      
      else if(c>1 && a==1)
      {
        
         score2=score-score1;
         clear();
         textSize(50);
         fill(235, 52, 98);
          text("Round 2 Over", width/2+100, height/2-50);
          text("Step FORWARD When Ready to View Results", width/2+width/4-80, height/2+50);
          if(arduino.analogRead(0)>900)
          {
       if(score1>score2) 
             {
               clear();
               fill(235, 52, 98);
               text("Player 1 score=",width/2,height/2-100);
               text(score1,width/2+100,height/2-100);
               text("Player 2 score=",width/2,height/2-50);
               text(score2,width/2+100,height/2-50);
               textSize(80);
               text("Player 1 wins!!",width/2+140,height/2+50);
             }
       else if(score2>score1)
              { clear();
              fill(235, 52, 98);
               text("Player 1 score=",width/2,height/2-100);
               text(score1,width/2+100,height/2-100);
               text("Player 2 score=",width/2,height/2-50);
               text(score2,width/2+100,height/2-50);
               textSize(80);
               text("Player 2 wins!!",width/2+140,height/2+50);
              }
              else
               { clear();
               fill(235, 52, 98);
               text("Player 1 score=",width/2,height/2-100);
               text(score1,width/2+100,height/2-100);
               text("Player 2 score=",width/2,height/2-50);
               text(score2,width/2+100,height/2-50);
               textSize(80);
               text("DRAW!!",width/2,height/2+50);
              }
          }}
          else
          {
            clear();
         textSize(50);
         fill(235, 52, 98);
          text("Game Over", width/2+100, height/2-50);
          text("Player 1 score=", width/2+30, height/2+50);
          text(score, width/2+110, height/2+50);
          }
  } 
  else {  
  if(!start&&!screen1&&!screen2)
  {
  if (mouth)
  {
    MW = MW + .1;
    if (MW > PI/3)
    {
      mouth =false;
    }
  }
  else
  {
    MW = MW - .1;
    if (MW < 0)
    {
      mouth = true;
    }
  }
  
    
    if (arduino.analogRead(2)<400)
    {
     
      sghost.moveright(1);
      s1ghost.moveup(2);
      s2ghost.movedown(3);
      moveleft1();
    
    }
    if(arduino.analogRead(0)>900)
    {
   
      sghost.movedown(1);
      s1ghost.moveleft(2);
      s2ghost.moveright(3);
      moveup1();
    }
    
    if (arduino.analogRead(3)<400)
    {
     
      sghost.moveleft(1);
      s1ghost.movedown(2);
      s2ghost.moveup(3);
      moveright1();
    }
    if (arduino.analogRead(1)>900)
    {
    
      sghost.moveup(1);
      s1ghost.moveright(2);
      s2ghost.moveleft(3);
      movedown1();
    }
      
    if (arduino.analogRead(6)<400)
    {
      ghost.moveleft(0);
    }
    if(arduino.analogRead(4)>900)
    {
     ghost.moveup(0);
    }
    
    if (arduino.analogRead(7)<400)
    {
      ghost.moveright(0);
    }
    if (arduino.analogRead(5)>900)
    {
      ghost.movedown(0);
    }
    
  for (int i = 0; i < dotGenerate.length; i = i + 1)
  {
    dotGenerate[i].checkCollision();
    dotGenerate[i].draw();
  }
  if(checkcol())
  {
    ;
    
  }
  } 
fill(51, 204, 89);   
textAlign(RIGHT);
textSize(40);
text("Score=",width-100,60);
if(c==0)
text(score,width-20,60);
else
text(score-score1,width-20,60);
  }

}

class move
{
  int x, y;
  move()
  {
    x=60;
    y=60;
  }
  void show()
  {
     stroke(255, 255, 255);
     fill(181, 21, 9);
     arc (x+1820, y+800, 40, 40, MW/2+direction , 2*PI - MW/2 + direction);  
  }
  void show1()
  {
    
   stroke(255, 255, 255);
     fill(181, 21, 9);
  arc (x+1820, y+800, 40, 40, MW/2+direction1 , 2*PI - MW/2 + direction1);
  }
   void show2()
  {
    
     stroke(255, 255, 255);
     fill(181, 21, 9);
  arc (x+1820, y+800, 40, 40, MW/2+direction2 , 2*PI - MW/2 + direction2);
  }
   void show3()
  {
    
     stroke(255, 255, 255);
     fill(181, 21, 9);
  arc (x+1820, y+800, 40, 40, MW/2+direction3 , 2*PI - MW/2 + direction3);
  }
  void moveleft(int n)
  {
       if(a==2)
      x-=15;
       
      else if (a==1&&n==0)
      {x-=10;
       direction=PI;}
      if(x<-1820)
        x=130;
    if(n==1)
     direction1=PI;
     else if(n==2)
    direction2=PI;
    else if(n==3)
    direction3=PI;
  }
  void moveright(int n)
  {
    
    if(a==2)
      x+=15;
      
     else if(a==1 && n==0)
     { x+=10;
      direction=0;}
       if(x>130)
        x=-1820;
        if(n==1)
      direction1=0;
      else if(n==2)
      direction2=0;
      else if(n==3)
      direction3=0;
    
  }
   void moveup(int n)
  {
    if(a==2)
      y-=15;
      
      else if(a==1 && n==0)
      {y-=10;
      direction=PI*3/2;}
      if(y<-800)
        y=130;   
        if(n==1)
    direction1=PI*3/2;
    else if(n==2)
    direction2=PI*3/2;
    else if(n==3)
    direction3=PI*3/2;
  }
  void movedown(int n)
  {
    
    if(a==2)
      y+=15;
      
      else if(a==1 && n==0)
     { y+=10;
      direction=PI/2;}
       if(y>130)
         y=-800;
         if(n==1) 
    direction1=PI/2;
    else if(n==2)
    direction2=PI/2;
    else if(n==3)
    direction3=PI/2;
  }
 
  
}
void moveleft1()
{
  x1-=15;
    
    if(x1<-50)
        x1=1950;
}
void moveup1()
{
   y1-=15;
     
       if(y1<0)
        y1=930;
}
 void movedown1()
  {
      y1+=15;
      
       if(y1>930)
         y1=0;
  }
   void moveright1()
  {
    
    
      x1+=15;
      if(x1>1950)
        x1=0;
     
    
  }
boolean checkcol ()//Checks collision of ghost with pacman
  {
    if (a==1&&   sqrt(  (ghost.x+1820 - (x1+50)) * (ghost.x+1820 - (x1+50)) + (ghost.y+800 - (y1+50)) * (ghost.y+800 -(y1+50))  )<80 )
    {
      println(score);
      endgame=true;
      c++;
      fightingspirit.stop();
      
      return true;
    }
    else if (a==2 &&( sqrt(  (s1ghost.x+1770 - x1) * (s1ghost.x+1770 - x1) + (s1ghost.y+750 - y1) * (s1ghost.y+750 - y1)  )<80 ||sqrt(  (sghost.x+1770 - x1) * (sghost.x+1770 - x1) + (sghost.y+750 - y1) * (sghost.y+750 - y1)  )<80 ||sqrt(  (s2ghost.x+1770 - x1) * (s2ghost.x+1770 - x1) + (s2ghost.y+750 - y1) * (s2ghost.y+750 - y1)  )<80  ))
    {
      println(score);
      endgame=true;
      c++;
      fightingspirit.stop();
      
      return true;
    }
    else
    return false;
  }
class Dot 
{
  float x, y, size;

  Dot ()
  {
    this.x = random (25, width - 25);
    this.y = random (25, height - 25);
    this.size = 12;
  }
  void draw ()
  {
   fill (66,197,245);
   stroke(9, 129, 181);
   strokeWeight(10);
   ellipse (this.x, this.y, size, size);
  }    
  boolean checkCollision ()//checks collision of pacman with pellets, updates score and generates new 
  {
    if (  sqrt(  (this.x - x1-50) * (this.x - x1-50) + (this.y - y1-50) * (this.y - y1-50)  ) < 40  )
    {
      this.x = random (25, width - 25);
      this.y = random (25, height - 25);
      score += 5;
      println(score);
      chakra.play();
      if(score%20==0)
      rasengan.play();
      return true;
    }
    return false;
  }
}
