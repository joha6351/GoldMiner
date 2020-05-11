class Score {
  
  int money;
  int x,y;
  int moneyAdd;
  
  //Constructor sets start values for position and money.
  Score(int xpos, int ypos) {
    x = xpos;
    y = ypos;
    money = 0;
  }
  
  //Method for rendering the score at top left of game window.
  void display() {
    textAlign(LEFT, CENTER);
    fill(#FF79E7);
    textSize(28);
    text("Money: " + money, x, y);
  }

  //Method for calculating the amount of money to be added to money based on the specific caught objects properties.
  int calcMoney(int mineralCollisionNumber, int mineralType) {
    if (mineralType == 2) {
      for (int i = stones.size()-1; i >= 0; i--) {
        Stone sto = stones.get(i);
        moneyAdd = int(sto.worth*sto.weight);
      }
    } else if (mineralType == 1) {
      for (int i = golds.size()-1; i >= 0; i--) {
        Gold gol = golds.get(i);
        moneyAdd = int(gol.worth*gol.weight);
      }
    }
    return moneyAdd;
  }
}
