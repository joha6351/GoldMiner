class Player {
  
  float x1, y1, x2, y2;
  boolean isUp, isDown, reset, restart;
  float theta;
  float thetaIncrease;
  float lineL;
  int lineIncrease;
  float r;
  
  
  Player(float xpos, float ypos) {
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
    x2 = x1+cos(theta)*lineL;
    y2 = y1+sin(theta)*lineL;
    
    if (lineL < 0) {
      theta += thetaIncrease;
    }
    
  }

  void grap(float a, float b) {
    for (int i = 0; i < stones.length; i++) {
      for (int j = 0; j < golds.length; j++) {
        while (dist(a, b, x2, y2) < stones[i].radius) {
          stones[i].x = x2;
          stones[i].y = y2;
          thetaIncrease *= 0;
          lineL -= lineIncrease;
          break;
        } 
        while (dist(a, b, x2, y2) < golds[j].radius) {
          golds[j].x = x2;
          golds[j].y = y2;
          thetaIncrease *= 0;
          lineL -= lineIncrease;
          break;
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
