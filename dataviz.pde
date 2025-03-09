PFont mainFont;
public static PShape checkmarkShape = null;

ButtonWidget btn;
CheckboxWidget check;
ScatterplotWidget scat;

void setup() {
  size(900, 600);
  
  mainFont = loadFont("Inter-Regular-48.vlw");
  textFont(mainFont);
  
  checkmarkShape = loadShape("checkmark.svg");
  checkmarkShape.disableStyle();
  
  btn = new ButtonWidget(100, 300, "Click me!", () -> { println("Button clicked!"); });
  
  check = new CheckboxWidget(300, 300);
  check.setSize(btn.height);
  
  scat = new ScatterplotWidget(400, 200);
  
  //float[] data = {3.0f, 5.0f, 7.0f};
  //StatisticFunctions s = new StatisticFunctions();
  //print(s.mean(data));
}

void draw() {
  background(255);
  
  fill(255, 0, 0);
  rect(100, 100, 100, 100);
  
  btn.draw();
  check.draw();
  scat.draw();
}

void mouseClicked() {
  btn.onMouseClicked(mouseX, mouseY);
  check.onMouseClicked(mouseX, mouseY);
}

void mouseMoved() {
  btn.onMouseMoved(mouseX, mouseY);
  check.onMouseMoved(mouseX, mouseY);
}
