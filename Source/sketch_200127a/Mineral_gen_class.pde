class Mineral {
  
  float worth;
  float weight;
  float x;
  float y;
  float radius;
  boolean grap;
  PImage sprite;
  PImage r_sprite = loadImage("rock.png");
  PImage g_sprite = loadImage("gold.png");

  
 Mineral(float xpos, float ypos) {
  
   x = xpos;
   y = ypos;
   worth = 0;
   weight = 0;
   radius = 0;
   
 }
 
 void display() {
   imageMode(CENTER);
   image(sprite, x, y, radius, radius);
 }
 
 boolean collision(float a, float b) {
        if (dist(a, b, x, y) < radius) {
          return grap = true;
        } else {
          return grap = false;
        }
    }
}

class Gold extends Mineral {
  
  Gold(float xpos, float ypos) {
    super(xpos, ypos);
    x = xpos;
    y = ypos;
    worth = weight*1.2;
    weight = radius*10;
    radius = random(10, 50);
    sprite = g_sprite;
  }
}

class Stone extends Mineral {
  
  Stone(float xpos, float ypos) {
    super(xpos, ypos);
    x = xpos;
    y = ypos;
    worth = weight*0.1;
    weight = radius*3;
    radius = random(10, 50);
    sprite = r_sprite;
  }
}
