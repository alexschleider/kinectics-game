public class MovingPlatform
{
  Vector3D pos;
  Vector3D vel;
  Vector3D startPos;
  Vector3D endPos;
  boolean horizontal;
  boolean movingRight;
  float speed;
 float floorWidth;
 float floorHeight;
 float timer = 0;
  float inX, inY, outX, outY;
  int floorType;
  int holdTime;
  boolean deletes;
  boolean isDead;
  boolean dir;
  float distance;
 
  public MovingPlatform (float _x, float _y, float _width, float _height, float _speed, int _time, float _distance, boolean _horizontal, boolean _dir, int _floorType, boolean _deletes)
 {
 pos = new Vector3D(_x, _y);
 horizontal = _horizontal;
 if(horizontal) endPos = new Vector3D (pos.x + _distance, pos.y);
 else endPos = new Vector3D (pos.x, pos.y + _distance);
 startPos = pos.copy();
 dir = _dir;
 movingRight = dir;
 speed = _speed;
 holdTime = _time;
 floorWidth = _width;
 floorHeight = _height;
  inX = _x;
 inY = _y;
 outX = inX + _width;
 outY = inY;
 floorType = _floorType;
 if (!dir) pos = endPos.copy();
 deletes = _deletes;
 isDead = !deletes;
 }
 
  public MovingPlatform(XMLElement platformNode)
  {
    float tempX = platformNode.getFloatAttribute("posX");
    float tempY = platformNode.getFloatAttribute("posY");
    this.pos = new Vector3D(tempX, tempY);
    this.horizontal = convertInt(platformNode.getIntAttribute("horizontal"));
    this.distance = platformNode.getFloatAttribute("distance");
    if(horizontal) endPos = new Vector3D (pos.x + distance, pos.y);
    else endPos = new Vector3D (pos.x, pos.y + distance);
    startPos = pos.copy();
    this.movingRight = convertInt(platformNode.getIntAttribute("dir"));
    this.speed = platformNode.getFloatAttribute("speed");
    this.holdTime = platformNode.getIntAttribute("holdTime");
    this.floorWidth = platformNode.getFloatAttribute("floorWidth");
    this.floorHeight = platformNode.getFloatAttribute("floorHeight");
    inX = pos.x;
    inY = pos.y;
    outX = inX + floorWidth;
    outY = inY;
    this.floorType = platformNode.getIntAttribute("floorType");
    if (!movingRight) pos = endPos.copy();
    this.deletes = convertInt(platformNode.getIntAttribute("deletes"));
    isDead = !deletes;
  }
 
 public void draw()
 {
  if (!isDead)
   {
   fill(60, 200);
   stroke(200, 150);
   rectMode(CORNER);
   rect(pos.x, pos.y, floorWidth, floorHeight);
   update();
   } else {
     
   inX = 0;
 inY = 0;
 outX = 0;
 outY = 0;
     
   }
 }
  
  public void update()
  {
    if (horizontal)
    {
    if (movingRight) 
    {
      if(pos.x >= endPos.x) 
      {
        pos.x = endPos.x;
      timer++;
      vel = new Vector3D (0, 0);
    } else{
      vel = new Vector3D (speed, 0);
    }
     } else {
       if(pos.x <= startPos.x) 
      {
        pos.x = startPos.x;
      timer++;
      vel = new Vector3D (0, 0);
    } else{
      vel = new Vector3D (speed * -1, 0);
    }
     }
    } else {
      if (movingRight) 
      {
        if(pos.y >= endPos.y) 
      {
        pos.y = endPos.y;
      timer++;
      vel = new Vector3D (0, 0);
    } else{
      vel = new Vector3D (0, speed);
    }
      } else {
        if(pos.y <= startPos.y) 
      {
        pos.y = startPos.y;
      timer++;
      vel = new Vector3D (0, 0);
    } else{
      vel = new Vector3D (0, speed * -1);
    }
      }
    }
    if (timer == holdTime)
    {
     movingRight = !movingRight;
    timer = 0; 
    }
    pos.add(vel);
    inX = pos.x;
 inY = pos.y;
 outX = inX + floorWidth;
 outY = inY;
    
  }
  
}
