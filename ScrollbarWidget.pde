/**
  * Scrollbar GUI widget which can be scrolled with mouse.
  *
  * Designed for use inside containers.
  *
  *
  * (c) Alexey added on 01/04/2025
  */
public class ScrollbarWidget extends Widget {
  public float width = 600.0f;
  public float height = 50.0f;
  public color bg = color(235);
  public color fg = color(255);
  public float progressRatio = 0.2;  // The size of the scrolling element as percentage of whole size(width or height).
  public float progressMin = 0;      // Value at the lowest position of the scrollbar.
  public float progressMax = 2000;   // Value at the highest position of the scrollbar.
  public float value = 0;            // The current value of the scrollbar between progressMin and progressMax
  public boolean isVertical;         // is scrollbar vertical or horizontal?

  private boolean isDragging = false; // Used for internal handling of dragging the scrollbar.
  private float grabX;                // remember where the dragging started.
  private float grabY;
  private float grabValue;
  
  /**
    * Create a scrollbar widget object.
    *
    * @param w width
    * @param h height
    * @param isVertical should the scrollbar be vertical or horizontal?
    *
    */
  public ScrollbarWidget(float xIn, float yIn, float w, float h, boolean isVertical) {
    this.x = xIn;
    this.y = yIn;
    this.width = w;
    this.height = h;
    this.isVertical = isVertical;    
  }

  @Override
  public void draw() {
    fill(this.bg);
    noStroke();
    rect(this.x, this.y, this.width, this.height); // Draw background
    
    // Change color if cursor is holding the scroll element.
    if (isDragging) {
      fill(100);
    } else {
      fill(150);
    }
    
    if (this.isVertical) {
      // Draw as vertical
      float scrollPos = this.y + this.height * (1 - progressRatio) * (this.value - progressMin)/(this.progressMax - progressMin);
      float scrollWidth = this.height * progressRatio;
      rect(this.x, scrollPos, this.width, scrollWidth );
    } else {
      // Draw as horizontal
      float scrollPos = this.x + this.width * (1 - progressRatio) * (this.value - progressMin)/(this.progressMax - progressMin);
      float scrollWidth = this.width * progressRatio;
      rect(scrollPos, this.y, scrollWidth, this.height );    
    }

    // Restore basic stroke
    stroke(1);
  }
  
  @Override
  public void onMouseReleased(int mX, int mY) {
    this.isDragging = false;
  }
  
  @Override
  public void onMousePressed(int mX, int mY) {
    if (isVertical) {
      // handle as vertical. Check if cursor inside.
      float scrollPos = this.y + this.height * (1 - progressRatio) * (this.value - progressMin)/(this.progressMax - progressMin);
      if (mY > scrollPos && mY < scrollPos + height * progressRatio && mX > this.x && mX < this.x + this.width) {
        this.isDragging = true;
        grabX = mX;
        grabY = mY;
        grabValue = value;    
      }   
    } else {
      // handle as horizontal. Check if cursor inside.
      float scrollPos = this.x + this.width * (1 - progressRatio) * (this.value - progressMin)/(this.progressMax - progressMin);
      if (mX > scrollPos && mX < scrollPos + width * progressRatio && mY > this.y && mY < this.y + this.height) {
        this.isDragging = true;
        grabX = mX; 
        grabY = mY;
        grabValue = value;    
      }
    }
  }
  
  @Override
  public void onMouseDragged(int mX, int mY) {
    if (isDragging) {
      if (isVertical) {
        // calculate new value as vertical
        float newVal = grabValue + (mY - grabY) * ((progressMax - progressMin) / ((height * (1 - progressRatio))));
        this.value = min(progressMax, max(progressMin, newVal));
      } else {
        // calculate new value as horizontal
        float newVal = grabValue + (mX - grabX) * ((progressMax - progressMin) / ((width * (1 - progressRatio))));
        this.value = min(progressMax, max(progressMin, newVal));       
      }
    }
  }
}
