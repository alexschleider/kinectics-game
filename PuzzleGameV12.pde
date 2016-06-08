import noc.*;
import proxml.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
PFont font48;
Walker myWalkers;
ArrayList myWalkersList;
Wall myWalls;
ArrayList myWallsList;
Floor myFloors;
ArrayList myFloorsList;
Chooser myChoosers;
ArrayList myChoosersList;
OtherObjects myObjects;
ArrayList myObjectsList;
Jumper myJumpers;
ArrayList myJumpersList;
Booster myBoosters;
ArrayList myBoostersList;
Slower mySlowers;
ArrayList mySlowersList;
MovingPlatform myPlatforms;
ArrayList myPlatformsList;
Goal myGoal;
int gameLevel = 1;
boolean mouseIsDragging = false;
boolean levelFinished = false;
float score;
float bonusScore = 500;
boolean scoreChanged = false;
boolean buttonJustHit;
int gameState = 1;
Hashtable            soundHash = new Hashtable();

Vector3D gpos;
float gradius = 4;
float gmultiplier = 1;
boolean gexpanding;
float gwalkerWidth = 20;
float gwalkerHeight = 30;
float gDegrees = 0;
float gdog = 0.01;
float gspeed = 15;
float gfriction = 0;
boolean gblink = true;
float gwaitTime = 150;
float gOffsetX;
float gOffsetY;

PImage Background;
PImage backgroundFront;
String lText;


void setup()
{
  Minim.start(this);
  size(640, 480);
  smooth();
  font48 = loadFont ("HelveticaNeue-Bold-48.vlw");
  textFont(font48);
  myWallsList = new ArrayList();
  myFloorsList = new ArrayList();
  myWalkersList = new ArrayList();
  myChoosersList = new ArrayList();
  myObjectsList = new ArrayList();
  myJumpersList = new ArrayList();
  myBoostersList = new ArrayList();
  myPlatformsList = new ArrayList();
  mySlowersList = new ArrayList();
  drawLevel();
  Background = loadImage("background.png");
  backgroundFront = loadImage("backgroundfront.png");
  loadSound("jump.wav");
  loadSound("warp.wav");
  loadSound("boost.wav");
  loadSound("collide.wav");
  loadSound("slowerStart.mp3");
  loadSound("slowerEnd.mp3");
  loadSound("levelEnd.wav");
  loadSound("switch.wav");
  gpos = new Vector3D(-50, 300);
}

void draw()
{
  Walker w = (Walker)myWalkersList.get(0);
  gOffsetX = width / 3 - w.pos.x;
  gOffsetY = height / 3 - w.pos.y;
  
  println(gOffsetX + ", " + gOffsetY);
  switch(gameState)
  {
  case 1:
    background(200);
    textFont(font48);
    textSize(20);
    textAlign(CENTER);
    text("Press Any Key To Begin...", width/2, height/3);
    textSize(40);
    text("KINETICS", width/2, height/5);
    pushMatrix();
    translate(-gpos.x, -gpos.y);
    scale(2);
    ellipseMode(CENTER);
    strokeWeight(2);
    fill(100, 80, 80, 200);
    stroke(100, 225);
    line(gpos.x, gpos.y - gwalkerHeight * .5, gpos.x, gpos.y - gwalkerHeight * .5 - 15);
    rectMode(CENTER);
    rect(gpos.x, gpos.y, gwalkerWidth, gwalkerHeight);
    ellipseMode(CENTER);
    if (gblink)
    {
      fill(80, 0, 0, 100);
      stroke(255, 200, 200, 100);
    } 
    else {
      fill(255, 0, 0, 100);
      stroke(255, 200, 200, 100);
    }
    ellipse(gpos.x + .5, gpos.y - gwalkerHeight * .5 - 15, gradius * 2, gradius * 2);
    noStroke();
    ellipse(gpos.x + .5, gpos.y - gwalkerHeight * .5 - 15, gradius * 1.6, gradius * 1.6);
    ellipse(gpos.x + .5, gpos.y - gwalkerHeight * .5 - 15, gradius * 1, gradius * 1);
    ellipse(gpos.x + .5, gpos.y - gwalkerHeight * .5 - 15, gradius * .6, gradius * .6);
    fill(0, 150);
    stroke(128, 175);
    pushMatrix();
    translate(gpos.x/2 + .5, gpos.y/2 + 8);
    scale(.5);
    pushMatrix();
    translate(gpos.x - 12, gpos.y + gwalkerHeight * .5);
    rotate(gdog);
    ellipse(0, 0, gradius * gmultiplier * 3, gradius * gmultiplier * 3);
    ellipse(0, 0, gradius * gmultiplier * 2, gradius * gmultiplier * 2);
    ellipse(0, 0, gradius/(gmultiplier*2), gradius/(gmultiplier*2));
    ellipse(0, 0, gradius/(gmultiplier*3), gradius/(gmultiplier*3));
    ellipse(0, 0, gradius * 2.5, gradius / 2);
    popMatrix();

    pushMatrix();
    translate(gpos.x, gpos.y + gwalkerHeight * .5);
    rotate(gdog);
    ellipse(0, 0, gradius * gmultiplier * 3, gradius * gmultiplier * 3);
    ellipse(0, 0, gradius * gmultiplier * 2, gradius * gmultiplier * 2);
    ellipse(0, 0, gradius/(gmultiplier*2), gradius/(gmultiplier*2));
    ellipse(0, 0, gradius/(gmultiplier*3), gradius/(gmultiplier*3));
    ellipse(0, 0, gradius * 2.5, gradius / 2);
    popMatrix();

    pushMatrix();
    translate(gpos.x + 12, gpos.y + gwalkerHeight * .5);
    rotate(gdog);
    ellipse(0, 0, gradius * gmultiplier * 3, gradius * gmultiplier * 3);
    ellipse(0, 0, gradius * gmultiplier * 2, gradius * gmultiplier * 2);
    ellipse(0, 0, gradius/(gmultiplier*2), gradius/(gmultiplier*2));
    ellipse(0, 0, gradius/(gmultiplier*3), gradius/(gmultiplier*3));
    ellipse(0, 0, gradius * 2.5, gradius / 2);
    popMatrix();
    popMatrix();
    strokeWeight(1);
    popMatrix();
    introAnimate();
    break;

  case 2:
    if(!levelFinished)
    {
      //background(128);
      image(Background, 0 ,0);
      pushMatrix();
      scale(1.5);
      translate(gOffsetX, gOffsetY);
      myGoal.draw();
      if (!scoreChanged) bonusScore--;
      scoreChanged = !scoreChanged;
      if (bonusScore <= 0) bonusScore = 0;

      for(int i=0; i<myFloorsList.size(); i++) 
      {
        Floor b = (Floor)myFloorsList.get(i);
        b.draw();
      }
      for(int i=0; i<myWallsList.size(); i++) 
      {
        Wall b = (Wall)myWallsList.get(i);
        b.draw();
      }
      for(int i=0; i<myPlatformsList.size(); i++) 
      {
        MovingPlatform b = (MovingPlatform)myPlatformsList.get(i);
        b.draw();
      }
      for(int i=0; i<myObjectsList.size(); i++)
      {
        OtherObjects b = (OtherObjects)myObjectsList.get(i);
        b.draw();
      }

      for(int i=0; i<myWalkersList.size(); i++)
      {
        Walker b = (Walker)myWalkersList.get(i);
        b.draw();
      }
      popMatrix();
    }
    
    image(backgroundFront, 0 ,0);
    levelText();
    fill(0);
    noStroke();
    textAlign(LEFT);
    textSize(12);
    text("Level", 175, 30);
    text("Bonus", 325, 30);
    text("Score", 475, 30);
    textAlign(CENTER);
    textSize(20);
    text(gameLevel, 192, 53);
    text(int(bonusScore), 342, 53);
    text(int(score), 492, 53);
    
    if (!levelFinished)
    {
      for(int i=0; i<myChoosersList.size(); i++) 
      {
        Chooser b = (Chooser)myChoosersList.get(i);
        b.draw();
      }
      pushMatrix();
      scale(1.5);
      translate(gOffsetX, gOffsetY);
      for(int i=0; i<myBoostersList.size(); i++)
      {
        Booster b = (Booster)myBoostersList.get(i);
        b.draw();
      }
      for(int i=0; i<mySlowersList.size(); i++)
      {
        Slower b = (Slower)mySlowersList.get(i);
        b.draw();
      }
      for(int i=0; i<myJumpersList.size(); i++)
      {
        Jumper b = (Jumper)myJumpersList.get(i);
        b.draw();
      }
      checkProgress();
      popMatrix();
    }
    break;

  case 3:
    background(200);
    textFont(font48);
    stroke(0, 200);
    fill(0, 200);
    textAlign(CENTER);
    textSize(70);
    text("The End", width/2, height/2);
    break;
  }
}

public void introAnimate()
{
  gdog+=gspeed;
  gspeed -= gfriction;
  gfriction += .05;
  gpos.x +=1;
  if (gspeed <= 0)
  {
    gspeed = 15;
    gfriction = 0;
    gdog = 0;
  }
  gwaitTime -=1;
  if (gwaitTime <= 0) 
  {
    gblink = !gblink;
    if (gblink) gwaitTime = 150;
    else gwaitTime = 10;
  }

  if(gpos.x >= 800) gpos.x = - 100;
}

public void drawLevel()
{

  XMLInOut xmlIO = new XMLInOut(this);
  XMLElement root = xmlIO.loadElementFrom(gameLevel+".xml");

  myChoosersList.clear();
  myFloorsList.clear();
  myPlatformsList.clear();
  myObjectsList.clear();
  myWalkersList.clear();
  myWallsList.clear();
  myGoal = null;

  for(int i=0; i<root.countChildren(); i++)
  {
    XMLElement node = root.getChild(i);
    println(node.getName());

    if(node.getName().equals("chooser"))
      myChoosersList.add(new Chooser(node));
    else if(node.getName().equals("floor"))
      myFloorsList.add(new Floor(node));
    else if(node.getName().equals("platform"))
      myPlatformsList.add(new MovingPlatform(node));
    else if(node.getName().equals("switch"))
      myObjectsList.add(new OtherObjects(node));
    else if(node.getName().equals("walker"))
      myWalkersList.add(new Walker(node));
    else if(node.getName().equals("wall"))
      myWallsList.add(new Wall(node));
    else if(node.getName().equals("goal"))
      myGoal = new Goal(node);
  }
}

public void checkProgress()
{
  for(int i=0; i<myObjectsList.size(); i++)
  {
    OtherObjects b = (OtherObjects)myObjectsList.get(i);
    for(int x=1; x<30; x++)
    {
      if (b.hitTest(x, false))
      {
        for(int j=0; j<myFloorsList.size(); j++)
        {
          Floor bd = (Floor)myFloorsList.get(j);
          if (bd.floorType == x) 
          {
            bd.isDead = !bd.isDead;
          }
        }
        for(int j=0; j<myWallsList.size(); j++)
        {
          Wall bd = (Wall)myWallsList.get(j);
          if (bd.wallType == x) 
          {
            bd.isDead = !bd.isDead;
          }
        }
        for(int j=0; j<myPlatformsList.size(); j++)
        {
          MovingPlatform bd = (MovingPlatform)myPlatformsList.get(j);
          if (bd.floorType == x) 
          {
            bd.isDead = !bd.isDead;
          }
        }
      }



    }
  }
  //Check Goal Collision
  if (myGoal.hitTest()) 
  {
    finishedLevel();
    playSound("levelEnd.wav");
  }

}

public void finishedLevel()
{
  gameLevel++;
  levelText();
  gameLevel--;
  pushMatrix();
  scale(1/1.5);
  stroke(255, 200);
  fill(0, 200);
  rect(350, 225, 350, 250);
  textSize(40);
  textAlign(CENTER);
  fill(255);
  text("Level " + gameLevel + " Cleared", 355, 160);
  textSize(18);
  text("Click to continue...", 355, 190);
  textSize(17);
  text("Up Next Is " + lText, 355, 250);
  popMatrix();
  score = score + 1025 * gameLevel;
  score = score + bonusScore;
  levelText();
  if(gameLevel >= 14) 
  {
    gameState = 3;
    gameLevel = 1;
    score = 0;
  } 
  else {
    levelFinished = true;
  }
}

public void mousePressed() {

  for(int i=0; i<myJumpersList.size(); i++) {
    Jumper dc = (Jumper)myJumpersList.get(i);
    dc.mousePressed();
  }

  for(int i=0; i<myBoostersList.size(); i++) {
    Booster dc = (Booster)myBoostersList.get(i);
    dc.mousePressed();
  }

  for(int i=0; i<mySlowersList.size(); i++) {
    Slower dc = (Slower)mySlowersList.get(i);
    dc.mousePressed();
  }

  for(int i=0; i<myChoosersList.size(); i++) {
    Chooser dc = (Chooser)myChoosersList.get(i);
    if(dc.hitDetect(mouseX, mouseY - 10) == true ) 
    {
      if(dc.amount > 0)
      {
        if(dc.chooserType == 1) 
        {
          myJumpersList.add( new Jumper( dc.pos.x, dc.pos.y) );
          dc.amount--;
        }
      }

    }
    if(dc.slowerHitDetect(mouseX, mouseY) == true ) 
    {
      if(dc.amount > 0)
      {
        if(dc.chooserType == 3) 
        {
          mySlowersList.add( new Slower( dc.pos.x, dc.pos.y) );
          dc.amount --;
        }
      }

    }
    if(dc.boosterHitTest(mouseX, mouseY) == true ) 
    {
      if(dc.amount > 0)
      {
        if(dc.chooserType == 2) 
        {
          myBoostersList.add( new Booster( dc.pos.x, dc.pos.y) );
          dc.amount --;
        }
      }

    }
  }
  if (levelFinished == true)
  {
    //Remove Items on Screen
    myJumpersList.clear();
    myBoostersList.clear();
    mySlowersList.clear();
    //Change Level
    levelFinished = false;
    gameLevel++;
    bonusPoints();
    drawLevel();
  }
}

public void mouseReleased() 
{
  switch(gameState)
  {
  case 1:
    gameState++;
    break;

  case 2:
    for(int i=0; i<myWalkersList.size(); i++) {
      Walker dc = (Walker)myWalkersList.get(i);
      dc.mouseReleased();
    }

    for(int i=0; i<myJumpersList.size(); i++) {
      Jumper dc = (Jumper)myJumpersList.get(i);
      dc.mouseReleased();
    }

    for(int i=0; i<myBoostersList.size(); i++) {
      Booster dc = (Booster)myBoostersList.get(i);
      dc.mouseReleased();
    }

    for(int i=0; i<mySlowersList.size(); i++) {
      Slower dc = (Slower)mySlowersList.get(i);
      dc.mouseReleased();
    }

    for(int i=0; i<myChoosersList.size(); i++) {
      Chooser dc = (Chooser)myChoosersList.get(i);
      dc.mouseReleased();
    }
    break;

  case 3:
    gameState = 1;
    break;
  }
}


public void keyReleased()
{
  switch(gameState)
  {
  case 1:
    gameState++;
    break;

  case 2:
    
  if (keyCode == LEFT) 
     {
     levelFinished = true;
     gameLevel -=2;
     mousePressed();
     }
     
     if (keyCode == RIGHT) 
     {
     levelFinished = true;
     mousePressed();
     }
     
    break;

  case 3:
    gameState = 1;
    break;
  }
}

protected void loadSound(String fileName)
{
  AudioSnippet snippet = Minim.loadSnippet(fileName);
  soundHash.put(fileName, snippet);
}

protected void playSound(String fileName)
{
  AudioSnippet snippet = (AudioSnippet)soundHash.get(fileName);
  snippet.rewind();
  snippet.play();
}

protected void loopSound(String fileName)
{
  AudioSnippet snippet = (AudioSnippet)soundHash.get(fileName);
  snippet.rewind();
  snippet.loop();
}

protected void stopSound(String fileName)
{
  AudioSnippet snippet = (AudioSnippet)soundHash.get(fileName);
  snippet.pause();
  snippet.rewind();
}


public boolean convertInt(int _test)
{
  if (_test == 1) return true;
  else return false;
}

//Collision Detection
//Walker-Wall Detection
Vector3D lineIntersectionWalkerWall(Walker walker, Wall l1) {
  if(!walker.walkingRight) return lineIntersection(walker.pos.x - walker.walkerWidth * .5, walker.pos.y - walker.walkerHeight * .5, walker.pos.x + walker.walkerWidth * .5, walker.pos.y + walker.walkerHeight * .5, l1.inX + l1.wallWidth, l1.inY, l1.outX + l1.wallWidth, l1.outY);
  else return lineIntersection(walker.pos.x - walker.walkerWidth * .5, walker.pos.y - walker.walkerHeight * .5, walker.pos.x + walker.walkerWidth * .5, walker.pos.y + walker.walkerHeight * .5, l1.inX, l1.inY, l1.outX, l1.outY);
}
//Walker-Floor Detection
Vector3D lineIntersectionWalkerFloor(Walker walker, Floor l1) {
  return lineIntersection(walker.pos.x - walker.walkerWidth *.5, walker.pos.y - walker.walkerHeight * .5, walker.pos.x + walker.walkerWidth * .5, walker.pos.y + walker.walkerHeight * .5, l1.inX, l1.inY, l1.outX, l1.outY);
}
//Walker-FloorBottom Detection
Vector3D lineIntersectionWalkerFloorBottom(Walker walker, Floor l1) {
  return lineIntersection(walker.pos.x - walker.walkerWidth *.5, walker.pos.y - walker.walkerHeight * .5, walker.pos.x + walker.walkerWidth * .5, walker.pos.y + walker.walkerHeight * .5, l1.inX, l1.inY + l1.floorHeight, l1.outX, l1.outY + l1.floorHeight);
}
//Walker-Platform Detection
Vector3D lineIntersectionWalkerPlatform(Walker walker, MovingPlatform l1) {
  return lineIntersection(walker.pos.x - walker.walkerWidth *.5, walker.pos.y - walker.walkerHeight * .5, walker.pos.x + walker.walkerWidth * .5, walker.pos.y + walker.walkerHeight * .5, l1.inX, l1.inY, l1.outX, l1.outY);
}
//Walker-PlatformBottom Detection
Vector3D lineIntersectionWalkerPlatformBottom(Walker walker, MovingPlatform l1) {
  return lineIntersection(walker.pos.x - walker.walkerWidth *.5, walker.pos.y - walker.walkerHeight * .5, walker.pos.x + walker.walkerWidth * .5, walker.pos.y + walker.walkerHeight * .5, l1.inX, l1.inY + l1.floorHeight, l1.outX, l1.outY + l1.floorHeight);
}
//Walker-Walker Detection
Vector3D lineIntersectionWalkerWalker(Walker walker1, Walker walker2) {
  return lineIntersection(walker1.pos.x - walker1.walkerWidth * .5, walker1.pos.y - walker1.walkerHeight * .5, walker1.pos.x + walker1.walkerWidth * .5, walker1.pos.y + walker1.walkerHeight * .5, walker2.pos.x - walker2.walkerWidth, walker2.pos.y, walker2.pos.x + walker2.walkerWidth, walker2.pos.y);
}
//Jumper-Floor Detection
Vector3D lineIntersectionJumperFloor(Jumper jumper, Floor l1) {
  return lineIntersection(jumper.pos.x - jumper.jumperWidth *.5, jumper.pos.y - jumper.jumperHeight * .5, jumper.pos.x + jumper.jumperWidth * .5, jumper.pos.y + jumper.jumperHeight * .5, l1.inX, l1.inY, l1.outX, l1.outY);
}
//Jumper-Platform Detection
Vector3D lineIntersectionJumperPlatform(Jumper jumper, MovingPlatform l1) {
  return lineIntersection(jumper.pos.x - jumper.jumperWidth *.5, jumper.pos.y - jumper.jumperHeight * .5, jumper.pos.x + jumper.jumperWidth * .5, jumper.pos.y + jumper.jumperHeight * .5, l1.inX, l1.inY, l1.outX, l1.outY);
}
//Jumper-Walker Detection
Vector3D lineIntersectionJumperWalker(Jumper walker1, Walker walker2) {
  return lineIntersection(walker1.pos.x - walker1.jumperWidth * .5, walker1.pos.y - walker1.jumperHeight * .5, walker1.pos.x + walker1.jumperWidth * .5, walker1.pos.y + walker1.jumperHeight * .5, walker2.pos.x - walker2.walkerWidth, walker2.pos.y, walker2.pos.x + walker2.walkerWidth, walker2.pos.y);
}
//Booster-Floor Detection
Vector3D lineIntersectionBoosterFloor(Booster booster, Floor l1) {
  return lineIntersection(booster.pos.x - booster.boosterWidth *.5, booster.pos.y - booster.boosterHeight * .5, booster.pos.x + booster.boosterWidth * .5, booster.pos.y + booster.boosterHeight * .5, l1.inX, l1.inY, l1.outX, l1.outY);
}
//Booster-Platform Detection
Vector3D lineIntersectionBoosterPlatform(Booster booster, MovingPlatform l1) {
  return lineIntersection(booster.pos.x - booster.boosterWidth *.5, booster.pos.y - booster.boosterHeight * .5, booster.pos.x + booster.boosterWidth * .5, booster.pos.y + booster.boosterHeight * .5, l1.inX, l1.inY, l1.outX, l1.outY);
}
//Booster-Walker Detection
Vector3D lineIntersectionBoosterWalker(Booster walker1, Walker walker2) {
  return lineIntersection(walker1.pos.x - walker1.boosterWidth * .5, walker1.pos.y - walker1.boosterHeight * .5, walker1.pos.x + walker1.boosterWidth * .5, walker1.pos.y + walker1.boosterHeight * .5, walker2.pos.x - walker2.walkerWidth, walker2.pos.y, walker2.pos.x + walker2.walkerWidth, walker2.pos.y);
}
//Slower-Floor Detection
Vector3D lineIntersectionSlowerFloor(Slower slower, Floor l1) {
  return lineIntersection(slower.pos.x - slower.slowerWidth *.5, slower.pos.y - slower.slowerHeight * .5, slower.pos.x + slower.slowerWidth * .5, slower.pos.y + slower.slowerHeight * .5, l1.inX, l1.inY, l1.outX, l1.outY);
}
//Slower-Platform Detection
Vector3D lineIntersectionSlowerPlatform(Slower slower, MovingPlatform l1) {
  return lineIntersection(slower.pos.x - slower.slowerWidth *.5, slower.pos.y - slower.slowerHeight * .5, slower.pos.x + slower.slowerWidth * .5, slower.pos.y + slower.slowerHeight * .5, l1.inX, l1.inY, l1.outX, l1.outY);
}
//Slower-Walker Detection
Vector3D lineIntersectionSlowerWalker(Slower walker1, Walker walker2) {
  return lineIntersection(walker1.pos.x - walker1.slowerWidth * .5, walker1.pos.y - walker1.slowerHeight * .5, walker1.pos.x + walker1.slowerWidth * .5, walker1.pos.y + walker1.slowerHeight * .5, walker2.pos.x - walker2.walkerWidth, walker2.pos.y, walker2.pos.x + walker2.walkerWidth, walker2.pos.y);
}


Vector3D lineIntersection( float l1_inX, float l1_inY, float l1_outX, float l1_outY,
float l2_inX, float l2_inY, float l2_outX, float l2_outY)
{
  float denom = ((l1_outY - l1_inY)*(l2_outX - l2_inX)) -
    ((l1_outX - l1_inX)*(l2_outY - l2_inY));

  float nume_a = ((l1_outX - l1_inX)*(l2_inY - l1_inY)) - 
    ((l1_outY - l1_inY)*(l2_inX - l1_inX));

  float nume_b = ((l2_outX - l2_inX)*(l2_inY - l1_inY)) -
    ((l2_outY - l2_inY)*(l2_inX - l1_inX));

  if(denom == 0.0)
  {
    if(nume_a == 0.0 && nume_b == 0.0)
    {
      //println("COINCIDENT");
    }
    else
    {
      //println("PARALLEL");
    }
  }

  float ua = nume_a / denom;
  float ub = nume_b / denom;

  if(ua >= 0.0f && ua <= 1.0f && ub >= 0.0f && ub <= 1.0f)
  {
    //println("intersection ua: " + ua + " ub: " + ub);
    float intersectionX = l2_inX + ua*(l2_outX - l2_inX);
    float intersectionY = l2_inY + ua*(l2_outY - l2_inY);

    return new Vector3D(intersectionX, intersectionY);
  }
  else
  {
    return null;
  }
}
