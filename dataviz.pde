PFont mainFont;
public static PShape checkmarkShape = null;

public ArrayList<DataLoading> dataFiles = new ArrayList<>();
DataLoading flights = new DataLoading();

ButtonWidget btn;
CheckboxWidget check;
ScatterplotWidget scat;
CalendarWidget cal;



void setup() {
  size(900, 600);
  
  // temp demonstration
  dataFiles.add(flights);
  println(dataFiles.get(0));
  flights.loadData("flights2kCleaned.csv");
  flights.printColumns();
  println(flights.stringToDate("01/01/2022", "01/04/2022"));
  print(flights.data.getString(1, "FL_DATE"));
  // ends
  
  
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
