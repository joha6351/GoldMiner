class Score {
  
  int money;
  int x,y;
  int moneyAdd;
  
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

  int calcMoney(int mineralCollisionNumber, int mineralType) {
    if (mineralType == 1) {
      moneyAdd = int(stones[mineralCollisionNumber].worth*stones[mineralCollisionNumber].weight);
    } else if (mineralType == 2) {
      moneyAdd = int(golds[mineralCollisionNumber].worth*golds[mineralCollisionNumber].weight);  
    }
    return moneyAdd;
  }
  

}
