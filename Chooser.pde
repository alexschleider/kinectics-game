public class Chooser
{
 Vector3D pos;
 int chooserType;
 int amount;
 boolean isClicked = true;
 float chooserWidth;
 float chooserHeight;
 float rboosterWidth = 60;
 float rboosterHeight = 10;
 float radius = 4;
 float dog = 0.01;
float speed = 15;
float friction = 0;
float multiplier = 1;
float baseHeight = 5;
float baseWidth = 30;
float expandAmount = -1;
 
 final static int JUMPER = 1;
 final static int BOOSTER = 2;
 final static int SLOWER = 3;
 
 public Chooser(float _x, float _y, int _type, int _amount)
{
 pos = new Vector3D(_x, _y);
 chooserType = _type;
 amount = _amount;
} 

public Chooser(XMLElement chooserNode)
  {
    float tempX = chooserNode.getFloatAttribute("posX");
    float tempY = chooserNode.getFloatAttribute("posY");
    this.pos = new Vector3D(tempX, tempY);
    this.chooserType = chooserNode.getIntAttribute("chooserType");
    this.amount = chooserNode.getIntAttribute("amount");
  }
  
  public void draw()
  {
    textAlign(LEFT);
    switch(chooserType)
    {
      case JUMPER:
      if (amount == 0)
      {
        fill(200);
        stroke(100);
      } else {
      if (hitDetect(mouseX, mouseY - 10))
    {
    stroke(255, 255, 0, 128);
    fill(100, 100, 0, 80);
    } else {
    stroke(0, 128);
    fill(128, 80);
    }
  }
    float offsetY = .5;
    ellipse(pos.x, pos.y + 10, radius * 4, radius);
    ellipse(pos.x, pos.y - offsetY * 1 + 10, radius * 8, radius);
    ellipse(pos.x, pos.y - offsetY * 2 + 10, radius * 8, radius);
    ellipse(pos.x, pos.y - offsetY * 3 + 10, radius * 8, radius);
    ellipse(pos.x, pos.y - offsetY * 4 + 10, radius * 8, radius);
    ellipse(pos.x, pos.y - offsetY * 5 + 10, radius * 8, radius);
    ellipse(pos.x, pos.y - offsetY * 6 + 10, radius * 8, radius);
    ellipse(pos.x, pos.y - offsetY * 7 + 10, radius * 8, radius);
      
      
      fill(0);
      noStroke();
      textSize(12);
      textAlign(LEFT);
      text("x" + amount, pos.x + radius * 4 + 2, pos.y + radius + 10);
      break;
      
      case BOOSTER:
      pushMatrix();
      translate(14, 30);
      scale(.8, .8);
       ellipseMode(CENTER);
    strokeWeight(2);
    if (amount == 0)
      {
        fill(100);
        stroke(200);
      } else {
      fill(255);
      stroke(0);
      
    if(boosterHitTest(mouseX, mouseY))
    {
    fill(160, 160, 0, 200);
    stroke(200, 200, 0, 225);
    } else{
    fill(160, 200);
    stroke(200, 225);
 }
    }
    rectMode(CENTER);
    rect(pos.x, pos.y, rboosterWidth, rboosterHeight);
    if (boosterHitTest(mouseX, mouseY) && amount != 0)
    {
    fill(100, 100, 0, 150);
    stroke(180, 180, 0, 175);
    } else {
    fill(0, 150);
    stroke(128, 175);
    }
    pushMatrix();
    translate(pos.x - 24, pos.y - 5);
    rotate(dog);
    ellipse(0, 0, radius * multiplier * 3, radius * multiplier * 3);
    ellipse(0, 0, radius * multiplier * 2, radius * multiplier * 2);
    ellipse(0, 0, radius/(multiplier*2), radius/(multiplier*2));
    ellipse(0, 0, radius/(multiplier*3), radius/(multiplier*3));
    ellipse(0, 0, radius * 2.5, radius / 2);
    popMatrix();
    
    pushMatrix();
    translate(pos.x - 12, pos.y - 5);
    rotate(dog);
    ellipse(0, 0, radius * multiplier * 3, radius * multiplier * 3);
    ellipse(0, 0, radius * multiplier * 2, radius * multiplier * 2);
    ellipse(0, 0, radius/(multiplier*2), radius/(multiplier*2));
    ellipse(0, 0, radius/(multiplier*3), radius/(multiplier*3));
    ellipse(0, 0, radius * 2.5, radius / 2);
    popMatrix();
    
    pushMatrix();
    translate(pos.x, pos.y - 5);
    rotate(dog);
    ellipse(0, 0, radius * multiplier * 3, radius * multiplier * 3);
    ellipse(0, 0, radius * multiplier * 2, radius * multiplier * 2);
    ellipse(0, 0, radius/(multiplier*2), radius/(multiplier*2));
    ellipse(0, 0, radius/(multiplier*3), radius/(multiplier*3));
    ellipse(0, 0, radius * 2.5, radius / 2);
    popMatrix();
    
    pushMatrix();
    translate(pos.x + 12, pos.y - 5);
    rotate(dog);
    ellipse(0, 0, radius * multiplier * 3, radius * multiplier * 3);
    ellipse(0, 0, radius * multiplier * 2, radius * multiplier * 2);
    ellipse(0, 0, radius/(multiplier*2), radius/(multiplier*2));
    ellipse(0, 0, radius/(multiplier*3), radius/(multiplier*3));
    ellipse(0, 0, radius * 2.5, radius / 2);
    popMatrix();
    
    pushMatrix();
    translate(pos.x + 24, pos.y - 5);
    rotate(dog);
    ellipse(0, 0, radius * multiplier * 3, radius * multiplier * 3);
    ellipse(0, 0, radius * multiplier * 2, radius * multiplier * 2);
    ellipse(0, 0, radius/(multiplier*2), radius/(multiplier*2));
    ellipse(0, 0, radius/(multiplier*3), radius/(multiplier*3));
    ellipse(0, 0, radius * 2.5, radius / 2);
    popMatrix();
      popMatrix();
    strokeWeight(1);
      textFont(font48);
      fill(0);
      noStroke();
      textSize(12);
      textAlign(LEFT);
      text("x" + amount, pos.x + rboosterWidth * .2 + 5, pos.y + rboosterWidth * .3 + 8);
      break;
      
    
    
    case SLOWER:
      
       pushMatrix();
    translate(pos.x, pos.y);
    strokeWeight(2);
    rectMode(CENTER);
      if (amount == 0)
      {
        fill(200);
        stroke(100);
      } else {
      fill(255);
      stroke(0);
      
    if(hitDetect(mouseX,mouseY))
    {
    stroke(100, 100, 0, 200);
    fill(100, 100, 200);
    } else {
    stroke(0, 200);
    fill(0, 200);
    }
  }
    rect(0, 7, baseWidth, baseHeight);
    strokeWeight(2);
    line(-baseWidth/2, 5, -baseWidth/2, expandAmount);
    line(baseWidth/2, 5, baseWidth/2, expandAmount);
      if (amount == 0)
      {
        fill(200);
        stroke(100);
      } else {
      
    if (hitDetect (mouseX, mouseY))
    {
    stroke(100, 100, 0, 150);
    fill(150, 150, 0, 100);
    } else {
    stroke(0, 50, 100, 150);
    fill(0, 50, 150, 100);
    }
      }
    rect(0, expandAmount/2, baseWidth, expandAmount);
    strokeWeight(1);
    popMatrix();
      
      
      fill(0);
      noStroke();
      textSize(12);
      textAlign(LEFT);
      text("x" + amount, pos.x + baseWidth * .5 + 5, pos.y + baseHeight * 2);
      break;
    
    }
    
    
  }
  public boolean hitDetect(float theX, float theY) {
    float d = dist(pos.x, pos.y, theX, theY);
    if(d < radius * 2 ) return true;
    else return false;
  }
  
  public boolean boosterHitTest(float theX, float theY) {
    if(theX >= pos.x - 60 * .5 && theX <= pos.x + 60 * .5 && theY >= pos.y - 10 * .5 && theY <= pos.y + 10 * .5) return true;
    else return false;
  }
  
  public boolean slowerHitDetect(float theX, float theY) {
    if(theX >= pos.x - baseWidth * .5 && theX <= pos.x + baseWidth * .5 && theY >= pos.y - baseHeight * .5 && theY <= pos.y + baseHeight * .5) return true;
    else return false;
  }
  
  public void mouseReleased()
  {
   isClicked = false; 
  }
  
}
