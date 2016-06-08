public class Goal
{
  Vector3D pos;
 float radius = 20;
 float cradius = 20;
 boolean expanding;
 float waitTime;
 boolean timerOn;
 
  public Goal (float _x, float _y)
 {
 pos = new Vector3D(_x, _y);
 }
 
 public Goal(XMLElement goalNode)
  {
    float tempX = goalNode.getFloatAttribute("posX");
    float tempY = goalNode.getFloatAttribute("posY");
    this.pos = new Vector3D(tempX, tempY);
  }
 
 public void draw()
 {
   fill(150, 0, 200, 100);
   stroke(200, 255, 200, 100);
   ellipseMode(CENTER);
   ellipse(pos.x, pos.y, cradius, cradius);
   noStroke();
   ellipse(pos.x, pos.y, cradius * .8, cradius * .8);
   ellipse(pos.x, pos.y, cradius * .5, cradius * .5);
   ellipse(pos.x, pos.y, cradius * .3, cradius * .3);
   update();
   if (timerOn) updateTime();
 }
 
 public void update()
 {
   if (expanding) cradius += .2;
   if (!expanding) cradius -= .2;
   if (cradius <= 10) 
   {
     if(!timerOn) {
       waitTime = 0;
     timerOn = true;
     }
     if (timerOn) cradius = 10;
   }
   if (cradius >= 20) 
   {
     if(!timerOn) {
       waitTime = 100;
     timerOn = true;
     }
     if (timerOn) cradius = 20;
   }
   
   
   
   
 }
 
 public void updateTime()
 {
   waitTime -=1;
   if (waitTime <= 0) 
   {
     expanding = !expanding;
     timerOn = false;
   }
 }
  
  public boolean hitTest()
  {
   
   for(int i=0; i<myWalkersList.size(); i++)
  {
    Walker b = (Walker)myWalkersList.get(i);
    if( pos.x <= b.pos.x + 1 && pos.x >= b.pos.x - 1)
    {
      if(  pos.y <= b.pos.y + 1 && pos.y >= b.pos.y - 1)
      {
        return true;
      }
    }
  }
    return false;
  }
  
}
