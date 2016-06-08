public class Wall
{
 Vector3D pos;
 float wallWidth;
 float wallHeight;
 float inX, inY, outX, outY;
 float wallType;
 boolean invisible;
  int copyNumber;
  PImage wallPattern;
  boolean deletes;
  boolean isDead;
 
 public Wall (float _x, float _y, float _width, float _height, int _wallType, boolean _deletes) 
 {
 pos = new Vector3D(_x, _y);
 wallWidth = _width;
 wallHeight = _height;
 inX = _x;
 inY = _y;
 outX = inX;
 outY = inY + _height;
 wallType = _wallType;
 invisible = false;
 wallPattern = loadImage("texture.png");
 deletes = _deletes;
 isDead = !deletes;
 }
 
  public Wall (float _x, float _y, float _width, float _height, int _wallType, boolean _deletes, boolean _invisible) 
 {
 pos = new Vector3D(_x, _y);
 wallWidth = _width;
 wallHeight = _height;
 inX = _x;
 inY = _y;
 outX = inX;
 outY = inY + _height;
 wallType = _wallType;
 invisible = _invisible;
 deletes = _deletes;
 isDead = !deletes;
 }
 
 public Wall(XMLElement wallNode)
  {
    float tempX = wallNode.getFloatAttribute("posX");
    float tempY = wallNode.getFloatAttribute("posY");
    this.pos = new Vector3D(tempX, tempY);
    this.wallWidth = wallNode.getFloatAttribute("wallWidth");
    this.wallHeight = wallNode.getFloatAttribute("wallHeight");
    this.wallType = wallNode.getFloatAttribute("wallType");
    this.deletes = convertInt(wallNode.getIntAttribute("deletes"));
    this.invisible = convertInt(wallNode.getIntAttribute("invisible"));
    isDead = !deletes;
 wallPattern = loadImage("texture.png");
  }
 
 public void draw()
 {
   if (!isDead)
   {
   if (!invisible)
   {
   /*copyNumber = int(wallHeight / 15);
   for(int i=0; i<copyNumber; i++)
   {
     image(wallPattern, pos.x, pos.y + i * 15);
   }
   image(wallPattern, pos.x, pos.y + wallHeight - 15);
   */
   
   rectMode(CENTER);
   noStroke();
   fill(50, 250);
   rect(pos.x + wallWidth * .5, pos.y + wallHeight * .5, wallWidth, wallHeight);
   }
 inX = pos.x;
 inY = pos.y;
 outX = inX;
 outY = inY + wallHeight;
   } else {
     
   inX = 0;
 inY = 0;
 outX = 0;
 outY = 0;
     
   }
 }
  
}
