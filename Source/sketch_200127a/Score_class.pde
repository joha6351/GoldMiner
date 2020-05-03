class Score {
  
  float money;
  int x,y;
  float moneyAdd;
  
  Score(int xpos, int ypos) {
    x = xpos;
    y = ypos;
    money = 0.0;
  }
  
  void display() {
    textAlign(LEFT, CENTER);
    fill(#FF79E7);
    textSize(28);
    text("Money: " + money, x, y);
  }

  float calcMoney(int mineralCollisionNumber, int mineralType) {
    if (mineralType == 1) {
      moneyAdd = (stones[mineralCollisionNumber].worth * stones[mineralCollisionNumber].weight);
    } else if (mineralType == 2) {
      moneyAdd = (golds[mineralCollisionNumber].worth * golds[mineralCollisionNumber].weight);  
    }
    return moneyAdd;
  }

  void addMoney (float addedMoney) {
    money = money + addedMoney;
  }
  

}
