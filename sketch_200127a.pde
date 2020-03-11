Stone[] stones = new Stone[5];
Gold[] golds = new Gold[5];
Player player = new Player(300,50);

PImage back;
float score = 0;


void settings() {
  size(600,600);
}

void setup() {
  back = loadImage("soil.png");
  background(back);
  //Tegner mineraler
  for (int i = 0; i < stones.length; i++) {
    stones[i] = new Stone(random(width),random(150, height));
  }
  
  for (int j = 0; j < golds.length; j++) {
    golds[j] = new Gold(random(width),random(150, height));
  }

}

void draw() {
  background(back);
  
  player.display();
  player.update();
  player.movement();
    
  
  for (int i = 0; i < stones.length; i++) {
    for (int j = 0; j < golds.length; j++) {
      
      //Tjekker om nogle overlapper, hvis der er tildel nye pladser til objekterne
      if (dist(stones[i].x,stones[i].y,golds[j].x,golds[j].y) < stones[i].radius+golds[j].radius) {
        regen();
      } else if (dist(stones[i].x,stones[i].y,golds[j].x,golds[j].y) < golds[j].radius+stones[i].radius) {
        regen();
      } else { //Hvis ikke overlap, så tegn.
        stones[i].display();
        golds[j].display();
        
        player.grap(stones[i].x, stones[i].y);
        player.grap(golds[j].x, golds[j].y);
      }
    }
  }
  
  
}

//Nye objekter
void regen() {
  for (int i = 0; i < stones.length; i++) {
    stones[i] = new Stone(random(width),random(150, height));
  }
  
  for (int j = 0; j < golds.length; j++) {
    golds[j] = new Gold(random(width),random(150, height));
  }  
}

void keyPressed() {
  player.setMove(key, true);
}

void keyReleased() {
  player.setMove(key, false);
}
