PFont mainFont;

ButtonWidget btn;

void setup() {
  size(900, 600);
  
  mainFont = loadFont("Inter-Regular-48.vlw");
  textFont(mainFont);
  
  btn = new ButtonWidget(100, 300, "Click me!", () -> { println("Button clicked!"); });
  btn.setFontSize(32);
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
