/* Resources */ //<>// //<>// //<>//
PFont mainFont;
public static PShape checkmarkShape = null;
public static PShape arrowdownShape = null;
public static PShape arrowupShape = null;
public static PShape binShape = null;

public ArrayList<DataLoading> dataFiles = new ArrayList<>();
DataLoading flights = new DataLoading();
Screen currentScreen;
TextFieldWidget focusedTextField = null;  // Added on 17/03/2025 by Damon
ScatterplotWidget scatter = new ScatterplotWidget(50, 50, "X", "Y");
TextFieldWidget input = new TextFieldWidget(550, 50, 200, 40, "Enter Airport Code" );
ButtonWidget btn;
TableWidget table;
ContainerWidget container;

QueryingWidget filters;
BarplotWidget bar;

String interest = "";
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

  arrowdownShape = loadShape("arrowdown.svg");
  arrowdownShape.disableStyle();

  arrowupShape = loadShape("arrowup.svg");
  arrowupShape.disableStyle();

  binShape = loadShape("bin.svg");
  binShape.disableStyle();
}

void setup() {
  size(1000, 900);
  surface.setTitle("Plane flights data Visualizer");
  surface.setResizable(true);
  tb = getGraphics();

  loadResources();

  // tmp
  dataFiles.add(flights);
  flights.loadData("flights2kCleaned.csv");
  flights.printColumns();
  println(flights.stringToDate("01/01/2022", "01/04/2022"));
  print(flights.data.getString(1, "FL_DATE"));
  println(dataFiles.get(0));

  btn = new ButtonWidget(350, 100, "Click me!", () -> {
    interest = input.getText();
    scatter.setPointsX(flights.data.getFloatColumn(interest));
  }
  );

  currentScreen = new Screen(color(245, 245, 245));

  //scatter.setPointsX(flights.data.getFloatColumn("ORIGIN_WAC"));
  scatter.setPointsY(flights.data.getFloatColumn("DISTANCE"));

  scatter.setMinX(-1.0);
  scatter.setMaxX(100.0);
  scatter.setMinY(-10.0);
  scatter.setMaxY(3000.0);

  bar = new BarplotWidget(400, 50);
  currentScreen.addWidget(bar);




  // currentScreen.addWidget(scatter);
  // currentScreen.addWidget(input);
  //currentScreen.addWidget(btn);

  //DroplistWidget dl = new DroplistWidget(200, 200, new String[]{"Apple", "Banana", "Orange", "Lemon"});
  //currentScreen.addWidget(dl);
  //dl.setOptions(new String[]{"Ror", "Fsefq", "qr13roij", "LeFiomon"});

  //currentScreen.addWidget(filters);

  //currentScreen.addWidget(new ButtonWidget(250, 100, "Click me!", () -> { println("Button clicked!"); }));
  //currentScreen.addWidget(new CheckboxWidget(450, 100));
  //currentScreen.addWidget(new ScatterplotWidget(600, 10));
  //currentScreen.addWidget(new CalendarWidget(50, 250));
  //currentScreen.addWidget(new LabelWidget(100, 200, "LabelWIdget"));

  // Added by Haojin 27/03/2025
  // Display all different screens

  Screen screen_home = new Screen(color(245, 245, 245));
  Screen screen_query = new Screen(color(245, 245, 245));
  Screen screen_table = new Screen(color(245, 245, 245));
  Screen screen_barplot = new Screen(color(245, 245, 245));
  Screen screen_histogram = new Screen(color(245, 245, 245));
  Screen screen_piechart = new Screen(color(245, 245, 245));  // added by Damon
  Screen screen_Scatterplot = new Screen(color(245, 245, 245));

  screen_query.addWidget(new ButtonWidget(50, 550, "Previous Page",
    () -> {
    currentScreen = screen_home;
  }
  ));
  screen_query.addWidget(new ButtonWidget(750, 550, "Next Page",
    () -> {
    currentScreen = screen_table;
  }
  ));
  filters = new QueryingWidget(50, 50);
  screen_query.addWidget(filters);


  currentScreen = screen_query;
  screen_home.addWidget(new LabelWidget(375, 300, "This is Home Page"));

  screen_home.addWidget(new ButtonWidget(750, 550, "Next Page", () -> {
    currentScreen = screen_query;
  }
  ));

  //  ================= Table Page ====================
  screen_table.addWidget(new ButtonWidget(50, 850, "Previous Page",
    () -> {
    currentScreen = screen_query;
  }
  ));
  screen_table.addWidget(new ButtonWidget(750, 850, "Next Page",
    () -> {
    currentScreen = screen_barplot;
  }
  ));
  table = new TableWidget(50, 50, flights.data);
  container = new ContainerWidget(50, 50, 800, 700, 4000, 10000);
  container.addWidget(table);
  screen_table.addWidget(container);
  //  =================================================

  bar = new BarplotWidget(100, 0);
  screen_barplot.addWidget(bar);
  ButtonWidget updateBarBtn = new ButtonWidget(500, 600, "Update",
    () -> {
    HashMap<String, Integer> map = StatisticFunctions.absoluteFrequency(filters.result.getStringColumn("ORIGIN"));
    bar.categoriesX = map.keySet().toArray(new String[0]);
    bar.pointsY = new float[bar.categoriesX.length];
    for (String label : bar.categoriesX) {
      bar.setCategoryValue(label, map.get(label).floatValue());
    }
  }
  );
  updateBarBtn.onClick.run();
  screen_barplot.addWidget(updateBarBtn);
  screen_barplot.addWidget(new ButtonWidget(50, 550, "Previous Page",
    () -> {
    currentScreen = screen_table;
  }
  ));
  screen_barplot.addWidget(new ButtonWidget(750, 550, "Next Page",
    () -> {
    currentScreen = screen_piechart;
  }
  ));

  // screen_histogram.addWidget(new HistogramWidget(0, 0));
  screen_histogram.addWidget(new ButtonWidget(50, 550, "Previous Page",
    () -> {
    currentScreen = screen_piechart;
  }
  ));
  

// Add the PieChart screen by Damon
  PieChartWidget pie = new PieChartWidget(100, 100, flights.data);
  screen_piechart.addWidget(pie);
  screen_piechart.addWidget(input);
  screen_piechart.addWidget(new ButtonWidget(350, 500, "Generate PieChart", 
  () -> {
    String code = input.getText();   // Load the code from input TextField
    pie.setFilter(code);             // Call PieChart filter function
  }
));

// Histogram goes forward to PieChart
screen_histogram.addWidget(new ButtonWidget(750, 550, "Next Page", 
  () -> { //<>//
    currentScreen = screen_Scatterplot;
  }
));

// PieChart goes back to Histogram
screen_piechart.addWidget(new ButtonWidget(50, 550, "Previous Page", 
  () -> {
    currentScreen = screen_barplot;
  }
));

// PieChart goes forward to Scatterplot
screen_piechart.addWidget(new ButtonWidget(750, 550, "Next Page", 
  () -> {
    currentScreen = screen_histogram;
  }
));

// Scatterplot goes back to PieChart
screen_Scatterplot.addWidget(new ButtonWidget(50, 550, "Previous Page", 
  () -> {
    currentScreen = screen_histogram;
  }
));



}

void draw() {
  currentScreen.drawScreen();
}

void keyPressed() {
  currentScreen.onKeyPressed();
  
  if (keyCode == LEFT) {
    container.contentX -= 20.0; //<>//
  }
  if (keyCode == RIGHT) {
    container.contentX += 20.0;
  }
}


void mouseClicked() {
  currentScreen.onMouseClicked(mouseX, mouseY);
}

void mouseMoved() {
  currentScreen.onMouseMoved(mouseX, mouseY);
}

void mousePressed() {
  currentScreen.onMousePressed(mouseX, mouseY);
}

void mouseReleased() {
  currentScreen.onMouseReleased(mouseX, mouseY);
}

void mouseDragged() {
  currentScreen.onMouseDragged(mouseX, mouseY);
}

PGraphics[] bufferStack = new PGraphics[0];
PGraphics tb; // top buffer

void pushBuffer(PGraphics newBuffer) {
  bufferStack = Arrays.copyOf(bufferStack, bufferStack.length + 1);
  bufferStack[bufferStack.length - 1] = tb;
  tb = newBuffer;
}

void popBuffer() {
  tb = bufferStack[bufferStack.length - 1];
  bufferStack = Arrays.copyOf(bufferStack, bufferStack.length - 1);
}
