PFont mainFont;

ButtonWidget btn;

void setup() {
  size(900, 600);
  
  mainFont = loadFont("Inter-Regular-48.vlw");
  textFont(mainFont);
  
  btn = new ButtonWidget(100, 300, "Click me!", () -> { println("Button clicked!"); });
  btn.setFontSize(32);
  
  float[] data = {3.0f, 5.0f, 7.0f};
  StatisticFunctions s = new StatisticFunctions();
  print(s.mean(data));
}

void draw() {
  background(255);
  
  fill(255, 0, 0);
  rect(100, 100, 100, 100);
  
  btn.draw();
}

void mouseClicked() {
  btn.onMouseClicked(mouseX, mouseY);
}

void mouseMoved() {
  btn.onMouseMoved(mouseX, mouseY);
}
