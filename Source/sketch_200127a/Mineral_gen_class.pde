class Mineral {
  
  float worth;
  float weight;
  int x;
  int y;
  float radius;
  PImage sprite;
  int n;
  String type;
  
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
 
 int mineralCollision(float a, float b) {
        if (dist(a, b, x, y) < radius) {
          return n;
        } else {
          return 100;
        }
    } 
}

class Gold extends Mineral {
  
  PImage g_sprite = loadImage("../sprites/gold.png");
  
  Gold(int xpos, int ypos, int numberInArray) {
    super(xpos, ypos, numberInArray);
    x = xpos;
    y = ypos;
    worth = weight*1.2;
    weight = radius*10;
    radius = random(10, 50);
    sprite = g_sprite;
    type = "gold";
  }
}

class Stone extends Mineral {
  
  PImage r_sprite = loadImage("../sprites/rock.png");
  
  Stone(int xpos, int ypos, int numberInArray) {
    super(xpos, ypos, numberInArray);
    x = xpos;
    y = ypos;
    worth = weight*0.1;
    weight = radius*3;
    radius = random(10, 50);
    sprite = r_sprite;
    type = "stone";
  }
}
