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
    thetaIncrease = 0.035;
    lineL = 25;
    lineIncrease = 4;
    r = 10;
  }
  
  void display() {
    line(x1, y1, x2, y2);
    ellipseMode(CENTER);
    fill(0);
    circle(x2, y2, r);
  }
  
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

  void grap(int mineralCollisionNumber) {
    
    for (int i = 0; i < stones.length; i++) {
      for (int j = 0; j < golds.length; j++) {
        if (mineralCollisionNumber == stones[i].n) {
          if (stones[mineralCollisionNumber].type == "stone") {
            stones[mineralCollisionNumber].x = x2;
            stones[mineralCollisionNumber].y = y2;
            //thetaIncrease *= 0;
            while (stones[mineralCollisionNumber].y >= 70) {
              lineL -= lineIncrease;
              x2 = int(x1+cos(theta)*lineL);
              y2 = int(y1+sin(theta)*lineL);
              //break;
            }
            if (stones[i].y < 70) {
              print("Stone; " + stones[i].n + "got caught!");
              stones[mineralCollisionNumber].x = 0;
              stones[mineralCollisionNumber].y = 0;
            }
          }
        } else {
          continue;
        }
        
        if (mineralCollisionNumber == golds[j].n) {
          if (golds[mineralCollisionNumber].type == "gold") {
            golds[mineralCollisionNumber].x = x2;
            golds[mineralCollisionNumber].y = y2;
            //thetaIncrease *= 0;
            while (golds[mineralCollisionNumber].y >= 70) {
              lineL -= lineIncrease;
              x2 = int(x1+cos(theta)*lineL);
              y2 = int(y1+sin(theta)*lineL);
            }
            if (golds[mineralCollisionNumber].y < 70) {
              print("Gold; " + golds[mineralCollisionNumber].n + "got caught!");
              golds[mineralCollisionNumber].x = 0;
              golds[mineralCollisionNumber].y = 0;
             
            }
          }
        } else {
          continue;
        }
      }
    }
  }

  
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

  void movement() {
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
       thetaIncrease = 0.035;
       lineL = 25;
       lineIncrease = 4;
       r = 10;
     }
  }
  
}
