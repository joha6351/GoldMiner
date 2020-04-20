Stone[] stones = new Stone[5];
Gold[] golds = new Gold[5];
Player player = new Player(300,50);

PImage back;
float score = 0;
boolean setupphase = true;


void settings() {
  size(600,600);
}

void setup() {
  back = loadImage("../sprites/soil.png");
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
  
  while (setupphase) {
    for (int i = 0; i < stones.length; i++) {
      for (int j = 0; j < golds.length; j++) {
      
      //Tjekker om nogle overlapper, hvis der er tildel nye pladser til objekterne
        if (overlap(stones[i].x, stones[i].y, golds[j].x, golds[j].y, stones[i].radius, golds[j].radius)) {
          regen();
        } else if (overlap(golds[j].x, golds[j].y, stones[i].x, stones[i].y, golds[j].radius, stones[i].radius)) {
          regen();
        }
      }
    }
    setupphase = false;
    break;
  }
  
  if (player.restart == true) {
    setup();
  }
  
  background(back);
  
  player.display();
  player.update();
  player.movement();
    
  
  for (int i = 0; i < stones.length; i++) {
    for (int j = 0; j < golds.length; j++) {
        stones[i].display();
        golds[j].display();
        
        player.grap(stones[i].x, stones[i].y);
        player.grap(golds[j].x, golds[j].y);
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

boolean overlap(float p1x, float p1y, float p2x, float p2y, float p1r, float p2r) {
  if (dist(p1x, p1y, p2x, p2y) < p1r + p2r) {
    return true;
  } else {
    return false;
  }
}

void keyPressed() {
  player.setMove(key, true);
}

void keyReleased() {
  player.setMove(key, false);
}
