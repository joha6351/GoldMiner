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
 
 void display() {
   imageMode(CENTER);
   image(sprite, x, y, radius, radius);
 }
 
 int[] mineralCollision(float a, float b) {
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
    worth = 1.2;
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
    worth = 0.1;
    weight = radius*3;
    radius = random(10, 50);
    sprite = r_sprite;
    type = 2;
  }
}
