/**
  *  A GUI button widget.
  *  
  *  To attach logic which should be executed after the button is clicked,
  *  pass function's name as third constructor' parameter or use setCallback() method.
  *
  *  You may use lambdas carrying logic instead of defining full functions, like this:
  * 
  *  new ButtonWidget(0, 0, () -> { println("Button pressed!"); });
  *  
  *
  *  (c) Lex created the class at 04/03/2025
  */
public class ButtonWidget extends Widget {
  public float width;
  public float height;
  public color background = color(100);
  public color foreground = color(0);
  public String text = "";

  private Runnable onClick;

  public ButtonWidget(float x_in, float y_in, Runnable onClickCallback) {
    this.x = x_in;
    this.y = y_in;
    this.width = 200;
    this.height = 60;
    this.onClick = onClickCallback;
  }
  
  @Override
  public void draw() {
    fill(background);
    rect(this.x, this.y, this.width, this.height);
  }

  @Override
  public void onMouseClicked(int mX, int mY) {
    if (mX > this.x && mX < (this.x + this.width) && mY > this.x && mX < (this.x + this.width)) {
      if (onClick != null) {
        onClick.run();
      }
    }
  }
  
  public void setCallback(Runnable routine) {
    this.onClick = routine;
  }
}
