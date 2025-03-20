/* Resources */
PFont mainFont;
public static PShape checkmarkShape = null;
public ArrayList<DataLoading> dataFiles = new ArrayList<>();
DataLoading flights = new DataLoading();

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
  
  // tmp
  dataFiles.add(flights);
  flights.loadData("flights2kCleaned.csv");
  flights.printColumns();
  println(flights.stringToDate("01/01/2022", "01/04/2022"));
  print(flights.data.getString(1, "FL_DATE"));
  println(dataFiles.get(0));

  
  currentScreen = new Screen(color(245, 245, 245));
  
  //currentScreen.addWidget(new ButtonWidget(250, 100, "Click me!", () -> { println("Button clicked!"); }));
  //currentScreen.addWidget(new CheckboxWidget(450, 100));
  //currentScreen.addWidget(new ScatterplotWidget(600, 10));
  //currentScreen.addWidget(new CalendarWidget(50, 250));
  //currentScreen.addWidget(new LabelWidget(100, 200, "LabelWIdget"));
  //currentScreen.addWidget(new TableWidget(30, 100, flights.data));
  currentScreen.addWidget(new ScrollbarWidget(30, 100));
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
