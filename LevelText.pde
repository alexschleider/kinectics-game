public void levelText()
{
  textFont(font48);
  textSize(20);
  fill(0);
  noStroke();
  textAlign(LEFT);
 switch(gameLevel)
{
 case 1:
 lText = new String("Level 1: Jump The Wall");
 break;
 
 case 2:
 lText = new String("Level 2: Leap Of Faith");
 break;
 
 case 3:
 lText = new String("Level 3: Wall Jumps Will Work");
 break;
 
 case 4:
 lText = new String("Level 4: Fastest Fingers");
 break;
 
 case 5:
 lText = new String("Level 5: Lets Slow Things Down");
 break;
 
 case 6:
 lText = new String("Level 6: Take A Ride");
 break;
 
 case 7:
 lText = new String("Level 7: Lets Speed Things Up");
 break;
 
 case 8:
 lText = new String("Level 8: And Now Together");
 break;
 
 case 9:
 lText = new String("Level 9: Back And Forth");
 break;
 
 case 10:
 lText = new String("Level 10: The Fastest Jump");
 break;
 
 case 11:
 lText = new String("Level 11: Not So Easy");
 break;
 
 case 12:
 lText = new String("Level 12: Hazy Maze");
 break;
 
 case 13:
 lText = new String("Level 13: No More Floor");
 break;
 
 case 14:
 lText = new String("Level 14: Practice Make Perfect");
 break;
 
 case 15:
 
 break;
} 
text(lText, 110, 455);
}

public void bonusPoints()
{
  switch(gameLevel)
  {
  case 1:
bonusScore = 500;
 break;
 
 case 2:
  bonusScore = 500;
 break;
 
 case 3:
  bonusScore = 1000;
 break;
 
 case 4:
  bonusScore = 1000;
 
 break;
 
 case 5:
  bonusScore = 1500;
 break;
 
 case 6:
  bonusScore = 1500;
 break;
 
 case 7:
  bonusScore = 2000;
 break;
 
 case 8:
  bonusScore = 2000;
 break;
 
 case 9:
  bonusScore = 2500;
 break;
 
 case 10:
  bonusScore = 2500;
 break;
 
 case 11:
  bonusScore = 3000;
 break;
 
 case 12:
  bonusScore = 3000;
 break;
 
 case 13:
  bonusScore = 3500;
 break;
 
 case 14:
  bonusScore = 5000;
 break;
 
 case 15:
 
 break;
  }
}
