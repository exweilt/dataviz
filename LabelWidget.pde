public class LabelWidget extends Widget {
  public color fontColor = color (0);
  public float fontSize = 16;
  public String text = "";

  public LabelWidget(float x_in, float y_in, String text) {
    this.x = x_in;
    this.y = y_in;
    this.text = text;
  }

  public LabelWidget(float x_in, float y_in, String text, float size) {
    this.x = x_in;
    this.y = y_in;
    this.text = text;
    this.fontSize = size;
  }
  
  @Override
  public void draw() {
    textAlign(LEFT);

    fill(this.fontColor);
    textSize(this.fontSize);
    text(this.text, this.x, this.y);
  }
}
