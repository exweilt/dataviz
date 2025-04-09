/**
  *  A GUI button widget.
  *  
  *  To attach logic which should be executed after the button is clicked,
  *  pass function's name as third constructor' parameter or use setCallback() method.
  *
  *  You may use lambdas carrying logic instead of defining full functions, like this:
  * 
  *  new ButtonWidget(0, 0, "something.", () -> { println("Button pressed!"); });
  *  
  *
  *  (c) Lex created the class at 04/03/2025
  */
public class ButtonWidget extends Widget {
  public color bg = color(245);
  public color fg = color(42);
  public color hoveredFg = color(42);
  public color hoveredBg = color(230);
  public color pressedBg = color(220);
  public color borderColor = color(190);
  public float borderWidth = 1.5f;
  public boolean fixedWidth = false;
  
  private float width = 0;
  public float height = 0;
  private float padding = 8.0;
  private float fontSize = 20.0;
  private String text = "";
  private Runnable onClick;
  private boolean isHovered = false;
  private float cornerRadius = 9.0f;
  public float trRadius = 9.0f;
  public float tlRadius = 9.0f;
  public float brRadius = 9.0f;
  public float blRadius = 9.0f;
  private PShape optionalRightIcon = null; 

  public ButtonWidget(float x_in, float y_in, String text, Runnable onClickCallback) {
    this.x = x_in;
    this.y = y_in;
    this.onClick = onClickCallback;
    this.setText(text);
  }
  
  @Override
  public void draw() {
    textAlign(LEFT);
    if (this.isHovered && mousePressed) {
      fill(this.pressedBg);
    } else if (this.isHovered) {
      fill(this.hoveredBg);
    } else {
      fill(this.bg);    
    }
    stroke(this.borderColor);
    strokeWeight(this.borderWidth);
    
    rect(this.x, this.y, this.width, this.height, this.tlRadius, this.trRadius, this.brRadius, this.blRadius);
    
    if  (this.isHovered) {
      fill(this.hoveredFg);
    } else {
      fill(this.fg);
    }
    textSize(this.fontSize);
    text(this.text, this.x + padding, this.y + this.height - padding);
    
    if (this.optionalRightIcon != null) {
      float pad = this.height / 5.0;
      noStroke();
      shape(this.optionalRightIcon, this.x + this.width - this.height + pad, this.y + pad, this.height / 2.0, this.height / 2.0);
    }
    
    // Revert stroke to default
    stroke(0);
    strokeWeight(1);
  }

  @Override
  public boolean onMouseClicked(int mX, int mY) {
    if (mX > this.x && mX < (this.x + this.width) && mY > this.y && mY < (this.y + this.height)) {
      if (onClick != null) {
        onClick.run();
      }
      return true;
    }
    return false;
  }
  
  @Override
  public void onMouseMoved(int mX, int mY) {
    if (mX > this.x && mX < (this.x + this.width) && mY > this.y && mY < (this.y + this.height)) {
      if (!isHovered) {
        //cursor(HAND); // cursor just entered 
        //println(millis() + " entered");
      }
      cursor(HAND);
      isHovered = true;
    } else {
      if (isHovered) {
        //cursor(ARROW); // cursor just left
        //println(millis() + " left");
      }
      isHovered = false;
    }
  }

  private void recalculateWidth() {
    textSize(this.fontSize);
    
    this.height = textAscent() + textDescent() + padding*2;

    if (!this.fixedWidth) {
      this.width = textWidth(this.text) + padding*2;
      
      if (this.optionalRightIcon != null) {
        this.width += height;
      }
    }
  }
  
  public void setCallback(Runnable routine) {
    this.onClick = routine;
  }
  
  public String getText() {
    return this.text;
  }
  
  public void setText(String newText) {
    this.text = newText;
    this.recalculateWidth();
  }
  
  public float getPadding() {
    return this.padding;
  }
  
  public void setPadding(float newPadding) {
    this.padding = newPadding;
    this.recalculateWidth();
  }

  public float getFontSize() {
    return this.fontSize;
  }
  
  public void setFontSize(float newFontSize) {
    this.fontSize = newFontSize;
    this.recalculateWidth();
  }
  
  //public float getCornerRadius() {
  //  return this.cornerRadius;
  //}
  
  public void setCornerRadius(float newCornerRadius) {
    this.trRadius = newCornerRadius;
    this.tlRadius = newCornerRadius;
    this.blRadius = newCornerRadius;
    this.brRadius = newCornerRadius;
  }
  
  public void setOptionalIcon(PShape icon) {
    this.optionalRightIcon = icon;
    this.recalculateWidth();
  }
  
  public PShape getOptionalIcon() {
    return this.optionalRightIcon;
  }
}
