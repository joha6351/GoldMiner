import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class sketch_200127a extends PApplet {


Stone[] stones = new Stone[5];
Gold[] golds = new Gold[5];
Player player = new Player(300,50);
Score score = new Score(10, 10);

PImage back;
boolean setupphase = true;


public void settings() {
  size(600,600);
}

public void setup() {
  back = loadImage("../sprites/soil.png");
  background(back);
  //Tegner mineraler
  for (int i = 0; i < stones.length; i++) {
    stones[i] = new Stone(PApplet.parseInt(random(width)),PApplet.parseInt(random(150, height)), i);
  }
  
  for (int j = 0; j < golds.length; j++) {
    golds[j] = new Gold(PApplet.parseInt(random(width)),PApplet.parseInt(random(150, height)), j); //Hardcoded '5' for at lægge dem på enden af stones[i].
  }

}

public void draw() {
  
  while (setupphase) {
    for (int i = 0; i < stones.length; i++) {
      for (int j = 0; j < golds.length; j++) {
      
      //Tjekker om nogle overlapper, hvis der er tildel nye pladser til objekterne. Kører dobbelt ellers misser den nogle.
        if (overlap(stones[i].x, stones[i].y, golds[j].x, golds[j].y, stones[i].radius, golds[j].radius)) {
          regen();
        } else if (overlap(golds[j].x, golds[j].y, stones[i].x, stones[i].y, golds[j].radius, stones[i].radius)) {
          regen();
        }
      }
    }
    setupphase = false;
    break;
  }
  
  if (player.restart == true) {
    setup();
  }
  
  background(back);
  
  player.display();
  player.update();
  player.movement();
  
  score.display();
  
  for (int i = 0; i < stones.length; i++) {
    for (int j = 0; j < golds.length; j++) {
        stones[i].display();
        //stones[i].mineralCollision(player.x2, player.y2);
        //println(stones[i].mineralCollision(player.x2, player.y2)[0],stones[i].mineralCollision(player.x2, player.y2)[1]);
        
        golds[j].display();
        //golds[j].mineralCollision(player.x2, player.y2);
        //println(golds[j].mineralCollision(player.x2, player.y2)[0], golds[j].mineralCollision(player.x2, player.y2)[1]);
        
        player.grap(stones[i].mineralCollision(player.x2, player.y2)[0],stones[i].mineralCollision(player.x2, player.y2)[1]);
        score.addMoney(score.calcMoney(stones[i].mineralCollision(player.x2, player.y2)[0],stones[i].mineralCollision(player.x2, player.y2)[1]));
        
        player.grap(golds[j].mineralCollision(player.x2, player.y2)[0], golds[j].mineralCollision(player.x2, player.y2)[1]);
        score.addMoney(score.calcMoney(golds[j].mineralCollision(player.x2, player.y2)[0],golds[j].mineralCollision(player.x2, player.y2)[1]));
        
        
      }
    }
    
    
}

//Nye objekter
public void regen() {
  for (int i = 0; i < stones.length; i++) {
    stones[i] = new Stone(PApplet.parseInt(random(width)),PApplet.parseInt(random(150, height)), i);
  }
  
  for (int j = 0; j < golds.length; j++) {
    golds[j] = new Gold(PApplet.parseInt(random(width)),PApplet.parseInt(random(150, height)), j);
  }  
}

public boolean overlap(float p1x, float p1y, float p2x, float p2y, float p1r, float p2r) {
  if (dist(p1x, p1y, p2x, p2y) < p1r + p2r) {
    return true;
  } else {
    return false;
  }
}

public void keyPressed() {
  player.setMove(key, true);
}

public void keyReleased() {
  player.setMove(key, false);
}
class Mineral {
  
  float worth;
  float weight;
  int x;
  int y;
  float radius;
  PImage sprite;
  int n;
  int type;
  
 Mineral(int xpos, int ypos, int numberInArray) {
   x = xpos;
   y = ypos;
   worth = 0;
   weight = 0;
   radius = 0;
   n = numberInArray;
 }
 
 public void display() {
   imageMode(CENTER);
   image(sprite, x, y, radius, radius);
 }
 
 public int[] mineralCollision(float a, float b) {
   int[] mineralCollision = new int[3];
        if (dist(a, b, x, y) < radius) {
          mineralCollision[0] = n;
          mineralCollision[1] = type;
          mineralCollision[2] = 1;
        } else {
          mineralCollision[0] = 100;
          mineralCollision[1] = 100;
          mineralCollision[2] = 0;
        }
        
        return mineralCollision;
    } 
}

class Gold extends Mineral {
  
  PImage g_sprite = loadImage("../sprites/gold.png");
  
  Gold(int xpos, int ypos, int numberInArray) {
    super(xpos, ypos, numberInArray);
    x = xpos;
    y = ypos;
    worth = 1.2f;
    weight = radius*10;
    radius = random(10, 50);
    sprite = g_sprite;
    type = 1;
  }
}

class Stone extends Mineral {
  
  PImage r_sprite = loadImage("../sprites/rock.png");
  
  Stone(int xpos, int ypos, int numberInArray) {
    super(xpos, ypos, numberInArray);
    x = xpos;
    y = ypos;
    worth = 0.1f;
    weight = radius*3;
    radius = random(10, 50);
    sprite = r_sprite;
    type = 2;
  }
}
class Player {
  
  int x1, y1, x2, y2;
  boolean isUp, isDown, reset, restart;
  float theta;
  float thetaIncrease;
  float lineL;
  int lineIncrease;
  float r;
  
  Player(int xpos, int ypos) {
    x1 = xpos;
    y1 = ypos;
    theta = 0;
    thetaIncrease = 0.035f;
    lineL = 25;
    lineIncrease = 4;
    r = 10;
  }
  
  public void display() {
    line(x1, y1, x2, y2);
    ellipseMode(CENTER);
    fill(0);
    circle(x2, y2, r);
  }
  
  public void update() {
    theta += thetaIncrease;
    if (theta > PI || theta < 0) {
      thetaIncrease *= -1;
    }
    x2 = PApplet.parseInt(x1+cos(theta)*lineL);
    y2 = PApplet.parseInt(y1+sin(theta)*lineL);
    
    if (lineL < 0) {
      theta += thetaIncrease;
    }
  }

  public void grap(int mineralCollisionNumber, int mineralType) {
    for (int i = 0; i < stones.length; i++) {
      if (mineralCollisionNumber == stones[i].n && mineralType == stones[i].type) {
          stones[mineralCollisionNumber].x = x2;
          stones[mineralCollisionNumber].y = y2;
          //thetaIncrease *= 0;
          while (stones[mineralCollisionNumber].y >= 70) {
            lineL -= lineIncrease;
            x2 = PApplet.parseInt(x1+cos(theta)*lineL);
            y2 = PApplet.parseInt(y1+sin(theta)*lineL);
            break;
          }
          if (stones[mineralCollisionNumber].y < 70) {
            println("Stone; " + stones[mineralCollisionNumber].n + " got caught!");
            stones[mineralCollisionNumber].x = 0;
            stones[mineralCollisionNumber].y = 0;
            
            score.addMoney(score.calcMoney(mineralCollisionNumber, mineralType));
            
            //Reset af player
            x1 = 300;
            y1 = 50;
            theta = 0;
            thetaIncrease = 0.035f;
            lineL = 25;
            lineIncrease = 4;
            r = 10;
          } else {
            continue;
          }
      }
    }
    
    for (int j = 0; j < golds.length; j++) {
      if (mineralCollisionNumber == golds[j].n && mineralType == golds[j].type) {
        golds[mineralCollisionNumber].x = x2;
        golds[mineralCollisionNumber].y = y2;
        //thetaIncrease *= 0;
        while (golds[mineralCollisionNumber].y >= 70) {
          lineL -= lineIncrease;
          x2 = PApplet.parseInt(x1+cos(theta)*lineL);
          y2 = PApplet.parseInt(y1+sin(theta)*lineL);
          break;
        }
        if (golds[mineralCollisionNumber].y < 70) {
          println("Gold; " + golds[mineralCollisionNumber].n + " got caught!");
          golds[mineralCollisionNumber].x = 0;
          golds[mineralCollisionNumber].y = 0;
          
          score.addMoney(score.calcMoney(mineralCollisionNumber, mineralType));
          
          //Reset af player
          x1 = 300;
          y1 = 50;
          theta = 0;
          thetaIncrease = 0.035f;
          lineL = 25;
          lineIncrease = 4;
          r = 10;
        } else {
          continue;
        }
      }
    }
  }

  public boolean setMove(char k, boolean b) {
    switch(k) {
      case 'w':
        return isUp = b;
      case 's':
        return isDown = b;
      case 'r':
        return reset = b;
      case 'q':
        return restart = b;
      
      default:
        return b;
    }
  }

  public void movement() {
    if (isUp) {
       lineL -= lineIncrease;
     } else if (isDown) {
       thetaIncrease *= 0;
       lineL += lineIncrease;
     }
     if (reset || dist(x2, y2, x1, y1) < 20) {
       x1 = 300;
       y1 = 50;
       theta = 0;
       thetaIncrease = 0.035f;
       lineL = 25;
       lineIncrease = 4;
       r = 10;
     }
  }
}
class Score {
  
  float money;
  int x,y;
  float moneyAdd;
  
  Score(int xpos, int ypos) {
    x = xpos;
    y = ypos;
    money = 0.0f;
  }
  
  public void display() {
    textAlign(LEFT, CENTER);
    fill(0xffFF79E7);
    textSize(28);
    text("Money: " + money, x, y);
  }

  public float calcMoney(int mineralCollisionNumber, int mineralType) {
    if (mineralType == 1) {
      moneyAdd = (stones[mineralCollisionNumber].worth * stones[mineralCollisionNumber].weight);
    } else if (mineralType == 2) {
      moneyAdd = (golds[mineralCollisionNumber].worth * golds[mineralCollisionNumber].weight);  
    }
    return moneyAdd;
  }

  public void addMoney (float addedMoney) {
    money = money + addedMoney;
  }
  

}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "sketch_200127a" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
