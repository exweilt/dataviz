/* Resources */
PFont mainFont;
public static PShape checkmarkShape = null;
public ArrayList<DataLoading> dataFiles = new ArrayList<>();
DataLoading flights = new DataLoading();
TextFieldWidget searchBox;


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
  
 //Damon edited on 14/3/2025
  searchBox = new TextFieldWidget(50, 50, 200, 40, "Enter Airport Code");
  currentScreen.addWidget(searchBox); 
  
  
  currentScreen.addWidget(new ButtonWidget(250, 100, "Click me!", () -> { println("Button clicked!"); }));
  currentScreen.addWidget(new CheckboxWidget(450, 100));
  currentScreen.addWidget(new ScatterplotWidget(600, 10));
  currentScreen.addWidget(new CalendarWidget(50, 250));
  currentScreen.addWidget(new LabelWidget(100, 200, "LabelWIdget"));
}

void draw() {
  currentScreen.drawScreen();
}

void keyTyped() {
   searchBox.keyTyped(key);
  
  if (key == ENTER) {
    String airportCode = searchBox.getText().trim();
    println("Filtering flights by: " + airportCode);

    ArrayList<TableRow> filteredFlights = new ArrayList<>();

    for (int i = 0; i < flights.data.getRowCount(); i++) {
      TableRow row = flights.data.getRow(i);
      if (row.getString("Origin").equalsIgnoreCase(airportCode)) {
        filteredFlights.add(row);
      }
    }

    println("Filtered flights:");
    for (TableRow row : filteredFlights) {
      println(row.getString("FL_DATE") + " | " +
              row.getString("Origin") + " -> " +
              row.getString("Dest") + " | " +
              row.getInt("DepTime") + " -> " +
              row.getInt("ArrTime"));
    }
  }
}

void mouseClicked() {
  currentScreen.onMouseClicked(mouseX, mouseY);
}

void mouseMoved() {
  currentScreen.onMouseMoved(mouseX, mouseY);
}
