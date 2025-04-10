/**
  * Rectangle widget.
  *
  * Simply draws rectangle. 
  * Can be used as box background to group elements together visually.
  *
  * (c) Alexey added on 09/04/2025
  */
public class RectangleWidget extends Widget {
  public float width;
  public float height;
  public color bg;

  public RectangleWidget(float x_in, float y_in, float w, float h, color c) {
    this.x = x_in;
    this.y = y_in;
    this.width = w;
    this.height = h;
    this.bg = c;
  }
  
  @Override
  public void draw() {
    noStroke();
    fill(this.bg);
    rect(this.x, this.y, this.width, this.height);
    strokeWeight(1.0);
  }
}
