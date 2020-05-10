//Declare an ArrayList with Stone and Gold objects.
ArrayList<Stone> stones = new ArrayList<Stone>();
ArrayList<Gold> golds = new ArrayList<Gold>();

//Declare a Player object.
Player player = new Player(300,50);

//Declare a Score object.
Score score = new Score(10, 10);

PImage bgimage;
boolean setupphase;

//Sets program windowsize to 600x600 px.
void settings() {
  size(600,600);
}

//Runs setup on the program. Loading and setting background image. Adds the specific Stone and Gold objects to the ArrayList.
void setup() {
  bgimage = loadImage("../sprites/soil.jpg");
  background(bgimage);

  setupphase = true;

  //Adds minerals to ArrayList
  stones.add(new Stone(int(random(width)), int(random(150, 350)), 0));
  stones.add(new Stone(int(random(width)), int(random(150, 350)), 1));
  stones.add(new Stone(int(random(width)), int(random(150, 350)), 2));
  stones.add(new Stone(int(random(width)), int(random(150, 350)), 3));
  stones.add(new Stone(int(random(width)), int(random(150, 350)), 4));
  
  golds.add(new Gold(int(random(width)), int(random(300, height)), 0));
  golds.add(new Gold(int(random(width)), int(random(300, height)), 1));
  golds.add(new Gold(int(random(width)), int(random(300, height)), 2));
  golds.add(new Gold(int(random(width)), int(random(300, height)), 3));
  golds.add(new Gold(int(random(width)), int(random(300, height)), 4));
  
}

//Main program loop
void draw() {
  
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

  //4. Iterate over all the Stone and Gold objects to invoke rendering methods and invoking Player grap method for all Stone and Gold objects.
  for (int i = 0; i < stones.size(); i++) {
    for (int j = 0; j < golds.size(); j++) {
      Stone sto = stones.get(i);
      sto.display();
      player.grap(sto.mineralCollision(player.x2, player.y2)[0],sto.mineralCollision(player.x2, player.y2)[1]); //mineralCollisonNumber[0] = number in array, mineralCollisonNumber[1] = type
      Gold gol = golds.get(j);
      gol.display();
      player.grap(gol.mineralCollision(player.x2, player.y2)[0], gol.mineralCollision(player.x2, player.y2)[1]); //mineralCollisonNumber[0] = number in array, mineralCollisonNumber[1] = type
    }
  }  
    
  //5. Iterate over all Stone and Gold objects to check if they should be removed from ArrayList, because they were caught.
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
  }

  //Ending loop;
  //When the user has caught all minerals > show ending screen; final score and instruction for restarting.
  if (stones.size()+golds.size() == 0) {
    background(0);
    textAlign(CENTER, CENTER);
    fill(#FFFFFF);
    textSize(32);
    text("You earned: " + score.money + " this game.", width/2, height/2);
    textSize(26);
    text("Press 'q' to restart", width/2, height/2+36);
  }
}

//Function for replacing Stone and Gold obejcts. Using ArrayList.set instead of ArrayList.add to replace existing ArrayList values.
void regen() {
  for (int i = 0; i < stones.size(); i++) {
    Stone sto = stones.get(i);
    stones.set(i, new Stone(int(random(width)), int(random(150, height)), i));
  }
  for (int j = 0; j < golds.size(); j++) {
    Gold gol = golds.get(j);
    golds.set(j, new Gold(int(random(width)), int(random(150, height)), j));
  }
}

//Function for checking if intersectiong between 2 objects.
boolean overlap(float p1x, float p1y, float p2x, float p2y, float p1r, float p2r) {
  if (dist(p1x, p1y, p2x, p2y) < p1r + p2r) {
    return true;
  } else {
    return false;
  }
}

//Registers if a key is pressed and sends it to Player object.
void keyPressed() {
  player.setMove(key, true);
}

//Registers if a key is released and sends it to Player object.
void keyReleased() {
  player.setMove(key, false);
}