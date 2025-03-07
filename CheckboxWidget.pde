/**
  *  A GUI checkbox widget.
  *
  *  The state of whether the checkbox was ticked can be accessed with
  *  .getChecked() method.
  *
  *
  *  (c) Alexey added on 07/03/2025
  */
public class CheckboxWidget extends Widget {
  public color bg = color(245);
  public color hoveredBg = color(230);
  public color pressedBg = color(220);
  public color checkedBg = color(71, 145, 119);
  public color checkmarkColor = color(230);
  public color borderColor = color(190);
  public float borderWidth = 1.5f;
  
  private float size = 30;
  private boolean isHovered = false;
  private float cornerRadius = 6.0f;
  private boolean isChecked = false;
  private float padding = 3.0f;

  public CheckboxWidget(float x_in, float y_in) {
    this.x = x_in;
    this.y = y_in;
  }
  
  @Override
  public void draw() {
    stroke(this.borderColor);
    strokeWeight(this.borderWidth);
    
    if (!this.isChecked) {
      /*  ===  Draw Unchecked  ===  */
      if (this.isHovered && mousePressed) {
        fill(this.pressedBg);
      } else if (this.isHovered) {
        strokeWeight(this.borderWidth * 1.25);
        fill(this.hoveredBg);
      } else {
        fill(this.bg);    
      }
      rect(this.x, this.y, this.size, this.size, this.cornerRadius);
    } else {
      /*  ===  Draw Checked  ===  */
      noStroke();
      fill(this.checkedBg);
      rect(this.x, this.y, this.size, this.size, this.cornerRadius);
      fill(this.checkmarkColor);
      shape(checkmarkShape, x + this.padding, y + this.padding, this.size - this.padding*2, this.size - this.padding*2);
    }
    
    // Revert stroke to default
    stroke(0);
    strokeWeight(1);
  }

  @Override
  public void onMouseClicked(int mX, int mY) {
    if (mX > this.x && mX < (this.x + this.size) && mY > this.y && mY < (this.y + this.size)) {
      this.setChecked(!this.getChecked());
    }
  }
  
  @Override
  public void onMouseMoved(int mX, int mY) {
    if (mX > this.x && mX < (this.x + this.size) && mY > this.y && mY < (this.y + this.size)) {
      if (!isHovered) {
        cursor(HAND); // cursor just entered
      }
      isHovered = true;
    } else {
      if (isHovered) {
        cursor(ARROW); // cursor just left
      }
      isHovered = false;
    }
  }
  
  public boolean getChecked() {
    return this.isChecked;
  }
  
  public void setChecked(boolean newValue) {
    this.isChecked = newValue;
  }

  public float getSize() {
    return this.size;
  }
  
  public void setSize(float newSize) {
    this.size = newSize;
  }
  
  public float getPadding() {
    return this.padding;
  }
  
  public void setPadding(float newPadding) {
    this.padding = newPadding;
  }
  
  public float getCornerRadius() {
    return this.cornerRadius;
  }
  
  public void setCornerRadius(float newCornerRadius) {
    this.cornerRadius = newCornerRadius;
  }
}
