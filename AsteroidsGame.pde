SpaceShip ship = new SpaceShip();
Star[] stars = new Star[500];
ArrayList <Asteroid> theList;
ArrayList <Bullet> bList;
int score = 0;
int health = 100;
int numAsteroids = 55;
boolean gameOver = false;
boolean winGame = false;
boolean spaceIsPressed = false;
boolean upIsPressed = false;
boolean downIsPressed = false;
boolean leftIsPressed = false;
boolean rightIsPressed = false;


public void setup() 
{
  size(1000, 650);

  for (int i = 0; i < stars.length; i++)
  {
    stars[i] = new Star();
  }

  theList = new ArrayList <Asteroid>();
  for(int i=0; i<55; i++)
  {
    theList.add(i,new Asteroid());
  }

  bList = new ArrayList <Bullet>();
}

public void draw() 
{
  if (gameOver == false && winGame == false){
  noStroke();
  background(0, 25, 50);

  for (int i = 0; i < stars.length; i++)
  {
    stars[i].show();
  }

  ship.move();
  
  ship.show();

  for (int nI = 0; nI < theList.size(); nI++)
  {
    theList.get(nI).move();
    theList.get(nI).show();
  }
   for (int nI = theList.size()-1; nI >= 0; nI--)
   {
     if (dist(ship.getX(), ship.getY(), theList.get(nI).getX(), theList.get(nI).getY()) < 30)
     {
       theList.remove(nI);
       health -= 10;
       numAsteroids -= 1;
     }
  }

  for (int bI = 0; bI < bList.size(); bI++)
  {
    bList.get(bI).move();
    bList.get(bI).show();
  }
  for (int nI = theList.size()-1; nI >= 0; nI--)
  {
    for (int bI = bList.size()-1; bI >= 0; bI--)
    {
      if (dist(bList.get(bI).getX(), bList.get(bI).getY(), theList.get(nI).getX(), theList.get(nI).getY()) < 30)
      {
        theList.remove(nI);
        bList.remove(bI);
        score += 10;
        numAsteroids -= 1;
        break;
      }
    }
  }

  fill(255);
  textSize(25);
  text("Score: " + score, 45, 55);
  text("Health: " + health, 815, 55);
  }
  if (health == 0)
  {
    gameOver = true;
  }
  if (gameOver == true)
  {
    fill(0, 25, 50);
    rect(-5, -5, 1005, 655);
    for (int i = 0; i < stars.length; i++)
    {
      
      stars[i].show();
    }
  
    fill(255);
    textSize(65);
    textAlign(CENTER);
    text("O H  N O", 500, 290);
    textSize(30);
    text("refresh to play again :)", 500, 370);
    fill(255);
    textSize(25);
    textAlign(LEFT);
    text("Score: " + score, 45, 55);
    text("Health: " + health, 815, 55);
  }
  if (numAsteroids == 0)
  {
    winGame = true;
  }
  if (winGame == true)
  {
    fill(0, 25, 50);
    rect(-5, -5, 1005, 655);
    for (int i = 0; i < stars.length; i++)
    {
     
      stars[i].show();
    }
   
    fill(255);
    textSize(65);
    textAlign(CENTER);
    text("Y A Y !", 500, 290);
    textSize(30);
    text("refresh to play again :D!", 500, 370);
    fill(255);
    textSize(25);
    textAlign(LEFT);
    text("Score: " + score, 45, 55);
    text("Health: " + health, 815, 55);
  }
}

///////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
class Star
{
  private int starX, starY; 
  private double starSize;
  public Star()
  {
    starX = (int)(Math.random()*1000);
    starY = (int)(Math.random()*650);
    starSize = (Math.random()+1);
  }
  public void show()
  {
    noStroke();
    fill(255);
    ellipse((float)starX, (float)starY, (float)starSize, (float)starSize);
  }
}
///////////////////////////////////////////////////////////////////////////////////////////////////////
class Asteroid extends Floater {

  private int rotSpeed;
  private int myRadius;

  Asteroid() {
    myColor = color(103, 115, 125);
    myCenterX = (int)(Math.random()*1000);
    myCenterY = (int)(Math.random()*650);
    myXspeed = ((Math.random()*2)-1);
    myYspeed = ((Math.random()*2)-1);
    myPointDirection = 0;
     rotSpeed = (int)(Math.random() * 4 - 2);

    corners = 6;
    int[] xS = { 6, 12,   6,  -6, -12, -6};
    int[] yS = {10,  0, -10, -10,   0, 10};
    xCorners = xS;
    yCorners = yS;
    myRadius = 10;
  }

  public void move() {
    turn(rotSpeed);

    //change the x and y coordinates by myXspeed and myYspeed       
    myCenterX += myXspeed;
    myCenterY += myYspeed;

    //wrap around screen
    if (myCenterX > width + myRadius) {
      myCenterX = -myRadius;
    }
    else if (myCenterX < -myRadius) {
      myCenterX = width + myRadius;    
    }
    if (myCenterY > height + myRadius) {
      myCenterY = -myRadius;
    }
    else if (myCenterY < -myRadius) {
      myCenterY = height + myRadius;
    }
  }

  public void setX(int x) {myCenterX = x;}
  public int  getX() {return (int)myCenterX;}
  public void setY(int y) {myCenterY = y;}
  public int  getY() {return (int)myCenterY;}
  public void   setDirectionX(double x) {myPointDirection = x;}
  public double getDirectionX() {return myXspeed;}
  public void   setDirectionY(double y) {myYspeed = y;}
  public double getDirectionY() {return myYspeed;}
  public void   setPointDirection(int degrees) {myPointDirection = degrees;}
  public double getPointDirection() {return myPointDirection;}
  public int getRadius() {return myRadius;}
}

//////////////////////////////////////////////////////////////////////////////////////////
class Bullet extends Floater
{
  public Bullet(SpaceShip theShip)
  {
    myCenterX = theShip.getX();
    myCenterY = theShip.getY();
    myPointDirection = theShip.getPointDirection();
    double dRadians = myPointDirection*(Math.PI/180);
    myXspeed = 5*Math.cos(dRadians) + theShip.myXspeed;
    myYspeed = 5*Math.sin(dRadians) + theShip.myYspeed;
    myColor = color(255);
  }
  public void setX(int x)  {myCenterX = x;}
  public int getX() {return (int)myCenterX;}
  public void setY(int y)  {myCenterY = y;}
  public int getY()  {return (int)myCenterY;}
  public void setDirectionX(double x)  {myXspeed = x;} 
  public double getDirectionX()  {return myXspeed;}
  public void setDirectionY(double y)  {myYspeed = y;}
  public double getDirectionY()  {return myYspeed;}
  public void setPointDirection(int degrees) {myPointDirection = degrees;}
  public double getPointDirection() {return myPointDirection;}
  public void show()
  {
    fill(myColor);   
    stroke(myColor);             
    ellipse((float)myCenterX, (float)myCenterY, 3, 3);
  }
  public void move()
  { 
    myCenterX += myXspeed;    
    myCenterY += myYspeed;
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////
class SpaceShip extends Floater  
{   
  public SpaceShip()
  {
    corners = 7;
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners[0] = -8;
    yCorners[0] = -14;
    xCorners[1] = -2;
    yCorners[1] = -6;
    xCorners[2] = -12;
    yCorners[2] = -2;
    xCorners[3] = -12;
    yCorners[3] = 2;
    xCorners[4] = -2;
    yCorners[4] = 6;
    xCorners[5] = -8;
    yCorners[5] = 14;
    xCorners[6] = 18;
    yCorners[6] = 0;
    myColor = color(255);
    myCenterX = 500;
    myCenterY = 325;
    myXspeed = 0;
    myYspeed = 0;
    myPointDirection = 0;
  }
  public void setX(int x)  {myCenterX = x;}
  public int getX() {return (int)myCenterX;}
  public void setY(int y)  {myCenterY = y;}
  public int getY()  {return (int)myCenterY;}
  public void setDirectionX(double x)  {myXspeed = x;} 
  public double getDirectionX()  {return myXspeed;}
  public void setDirectionY(double y)  {myYspeed = y;}
  public double getDirectionY()  {return myYspeed;}
  public void setPointDirection(int degrees) {myPointDirection = degrees;}
  public double getPointDirection() {return myPointDirection;}
  
  
  public void show()
  {
    fill(myColor);   
    stroke(255);           
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xturndTranslated, yturndTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      xturndTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yturndTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xturndTranslated,yturndTranslated);    
    }   
    endShape(CLOSE);  
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////
public void keyPressed()
{
if (key == 'h')
  {
    ship.setDirectionX(0);
    ship.setDirectionY(0);
    ship.setX((int)(Math.random()*1000));
    ship.setY((int)(Math.random()*650));
    ship.setPointDirection((int)(Math.random()*360));
    fill(255);
    rect(-5, -5, 1205, 805);

  }
  
  if (keyCode == LEFT)
  {
    leftIsPressed = true;
    
  }
  if (keyCode == RIGHT)
  {
    rightIsPressed = true;
    
  }
  if (keyCode == UP)
  {
    upIsPressed = true;
    
   
  }
  if (keyCode == DOWN)
  {
    downIsPressed = true;
    
    
  }
  if (key == ' ')
  {
    spaceIsPressed = true;
  }
  if (leftIsPressed == true)
  {
    ship.turn(-15);
  }
  if (rightIsPressed == true)
  {
    ship.turn(15);
  }
  if (upIsPressed == true)
  {
    ship.accelerate(0.5);
  }
  if (downIsPressed == true)
  {
    ship.accelerate(-0.5);
  }
  if (spaceIsPressed == true && leftIsPressed == true)
  {
    for(int i = 0; i < 1; i++)
    {
      bList.add(i, new Bullet(ship));
    }
  }
  if (spaceIsPressed == true && rightIsPressed == true)
  {
    for(int i = 0; i < 1; i++)
    {
      bList.add(i, new Bullet(ship));
    }
  }
  if (spaceIsPressed == true && upIsPressed == true)
  {
    for(int i = 0; i < 1; i++)
    {
      bList.add(i, new Bullet(ship));
    }
  }
  if (spaceIsPressed == true && downIsPressed == true)
  {
    for(int i = 0; i < 1; i++)
    {
      bList.add(i, new Bullet(ship));
    }
  }
  if (spaceIsPressed == true)
  {
    for(int i = 0; i < 1; i++)
    {
      bList.add(i, new Bullet(ship));
    }
  }

}

public void keyReleased()
{
  if (keyCode == LEFT)
  {
    leftIsPressed = false;
  }
  if (keyCode == RIGHT)
  {
    rightIsPressed = false;
  }
  if (keyCode == UP)
  {
    upIsPressed = false;
  }
  if (keyCode == DOWN)
  {
    downIsPressed = false;
  }
  if (key == ' ')
  {
    spaceIsPressed = false;
  }

}

//////////////////////////////////////////////////////////////////////////////////////////////////////////
class Floater //Do NOT modify the Floater class! Make changes in the Spaceship class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myXspeed, myYspeed; //holds the speed of travel in the x and y directions   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myXspeed += ((dAmount) * Math.cos(dRadians));    
    myYspeed += ((dAmount) * Math.sin(dRadians));       
  }   
  public void turn (double degreesOfRotation)   
  {     
    //turns the floater by a given number of degrees    
    myPointDirection+=degreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myXspeed and myYspeed       
    myCenterX += myXspeed;    
    myCenterY += myYspeed;     

    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    } 
    
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    
    //translate the (x,y) center of the ship to the correct position
    translate((float)myCenterX, (float)myCenterY);

    //convert degrees to radians for turn()     
    float dRadians = (float)(myPointDirection*(Math.PI/180));
    
    //turn so that the polygon will be drawn in the correct direction
    turn(dRadians);
    
    //draw the polygon
    beginShape();
    for (int nI = 0; nI < corners; nI++)
    {
      vertex(xCorners[nI], yCorners[nI]);
    }
    endShape(CLOSE);

    //"unturn" and "untranslate" in reverse order
    turn(-1*dRadians);
    translate(-1*(float)myCenterX, -1*(float)myCenterY);
  }   
} 
