public class RectangleWidget extends Widget {
  float width;
  float height;
  color bg;

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
