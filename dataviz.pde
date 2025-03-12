/* Resources */
PFont mainFont;
public static PShape checkmarkShape = null;

ScreenManager screenManager;

/**
  *  Load static resources such as fonts and images at the start of the program.
  *
  *  Alex added on 12/03/2025
  */
private void loadResources() {
  mainFont = loadFont("Inter-Regular-48.vlw");
  textFont(mainFont);
  
  checkmarkShape = loadShape("checkmark.svg");
  checkmarkShape.disableStyle();
}

void setup() {
  size(900, 600);
  
  loadResources();
  
  defaultScreen = new ScreenManager(color(245, 245, 245));
  currentScreen = defaultScreen;
  
  currentScreen.addWidget(new ButtonWidget(250, 100, "Click me!", () -> { println("Button clicked!"); }));
  currentScreen.addWidget(new CheckboxWidget(450, 100));
  currentScreen.addWidget(new ScatterplotWidget(600, 10));
  currentScreen.addWidget(new CalendarWidget(50, 250));
}

void draw() {
  currentScreen.drawScreen();
}

void mouseClicked() {
  currentScreen.onMouseClicked(mouseX, mouseY);
}

void mouseMoved() {
  currentScreen.onMouseMoved(mouseX, mouseY);
}
