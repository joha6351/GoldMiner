class Score {
  
  float money;
  int x,y;
  
  Score(int xpos, int ypos) {
    x = xpos;
    y = ypos;
    money = 0;
  }
  
  void display() {
    textAlign(LEFT, CENTER);
    fill(#FF79E7);
    textSize(28);
    text("Money: " + money, x, y);
  }

  float calcMoney(int mineralCollisionNumber, int mineralType) {
    if (mineralType == 1 && stones[mineralCollisionNumber].y < 70) {
      money = money + (stones[mineralCollisionNumber].worth * stones[mineralCollisionNumber].weight);
    } else if (mineralType == 2 && golds[mineralCollisionNumber].y < 70) {
      money = money + (golds[mineralCollisionNumber].worth * golds[mineralCollisionNumber].weight);  
    }
    return money;
  }
  

}
