PFont mainFont;
public static PShape checkmarkShape = null;

ScreenManager screenManager;

void setup() {
  size(900, 600);
  
  defaultScreen = new ScreenManager(color(245, 245, 245));
  currentScreen = defaultScreen;
  
  mainFont = loadFont("Inter-Regular-48.vlw");
  textFont(mainFont);
  
  checkmarkShape = loadShape("checkmark.svg");
  checkmarkShape.disableStyle();
  
  currentScreen.addWidget(new ButtonWidget(250, 100, "Click me!", () -> { println("Button clicked!"); }));
  currentScreen.addWidget(new CheckboxWidget(450, 100));
  currentScreen.addWidget(new ScatterplotWidget(600, 10));
  currentScreen.addWidget(new CalendarWidget(50, 250));
}

void draw() {
  currentScreen.drawScreen();
}

void mouseClicked() {
  //btn.onMouseClicked(mouseX, mouseY);
  //check.onMouseClicked(mouseX, mouseY);
  //cal.onMouseClicked(mouseX, mouseY);
}

void mouseMoved() {
  //btn.onMouseMoved(mouseX, mouseY);
  //check.onMouseMoved(mouseX, mouseY);
  //cal.onMouseMoved(mouseX, mouseY);
}
