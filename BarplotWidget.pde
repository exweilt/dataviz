/**
  *  A GUI scatterplot widget.
  *
  *
  *  (c) Alexey added on 08/03/2025
  */
public class BarplotWidget extends Widget {
  private color bg = color(230, 230, 230, 255);
  float width;
  float height;
  private String[] categoriesX = {"Apple", "Banana", "Orange"};
  private float[] pointsY = {400., 70., 210.};
  //public float scaleX = 8.0f; // n pixels per 1 x unit of graph
  public float scaleY = 1.0f;
  //public int stepX = 5;
  //public int stepY = 10;
  //public PVector topLeftPos = new PVector(-25, 125); // Coordinate position of the left top corner of plot
   color[] colors = {color(230, 10, 10)};
    float COLUMN_WIDTH = 30.0f;
    float COLUMN_PADDING = 10.0f;
    
  public BarplotWidget(float x_in, float y_in) {
    this.x = x_in;
    this.y = y_in;
  }
  
  @Override
  public void draw() {

    fill(this.bg); //<>// //<>//
    noStroke();
    //textAlign(RIGHT);
    background(255);
    //rect(this.x, this.y, this.width, this.height);

    
    

    //this.scaleY = getWidth() 
    if (this.categoriesX.length >= 1) {
      //float bottomY = this.y + this.height - 60;
      textSize(12);
      for (int i = 0; i < this.categoriesX.length; i++) {
        //float columnX = this.x + i * (COLUMN_WIDTH + COLUMN_PADDING) + 40.;
        float yPos = this.y + i * (COLUMN_WIDTH + COLUMN_PADDING) + 40.;
        
        fill(30);
        text(this.categoriesX[i], this.x - 5, yPos + 15);
        
        fill (colors[i % this.colors.length]);
        rect(this.x + 150, yPos, this.pointsY[i] * this.scaleY, COLUMN_WIDTH);
      }
      
      float maxVal = StatisticFunctions.max(this.pointsY);
      int step = ((int)(maxVal/10) <= 0) ? 1 : ((int)(maxVal/10));
      float h = getHeight();

      
      fill(30);
      for (int tickX = 0; tickX <= (int)maxVal; tickX += step) {
        float xPos = this.x + tickX * this.scaleY + 150;
        text(tickX, xPos, this.y + 5.);
        strokeWeight(1.0);
        stroke(100, 100, 100, 100);
        //circle (this.x, yPos, 10);
        line(xPos, this.y, xPos, this.y + h);
      }
    }
    
    //textAlign(LEFT);
    strokeWeight(1.0);
  }

  @Override
  public boolean onMouseClicked(int mX, int mY) {
    return false;
  }
  
  @Override
  public void onMouseMoved(int mX, int mY) {
  
  }
  
  void updateScale() {
    //float w = currentClip.w;
    if (this.categoriesX.length >= 1) {
      this.scaleY = (width / StatisticFunctions.max(this.pointsY)) * 0.7;
    }
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
  
  public float getWidth() {
    float w = 0;
    
    if (this.categoriesX.length >= 1) {
      w = StatisticFunctions.max(this.pointsY) * scaleY;
    }
    
    return w + 200.;
  }
  
  public float getHeight() {
    return this.categoriesX.length * (COLUMN_WIDTH + COLUMN_PADDING) + 40.;
    //return data.getRowCount() * this.columnBaseHeight + 70.0;
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
