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
  
 //Constructor sets start values for position,  
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
 void display() {
   imageMode(CENTER);
   image(sprite, x, y, radius, radius);
 }
 
 //Method for when the Player intersects with a Mineral object creates an array with the specific objects index number and type.
 int[] mineralCollision(float a, float b) {
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
  boolean hasCaught() {
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
    radius = int(random(10, 40));
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
    radius = int(random(15, 65));
    weight = radius*3;
    sprite = r_sprite;
    type = 2;
  }
}
