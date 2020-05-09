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
    thetaIncrease = 0.035;
    lineL = 25;
    lineIncrease = 4;
    r = 10;
  }
  
  //Part 1 of rendering; method for displaying the object.
  void display() {
    line(x1, y1, x2, y2);
    ellipseMode(CENTER);
    fill(0);
    circle(x2, y2, r);
  }
  
  //Part 2 of  rendering; method for updating the object, when user doesn't interact with program.
  void update() {
    theta += thetaIncrease;
    if (theta > PI || theta < 0) {
      thetaIncrease *= -1;
    }
    x2 = int(x1+cos(theta)*lineL);
    y2 = int(y1+sin(theta)*lineL);
    
    if (lineL < 0) {
      theta += thetaIncrease;
    }
  }

  //Method for determining collision between Player and a mineral object.
  void grap(int mineralCollisionNumber, int mineralType) {
    score.calcMoney(mineralCollisionNumber, mineralType); //Invoke calcMoney() for the intersecting object to find amount of mnoey to be added.

    //Iterate over all Stone objects;
    for (int i = 0; i < stones.size(); i++) {
      Stone sto = stones.get(i);
      if (mineralCollisionNumber == sto.n && mineralType == sto.type) {
          //Set the collided object to Player position;
          sto.x = x2;
          sto.y = y2;
          
          while (sto.y >= 70) { //Pull Player and collided object back to PLayer startposition;
            lineL -= lineIncrease;
            x2 = int(x1+cos(theta)*lineL);
            y2 = int(y1+sin(theta)*lineL);
            break;
          }
          if (sto.y < 70) { //When Stone object is pulled adequately back; inform user of which Stone has been caught, change hasCaught variable to 'true' to remove from the ArrayList in main program, add the money, reset Player to start values.
            println("Stone; " + sto.n + " got caught!");

            sto.hasCaught();

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
          x2 = int(x1+cos(theta)*lineL);
          y2 = int(y1+sin(theta)*lineL);
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
  boolean setMove(char k, boolean b) {
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
  void movement() {
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
  void pReset() {
    x1 = 300;
    y1 = 50;
    theta = 0;
    thetaIncrease = 0.035;
    lineL = 25;
    lineIncrease = 4;
    r = 10;
  }
}
