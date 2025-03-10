PFont mainFont;

ScreenManager screenManager;
ButtonWidget btn;

void setup() {
  size(900, 600);
  
  defaultScreen = new ScreenManager(color(0, 0, 0));
  currentScreen = defaultScreen;
  
  mainFont = loadFont("Inter-Regular-48.vlw");
  textFont(mainFont);
  
  btn = new ButtonWidget(100, 300, "Click me!", () -> { println("Button clicked!"); });
  btn.setFontSize(32);
}

void draw() {
  background(255);
  
  currentScreen.drawScreen();
  
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
