public class Floor
{
  Vector3D pos;
 float floorWidth;
 float floorHeight;
  float inX, inY, outX, outY;
  int floorType;
  boolean invisible;
  int copyNumber;
  PImage floorPattern;
  boolean deletes;
  boolean isDead;
 
  public Floor (float _x, float _y, float _width, float _height, int _floorType, boolean _deletes)
 {
 pos = new Vector3D(_x, _y);
 floorWidth = _width;
 floorHeight = _height;
  inX = _x;
 inY = _y;
 outX = inX + _width;
 outY = inY;
 floorType = _floorType;
 invisible = false;
 floorPattern = loadImage("texture.png");
 deletes = _deletes;
 isDead = !deletes;
 }
 
 public Floor (float _x, float _y, float _width, float _height, int _floorType, boolean _deletes, boolean _invisible)
 {
 pos = new Vector3D(_x, _y);
 floorWidth = _width;
 floorHeight = _height;
  inX = _x;
 inY = _y;
 outX = inX + _width;
 outY = inY;
 floorType = _floorType;
 invisible = _invisible;
 deletes = _deletes;
 isDead = !deletes;
 }
 
  public Floor(XMLElement floorNode)
  {
    float tempX= floorNode.getFloatAttribute("posX");
    float tempY = floorNode.getFloatAttribute("posY");
    this.pos = new Vector3D(tempX, tempY);
    this.floorWidth = floorNode.getFloatAttribute("floorWidth");
    this.floorHeight = floorNode.getFloatAttribute("floorHeight");
    this.floorType = floorNode.getIntAttribute("floorType");
    this.deletes = convertInt(floorNode.getIntAttribute("deletes"));
    this.invisible = convertInt(floorNode.getIntAttribute("invisible"));
    isDead = !deletes;
 floorPattern = loadImage("texture.png");
  }
 
 public void draw()
 {
   if(!isDead)
   {
   if (!invisible)
   {
   /*copyNumber = int(floorWidth / 15);
   for(int i=0; i<copyNumber; i++)
   {
     image(floorPattern, pos.x + i * 15, pos.y);
   }
   image(floorPattern, pos.x + floorWidth - 15, pos.y);*/
   rectMode(CENTER);
   noStroke();
   fill(50, 250);
   rect(pos.x + floorWidth * .5, pos.y + floorHeight * .5, floorWidth, floorHeight);
   }
   inX = pos.x;
 inY = pos.y;
 outX = inX + floorWidth;
 outY = inY;
   } else {
     
   inX = 0;
 inY = 0;
 outX = 0;
 outY = 0;
   }
 }
  
  
}
