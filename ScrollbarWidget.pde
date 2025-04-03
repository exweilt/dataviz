public class ScrollbarWidget extends Widget {
  float width = 600.0f;
  float height = 50.0f;
  color bg = color(200);
  color fg = color(255);
  float progress = 0.5;
  float progressRatio = 0.2;
  float progressMin = 0;
  float progressMax = 2000;
  float value = 0;
  //float progressWidth
  boolean isDragging = false;
  float grabX;
  float grabY;
  float grabValue;
  boolean isVertical;
  
  public ScrollbarWidget(float x_in, float y_in, float w, float h, boolean isVertical) {
    this.x = x_in;
    this.y = y_in;
    this.width = w;
    this.height = h;
    this.isVertical = isVertical;    
  }

  @Override
  public void draw() {
    fill(235);
    noStroke();
    rect(this.x, this.y, this.width, this.height);
    
    if (isDragging) {
      fill(100);
    } else {
      fill(150);
    }
    
    if (this.isVertical) {
      float scrollPos = this.y + this.height * (1 - progressRatio) * (this.value - progressMin)/(this.progressMax - progressMin);
      float scrollWidth = this.height * progressRatio;
      rect(this.x, scrollPos, this.width, scrollWidth );
    } else {
      float scrollPos = this.x + this.width * (1 - progressRatio) * (this.value - progressMin)/(this.progressMax - progressMin);
      float scrollWidth = this.width * progressRatio;
      rect(scrollPos, this.y, scrollWidth, this.height );    
    }

    
    stroke(1);
  }
  
   @Override
 public void onMouseReleased(int mX, int mY) {
    this.isDragging = false;
  }
  
   @Override
 public void onMousePressed(int mX, int mY) {
   if (isVertical) {
     float scrollPos = this.y + this.height * (1 - progressRatio) * (this.value - progressMin)/(this.progressMax - progressMin);
     if (mY > scrollPos && mY < scrollPos + height * progressRatio && mX > this.x && mX < this.x + this.width) {
        this.isDragging = true;
        grabX = mX;
        grabY = mY;
        grabValue = value;    
    }   
   } else {
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
        float newVal = grabValue + (mY - grabY) * ((progressMax - progressMin) / ((height * (1 - progressRatio))));
        this.value = min(progressMax, max(progressMin, newVal));       
     } else {
        float newVal = grabValue + (mX - grabX) * ((progressMax - progressMin) / ((width * (1 - progressRatio))));
        this.value = min(progressMax, max(progressMin, newVal));       
     }
 
   }

  }
}
