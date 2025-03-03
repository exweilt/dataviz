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
  public color bg = color(16);
  public color fg = color(230);
  public color hoveredBg = color(60);
  public color pressedBg = color(130);
  
  private float width = 0;
  private float height = 0;
  private float padding = 10.0;
  private float fontSize = 16.0;
  private String text = "";
  private Runnable onClick;
  private boolean isHovered = false;

  public ButtonWidget(float x_in, float y_in, String text, Runnable onClickCallback) {
    this.x = x_in;
    this.y = y_in;
    this.onClick = onClickCallback;
    this.setText(text);
  }
  
  @Override
  public void draw() {
    if (this.isHovered && mousePressed) {
      fill(this.pressedBg);
      strokeWeight(3);
      stroke(255);
      cursor(HAND);
    } else if (this.isHovered) {
      fill(this.hoveredBg);
      cursor(HAND);
    } else {
      fill(this.bg);    
    }
    rect(this.x, this.y, this.width, this.height);
    
    fill(this.fg);
    textSize(this.fontSize);
    text(this.text, this.x + padding, this.y + this.height - padding);
    
    // Revert stroke to default
    stroke(0);
    strokeWeight(1);
  }

  @Override
  public void onMouseClicked(int mX, int mY) {
    if (mX > this.x && mX < (this.x + this.width) && mY > this.y && mY < (this.y + this.height)) {
      if (onClick != null) {
        onClick.run();
      }
    }
  }
  
  @Override
  public void onMouseMoved(int mX, int mY) {
    if (mX > this.x && mX < (this.x + this.width) && mY > this.y && mY < (this.y + this.height)) {
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

  private void recalculateWidth() {
    textSize(this.fontSize);
    this.width = textWidth(this.text) + padding*2;
    this.height = textAscent() + textDescent() + padding*2;
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
}
