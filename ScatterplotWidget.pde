/**
  *  A GUI scatterplot widget.
  *
  *
  *  (c) Alexey added on 08/03/2025
  */
public class ScatterplotWidget extends Widget {
  private color bg = color(230, 230, 230, 255);
  private color markerColor = color(255, 200, 10, 255);
  private float markerRadius = 4.0f;
  private float width = 300.0f;
  private float height = 300.0f;
  private float[] pointsX = {2.0, 4.0, 4.5, 5.0, 9.0, 9.0, 23.5, 25.0};
  private float[] pointsY = {10.0, 30.0, 28.5, 43.0, 70.0, 49.0, 129.5, 135.0};
  public float scaleX = 8.0f; // n pixels per 1 x unit of graph
  public float scaleY = 1.5f; // n pixels per 1 y unit of graph
  public int stepX = 5;
  public int stepY = 10;
  public PVector topLeftPos = new PVector(-25, 125); // Coordinate position of the left top corner of plot
  
  public String text_x;
  public String text_y;
  
  final private static float TICK_RADIUS = 2.0;
  final private static float TICK_WEIGHT = 3.0;
  final private static float TICK_TEXT_OFFSET = 8.0;

  public ScatterplotWidget(float x_in, float y_in, String text_x, String text_y) {
    this.x = x_in;
    this.y = y_in;
    
    this.text_x = text_x;
    this.text_y = text_y;
    
    setMinX(-5.0);
    setMaxX(30.0);
    setMinY(-10.0);
    setMaxY(200.0);
  }
  
  @Override
  public void draw() {
    fill(this.bg);
    noStroke();
    rect(this.x, this.y, this.width, this.height);
    
    // Prepare to Draw axis
    stroke(10);
    strokeWeight(TICK_WEIGHT);
    fill(10);
    //circle(plotToScreen(0,0).x, plotToScreen(0,0).y, 10);
    textAlign(CENTER);
    textSize(10);
    
    //Draw X axis
    PVector from = plotToScreen(getMinX(), 0);
    PVector to = plotToScreen(getMaxX(), 0);
    line(from.x, from.y, to.x, to.y);
    triangle(to.x, to.y, to.x - 10.0, to.y + 5.0, to.x - 10.0, to.y - 5.0);
    // Ticks X
    strokeWeight(TICK_WEIGHT);
    float maxX = getMaxX();
    for (int tick = (int(getMinX()) / stepX) * stepX; tick < maxX; tick += stepX) {
      if (tick == 0)
        continue;
      PVector p = plotToScreen(tick, 0); //<>//
      //PVector p2 = plotToScreen(tick, -1);
      //PVector pText = plotToScreen(tick, -8);
      line(p.x, p.y + TICK_RADIUS, p.x, p.y - TICK_RADIUS);
      
      text(tick, p.x, p.y + TICK_TEXT_OFFSET);
    }
    //println(scaleX);
    
    //Draw Y axis
    from = plotToScreen(0, getMinY());
    to = plotToScreen(0, getMaxY());
    line(from.x, from.y, to.x, to.y);
    triangle(to.x, to.y, to.x + 5.0, to.y + 10.0, to.x - 5.0, to.y + 10.0);
    // Ticks
    float maxY = getMaxY();
    for (int tick = (int(getMinY()) / stepY) * stepY; tick < maxY; tick += stepY) {
      if (tick == 0)
        continue;
      PVector p = plotToScreen(0, tick);
      line(p.x - TICK_RADIUS, p.y, p.x + TICK_RADIUS, p.y);
      text(tick, p.x - TICK_TEXT_OFFSET, p.y);
    }
    
    
    fill(this.markerColor);
    for (int idx = 0; idx < this.pointsX.length; idx++) {
      PVector p = plotToScreen(this.pointsX[idx], this.pointsY[idx]);
      circle(p.x, p.y, this.markerRadius);
    }
    
    
    // Haojin Added Vertical and Horizontal Text for Scatterplot
    textAlign(LEFT);
    strokeWeight(1.0);
    
    fill(color(0));
    textSize(16);
    text(this.text_x, this.x + this.width / 2 - 20, this.y + this.height + 30);

    pushMatrix();
    translate(this.x - 20, this.y + this.height / 2 + 20);
    rotate(radians(270));
    text(this.text_y, 0, 0);
    popMatrix();
  }

  @Override
  public void onMouseClicked(int mX, int mY) {

  }
  
  @Override
  public void onMouseMoved(int mX, int mY) {
  
  }
  
  public PVector plotToScreen(float pointX, float pointY) {
    float screenX = this.x + (pointX - this.topLeftPos.x) * this.scaleX;
    float screenY = this.y - (pointY - this.topLeftPos.y) * this.scaleY;
    
    return new PVector(screenX, screenY);
  }
  
  public void setPointsX(float[] new_points) {
    this.pointsX = new_points;
  }
  
  public float[] getPointsX() {
    return this.pointsX;
  }

  public void setPointsY(float[] new_points) {
    this.pointsY = new_points;
  }
  
  public float[] getPointsY() {
    return this.pointsY;
  }
  
  public float getMaxX() {
    return this.topLeftPos.x + this.width / this.scaleX;
  }
  
  public void setMaxX(float newMaxX) {
    this.scaleX = this.width / (newMaxX - getMinX());
  }

  public float getMinX() {
    return this.topLeftPos.x;
  }
  
  public void setMinX(float newMinX) {
    //float previousMinX = this.topLeftPos.x;
    float previousMaxX = getMaxX();
    
    this.topLeftPos.x = newMinX;
    this.scaleX = this.width / (previousMaxX - newMinX);
  }
  
  public float getMinY() {
    return this.topLeftPos.y - this.height / this.scaleY;
  }
  
  public void setMinY(float newMinY) {
    this.scaleY = this.height / (getMaxY() - newMinY);
  }

  public float getMaxY() {
    return this.topLeftPos.y;
  }
  
  public void setMaxY(float newMaxY) {
    //float previousMinX = this.topLeftPos.x;
    float previousMinY = getMinY();
    
    this.topLeftPos.y = newMaxY;
    this.scaleY = this.height / (newMaxY - previousMinY);
  }
}
