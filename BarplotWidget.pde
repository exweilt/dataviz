/**
  *  A GUI scatterplot widget.
  *
  *
  *  (c) Alexey added on 08/03/2025
  */
public class BarplotWidget extends Widget {
  private color bg = color(230, 230, 230, 255);
  private float width = 600.0f;
  private float height = 500.0f;
  private String[] categoriesX = {"Apple", "Banana", "Orange"};
  private float[] pointsY = {400, 70, 210};
  //public float scaleX = 8.0f; // n pixels per 1 x unit of graph
  public float scaleY = 1.0f;
  //public int stepX = 5;
  //public int stepY = 10;
  //public PVector topLeftPos = new PVector(-25, 125); // Coordinate position of the left top corner of plot
   color[] colors = {color(230, 10, 10), color(10, 20, 230), color(20, 210, 40)};

  public BarplotWidget(float x_in, float y_in) {
    this.x = x_in;
    this.y = y_in;
  }
  
  @Override
  public void draw() {
    fill(this.bg);
    noStroke();
    rect(this.x, this.y, this.width, this.height);
    
    float COLUMN_WIDTH = 70.0f;
    float COLUMN_PADDING = 30.0f;
    
    float bottomY = this.y + this.height - 60;
    textSize(12);
    for (int i = 0; i < this.categoriesX.length; i++) {
      float columnX = this.x + i * (COLUMN_WIDTH + COLUMN_PADDING) + 40.;
      
      fill(30);
      text(this.categoriesX[i], columnX, bottomY + 30.0);
      
      fill (colors[i % 3]); //<>//
      //circle(columnX, bottomY, 10);
      rect(columnX, bottomY, COLUMN_WIDTH, -this.pointsY[i] * this.scaleY);
    }
    
    fill(30);
    for (int tickY = 0; tickY <= 500; tickY += 50) {
      float yPos = bottomY - tickY * this.scaleY;
      text(tickY, this.x + 5., yPos);
      strokeWeight(1.0);
      stroke(150);
      //circle (this.x, yPos, 10);
      line(this.x, yPos, this.x + 400.0, yPos);
    }
    
    textAlign(LEFT);
    strokeWeight(1.0);
  }

  @Override
  public void onMouseClicked(int mX, int mY) {
    
  }
  
  @Override
  public void onMouseMoved(int mX, int mY) {
  
  }
  
  //public PVector plotToScreen(float pointX, float pointY) {
  //  float screenX = this.x + (pointX - this.topLeftPos.x) * this.scaleX;
  //  float screenY = this.y - (pointY - this.topLeftPos.y) * this.scaleY;
    
  //  return new PVector(screenX, screenY);
  //}
  
  public void setX(String[] categories) {
    this.categoriesX = categories;
  }
  
  public String[] getX() {
    return this.categoriesX;
  }

  public void setY(float[] new_points) {
    this.pointsY = new_points;
  }
  
  public float[] getY() {
    return this.pointsY;
  }
  
  //public float getMaxX() {
  //  return this.topLeftPos.x + this.width / this.scaleX;
  //}
  
  //public void setMaxX(float newMaxX) {
  //  this.scaleX = this.width / (newMaxX - getMinX());
  //}

  //public float getMinX() {
  //  return this.topLeftPos.x;
  //}
  
  //public void setMinX(float newMinX) {
  //  //float previousMinX = this.topLeftPos.x;
  //  float previousMaxX = getMaxX();
    
  //  this.topLeftPos.x = newMinX;
  //  this.scaleX = this.width / (previousMaxX - newMinX);
  //}
  
  //public float getMinY() {
  //  return this.topLeftPos.y - this.height / this.scaleY;
  //}
  
  //public void setMinY(float newMinY) {
  //  this.scaleY = this.height / (getMaxY() - newMinY);
  //}

  //public float getMaxY() {
  //  return this.topLeftPos.y;
  //}
  
  //public void setMaxY(float newMaxY) {
  //  //float previousMinX = this.topLeftPos.x;
  //  float previousMinY = getMinY();
    
  //  this.topLeftPos.y = newMaxY;
  //  this.scaleY = this.height / (newMaxY - previousMinY);
  //}
}
