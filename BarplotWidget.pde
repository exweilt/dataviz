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
  public float scaleY = 1.0f;
   color[] colors = {color(230, 10, 10)};
    float COLUMN_WIDTH = 30.0f;
    float COLUMN_PADDING = 10.0f;
    
  public BarplotWidget(float x_in, float y_in) {
    this.x = x_in;
    this.y = y_in;
  }
  
  @Override  // Draws the columns to the screen
  public void draw() {
    fill(this.bg); //<>// //<>//
    noStroke();
    background(255);

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
  
  void updateScale() { // Updates the scale dynamically
    //float w = currentClip.w;
    if (this.categoriesX.length >= 1) {
      this.scaleY = (width / StatisticFunctions.max(this.pointsY)) * 0.7;
    }
  }
  
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
  
  // Sets the category values
  public void setCategoryValue(String cat, Float value) {
    for (int i = 0; i < this.categoriesX.length; i++) {
      if (this.categoriesX[i].equals(cat)) {
        this.pointsY[i] = value;
      }
    }
  }
  
  // Sets the width of the bar plot
  public float getWidth() {
    float w = 0;
    if (this.categoriesX.length >= 1) {
      w = StatisticFunctions.max(this.pointsY) * scaleY;
    }
    
    return w + 200.;
  }
  
  public float getHeight() {
    return this.categoriesX.length * (COLUMN_WIDTH + COLUMN_PADDING) + 40.;
  }

}
