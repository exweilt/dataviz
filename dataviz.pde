PFont mainFont;
public static PShape checkmarkShape = null;

ButtonWidget btn;
CheckboxWidget check;
ScatterplotWidget scat;
CalendarWidget cal;
String file = "flights2kCleaned.csv";
void setup() {
  size(900, 600);
  //TEMP
  loadData(file);
  
  
  mainFont = loadFont("Inter-Regular-48.vlw");
  textFont(mainFont);
  
  checkmarkShape = loadShape("checkmark.svg");
  checkmarkShape.disableStyle();
  
  btn = new ButtonWidget(250, 100, "Click me!", () -> { println("Button clicked!"); });
  
  check = new CheckboxWidget(450, 100);
  check.setSize(btn.height);
  
  scat = new ScatterplotWidget(600, 10);
  
  cal = new CalendarWidget(50, 250);
  
  //float[] data = {3.0f, 5.0f, 7.0f};
  //StatisticFunctions s = new StatisticFunctions();
  //print(s.mean(data));
}

void draw() {
  background(240);
  
  fill(255, 0, 0);
  rect(100, 100, 100, 100);
  
  btn.draw();
  check.draw();
  scat.draw();
  cal.draw();
}

void mouseClicked() {
  btn.onMouseClicked(mouseX, mouseY);
  check.onMouseClicked(mouseX, mouseY);
  cal.onMouseClicked(mouseX, mouseY);
}

void mouseMoved() {
  btn.onMouseMoved(mouseX, mouseY);
  check.onMouseMoved(mouseX, mouseY);
  cal.onMouseMoved(mouseX, mouseY);
}
