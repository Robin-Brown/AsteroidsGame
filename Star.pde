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
