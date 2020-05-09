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

//Declare an ArrayList with Stone and Gold objects.
ArrayList<Stone> stones = new ArrayList<Stone>();
ArrayList<Gold> golds = new ArrayList<Gold>();

//Declare a Player object.
Player player = new Player(300,50);

//Declare a Score object.
Score score = new Score(10, 10);

PImage bgimage;
boolean setupphase = true;

//Sets program windowsize to 600x600 px.
public void settings() {
  size(600,600);
}

//Runs setup on the program. Loading and setting background image. Adds the specific Stone and Gold objects to the ArrayList.
public void setup() {
  bgimage = loadImage("../sprites/soil.jpg");
  background(bgimage);

  //Adds minerals to ArrayList
  stones.add(new Stone(PApplet.parseInt(random(width)), PApplet.parseInt(random(150, 350)), 0));
  stones.add(new Stone(PApplet.parseInt(random(width)), PApplet.parseInt(random(150, 350)), 1));
  stones.add(new Stone(PApplet.parseInt(random(width)), PApplet.parseInt(random(150, 350)), 2));
  stones.add(new Stone(PApplet.parseInt(random(width)), PApplet.parseInt(random(150, 350)), 3));
  stones.add(new Stone(PApplet.parseInt(random(width)), PApplet.parseInt(random(150, 350)), 4));
  
  golds.add(new Gold(PApplet.parseInt(random(width)), PApplet.parseInt(random(300, height)), 0));
  golds.add(new Gold(PApplet.parseInt(random(width)), PApplet.parseInt(random(300, height)), 1));
  golds.add(new Gold(PApplet.parseInt(random(width)), PApplet.parseInt(random(300, height)), 2));
  golds.add(new Gold(PApplet.parseInt(random(width)), PApplet.parseInt(random(300, height)), 3));
  golds.add(new Gold(PApplet.parseInt(random(width)), PApplet.parseInt(random(300, height)), 4));
  
}

//Main program loop
public void draw() {
  
  //Setupphase loop; places the mineral object until no minerals intersect.
  while (setupphase) {
    for (int i = 0; i < stones.size(); i++) {
      for (int j = 0; j < golds.size(); j++) {
        Stone sto = stones.get(i);
        Gold gol = golds.get(j);
      
        //While 2 different minerals intersects > run regen() function, which adds new random coordinates.
        while (overlap(sto.x, sto.y, gol.x, gol.y, sto.radius, gol.radius)) {
          regen();
          break;
        }
      }
    }
    //When nothing intersects break out of Setupphase loop
    setupphase = false;
    break;
  }
  
  //If the user restarts the program by pressing 'q' > run setup to get new specific objects.
  if (player.restart && stones.size() + golds.size() == 0) {
    setup();
  }
  
  //Game loop;
  //1. Set background to bgimage
  background(bgimage);
  
  //2. Invoke Player basic methods for rendering and moving.
  player.display();
  player.update();
  player.movement();
  
  //3. Invoke Score methods
  score.display();

  //Iterate over all the Stone and Gold objects to invoke rendering methods and invoking Player grap method for all Stone and Gold objects.
  for (int i = 0; i < stones.size(); i++) {
    Stone sto = stones.get(i);
    sto.display();
    player.grap(sto.mineralCollision(player.x2, player.y2)[0],sto.mineralCollision(player.x2, player.y2)[1]); //mineralCollisonNumber[0] = number in array, mineralCollisonNumber[1] = type
    
  }
  for (int j = 0; j < golds.size(); j++) {
    Gold gol = golds.get(j);
    gol.display();
    player.grap(gol.mineralCollision(player.x2, player.y2)[0], gol.mineralCollision(player.x2, player.y2)[1]); //mineralCollisonNumber[0] = number in array, mineralCollisonNumber[1] = type
    
  }  
    
  //Iterate over all Stone and Gold objects to check if they should be removed from ArrayList, because they were caught.
  /**
  for (int i = stones.size()-1; i >= 0; i--) {
    for (int j = golds.size()-1; j >= 0; j--) {
      Stone sto = stones.get(i);
      if (sto.caught) {
        stones.remove(i);
      }
      Gold gol = golds.get(j);
      if (gol.caught) {
        golds.remove(j);
      }
    }
  }*/

  for (int i = stones.size()-1; i >= 0; i--) {
    Stone sto = stones.get(i);
      if (sto.caught) {
        stones.remove(i);
      }
  }

  for (int j = golds.size()-1; j >= 0; j--) {
    Gold gol = golds.get(j);
      if (gol.caught) {
        golds.remove(j);
      }
  }


  //When the user has caught all minerals > show ending screen; final score and instruction for restarting.
  if (stones.size()+golds.size() == 0) {
    background(0);
    textAlign(CENTER, CENTER);
    fill(0xffFFFFFF);
    textSize(32);
    text("You earned: " + score.money + " this game.", width/2, height/2);
    textSize(26);
    text("Press 'q' to restart", width/2, height/2+36);
  }
    
}

//Function for replacing Stone and Gold obejcts. Using ArrayList.set instead of ArrayList.add to replace existing ArrayList values.
public void regen() {
  for (int i = 0; i < stones.size(); i++) {
    Stone sto = stones.get(i);
    stones.set(i, new Stone(PApplet.parseInt(random(width)), PApplet.parseInt(random(150, height)), i));
  }
  for (int j = 0; j < golds.size(); j++) {
    Gold gol = golds.get(j);
    golds.set(j, new Gold(PApplet.parseInt(random(width)), PApplet.parseInt(random(150, height)), j));
  }
}

//Function for checking if intersectiong between 2 objects.
public boolean overlap(float p1x, float p1y, float p2x, float p2y, float p1r, float p2r) {
  if (dist(p1x, p1y, p2x, p2y) < p1r + p2r) {
    return true;
  } else {
    return false;
  }
}

//Registers if a key is pressed and sends it to Player object.
public void keyPressed() {
  player.setMove(key, true);
}

//Registers if a key is released and sends it to Player object.
public void keyReleased() {
  player.setMove(key, false);
}
class Mineral {
  
  int worth;
  int weight;
  int x;
  int y;
  int radius;
  PImage sprite;
  int n;
  int type;
  boolean caught;
  
 //Constructor sets start values for position, dimensions, number and if caught. 
 Mineral(int xpos, int ypos, int numberInArray) {
   x = xpos;
   y = ypos;
   worth = 0;
   weight = 0;
   radius = 0;
   n = numberInArray;
   caught = false;
 }
 
 //Method for displaying the object.
 public void display() {
   imageMode(CENTER);
   image(sprite, x, y, radius, radius);
 }
 
 //Method for when the Player intersects with a Mineral object creates an array with the specific objects index number and type.
 public int[] mineralCollision(float a, float b) {
   int[] mineralCollision = new int[2];
   if (dist(a, b, x, y) < radius) {
     mineralCollision[0] = n;
     mineralCollision[1] = type;
    } else {
      mineralCollision[0] = 100;
      mineralCollision[1] = 100;
    }
    return mineralCollision;
  }

  //Method for changing a variable for determining if the object is caught and pulled back.
  public boolean hasCaught() {
    return caught = true;
  }
}

//New type of Mineral; Gold. Extends the Mineral class meaning it has all of the same methods and variables as Mineral.
class Gold extends Mineral {
  
  //Load sprite image file.
  PImage g_sprite = loadImage("../sprites/gold.png");
  
  //Constructor changes a few variables.
  Gold(int xpos, int ypos, int numberInArray) {
    super(xpos, ypos, numberInArray);
    x = xpos;
    y = ypos;
    worth = 4;
    radius = PApplet.parseInt(random(10, 40));
    weight = radius*10;
    sprite = g_sprite;
    type = 1;
  }
}

//New type of Mineral; Stone. Extends the Mineral class meaning it has all of the same methods and variables as Mineral.
class Stone extends Mineral {
  
  //Load sprite image file.
  PImage r_sprite = loadImage("../sprites/rock.png");
  
  //Constructor changes a few variables.
  Stone(int xpos, int ypos, int numberInArray) {
    super(xpos, ypos, numberInArray);
    x = xpos;
    y = ypos;
    worth = 1;
    radius = PApplet.parseInt(random(25, 65));
    weight = radius*3;
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
  
  //Constructor sets start values for position and rendering properties.
  Player(int xpos, int ypos) {
    x1 = xpos;
    y1 = ypos;
    theta = 0;
    thetaIncrease = 0.035f;
    lineL = 25;
    lineIncrease = 4;
    r = 10;
  }
  
  //Part 1 of rendering; method for displaying the object.
  public void display() {
    line(x1, y1, x2, y2);
    ellipseMode(CENTER);
    fill(0xffb6b6b6);
    circle(x2, y2, r);
  }
  
  //Part 2 of  rendering; method for updating the object, when user doesn't interact with program.
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

  //Method for determining collision between Player and a mineral object.
  public void grap(int mineralCollisionNumber, int mineralType) {
    score.calcMoney(mineralCollisionNumber, mineralType); //Invoke calcMoney() for the intersecting object to find amount of money to be added.

    //Iterate over all Stone objects;
    for (int i = 0; i < stones.size(); i++) {
      Stone sto = stones.get(i);
      if (mineralCollisionNumber == sto.n && mineralType == sto.type) {
        //Set the collided object to Player position;
        sto.x = x2;
        sto.y = y2;
          
        while (sto.y >= 70) { //Pull Player and collided object back to PLayer startposition;
          lineL -= lineIncrease;
          x2 = PApplet.parseInt(x1+cos(theta)*lineL);
          y2 = PApplet.parseInt(y1+sin(theta)*lineL);
          break;
        }
        if (sto.y < 70) { //When Stone object is pulled adequately back; inform user of which Stone has been caught, change caught variable to 'true' to remove from the ArrayList in main program, add the money, reset Player to start values.
          println("Stone; " + sto.n + " got caught!");
          stones.remove(mineralCollisionNumber);
          //sto.hasCaught();
          score.money += score.moneyAdd;
          //Reset of Player
          pReset();
          break;
        } else {
          continue;
        }
      }
    }

    //Iterate over all Gold objects;
    for (int i = 0; i < golds.size(); i++) {
      Gold gol = golds.get(i);
      if (mineralCollisionNumber == gol.n && mineralType == gol.type) {
        //Set the collided object to Player position;
        gol.x = x2;
        gol.y = y2;
        
        while (gol.y >= 70) { //Pull Player and collided object back to PLayer startposition;
          lineL -= lineIncrease;
          x2 = PApplet.parseInt(x1+cos(theta)*lineL);
          y2 = PApplet.parseInt(y1+sin(theta)*lineL);
          break;
        }
        if (gol.y < 70) { //When Gold object is pulled adequately back; inform user of which Gold has been caught, change hasCaught variable to 'true' to remove from the ArrayList in main program, add the money, reset Player to start values.
          println("Gold; " + gol.n + " got caught!");
          gol.hasCaught();
          score.money += score.moneyAdd;
          //Reset of Player
          pReset();
          break;
        } else {
          continue;
        }
      }
    }
  }

  //Method for translating keyboard input to boolean values to determine what the user wants to do.
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

  //Method for changing the PLayer object based on setmove() output; based on keyboard input from the user.
  public void movement() {
    if (isUp) {
       lineL -= lineIncrease;
     } else if (isDown) {
       thetaIncrease *= 0;
       lineL += lineIncrease;
     }
     //If user wants to reset Player or Player returns to startposition then set the Player to start values.
     if (reset || dist(x2, y2, x1, y1) < 20) {
       pReset();
     }
  }

  //Method for resetting the Player to start values.
  public void pReset() {
    x1 = 300;
    y1 = 50;
    theta = 0;
    thetaIncrease = 0.035f;
    lineL = 25;
    lineIncrease = 4;
    r = 10;
  }
}
class Score {
  
  int money;
  int x,y;
  int moneyAdd;
  
  //Constructor sets start values for position and money.
  Score(int xpos, int ypos) {
    x = xpos;
    y = ypos;
    money = 0;
  }
  
  //Method for rendering the score at top left of game window.
  public void display() {
    textAlign(LEFT, CENTER);
    fill(0xffFF79E7);
    textSize(28);
    text("Money: " + money, x, y);
  }

  //Method for calculating the amount of money to be added to money based on the specific caught objects properties.
  public int calcMoney(int mineralCollisionNumber, int mineralType) {
    if (mineralType == 2) {
      for (int i = 0; i < stones.size(); i++) {
        Stone sto = stones.get(mineralCollisionNumber);
        moneyAdd = PApplet.parseInt(sto.worth*sto.weight);
      }
    } else if (mineralType == 1) {
      for (int i = 0; i < golds.size(); i++) {
        Gold gol = golds.get(mineralCollisionNumber);
        moneyAdd = PApplet.parseInt(gol.worth*gol.weight);
      }
    }
    return moneyAdd;
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
