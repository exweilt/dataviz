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
  private float[] pointsY = {400., 70., 210.};
  //public float scaleX = 8.0f; // n pixels per 1 x unit of graph
  public float scaleY = 1.0f;
  //public int stepX = 5;
  //public int stepY = 10;
  //public PVector topLeftPos = new PVector(-25, 125); // Coordinate position of the left top corner of plot
   color[] colors = {color(230, 10, 10)};

  public BarplotWidget(float x_in, float y_in) {
    this.x = x_in;
    this.y = y_in;
  }
  
  @Override
  public void draw() {
    tb.fill(this.bg);
    tb.noStroke();
    tb.textAlign(RIGHT);
    //rect(this.x, this.y, this.width, this.height);
    
    float COLUMN_WIDTH = 30.0f;
    float COLUMN_PADDING = 10.0f;
    
    //float bottomY = this.y + this.height - 60;
    tb.textSize(12);
    for (int i = 0; i < this.categoriesX.length; i++) {
      //float columnX = this.x + i * (COLUMN_WIDTH + COLUMN_PADDING) + 40.;
      float yPos = this.y + i * (COLUMN_WIDTH + COLUMN_PADDING) + 40.;
      
      tb.fill(30);
      tb.text(this.categoriesX[i], this.x - 5, yPos + 30.0);
      
      tb.fill (colors[i % this.colors.length]);
      tb.rect(this.x + 20., yPos, this.pointsY[i] * this.scaleY, COLUMN_WIDTH);
    }
    
    tb.fill(30);
    for (int tickX = 0; tickX <= 500; tickX += 50) {
      float xPos = this.x + tickX * this.scaleY;
      tb.text(tickX, xPos, this.y + 5.);
      tb.strokeWeight(1.0);
      tb.stroke(100, 100, 100, 100);
      //circle (this.x, yPos, 10);
      tb.line(xPos, this.y, xPos, this.y + 10000);
    }
    
    tb.textAlign(LEFT);
    tb.textAlign(LEFT);
    tb.strokeWeight(1.0);
  }

  @Override
  public boolean onMouseClicked(int mX, int mY) {
    return false;
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
  
  public void setCategoryValue(String cat, Float value) {
    for (int i = 0; i < this.categoriesX.length; i++) {
      if (this.categoriesX[i].equals(cat)) {
        this.pointsY[i] = value;
      }
    }
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
