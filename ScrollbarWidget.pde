public class ScrollbarWidget extends Widget {
  float width = 600.0f;
  float height = 50.0f;
  color bg = color(200);
  color fg = color(255);
  //float progress = 0.5
  
  
  public ScrollbarWidget(float x_in, float y_in) {
    this.x = x_in;
    this.y = y_in;
  }

  @Override
  public void draw() {
    fill(bg);
    rect(this.x, this.y, this.width, this.height);
    
  }
}
