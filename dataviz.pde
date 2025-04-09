/* Resources */ //<>// //<>// //<>// //<>//
PFont mainFont;
public static PShape checkmarkShape = null;
public static PShape arrowdownShape = null;
public static PShape arrowupShape = null;
public static PShape binShape = null;

DataLoading flights = new DataLoading();
Screen currentScreen;
TextFieldWidget focusedTextField = null;  // Added on 17/03/2025 by Damon // modified by william
ScatterplotWidget scatter = new ScatterplotWidget(50, 50, "X", "Y");
ButtonWidget btn;
TableWidget table;
ContainerWidget container;
ContainerWidget bar_container;
DroplistWidget barDropSelector;

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
  flights.loadData("flights2kCleaned.csv");

  //btn = new ButtonWidget(350, 100, "Click me!", () -> {
  //  interest = input.getText();
  //  scatter.setPointsX(flights.data.getFloatColumn(interest));
  //}
  //);

  currentScreen = new Screen(color(245, 245, 245));

  //scatter.setPointsX(flights.data.getFloatColumn("ORIGIN_WAC"));
  scatter.setPointsY(flights.data.getFloatColumn("DISTANCE"));

  scatter.setMinX(-1.0);
  scatter.setMaxX(100.0);
  scatter.setMinY(-10.0);
  scatter.setMaxY(3000.0);

  bar = new BarplotWidget(400, 50);
  currentScreen.addWidget(bar);


  // Added by Haojin 27/03/2025
  // Modified and cleaned by William 02/04
  // 66666666666666666666666666666666666666666666Display all different screens

  Screen screen_home = new Screen(color(245, 245, 245));
  Screen screen_query = new Screen(color(245, 245, 245));
  Screen screen_table = new Screen(color(245, 245, 245));
  Screen screen_barplot = new Screen(color(245, 245, 245));
  Screen screen_histogram = new Screen(color(245, 245, 245));
  Screen screen_piechart = new Screen(color(245, 245, 245));  // added by Damon
  Screen screen_Scatterplot = new Screen(color(245, 245, 245));

  // Home screen
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
  LabelWidget l = new LabelWidget(50, 50, "Filters and sorting here applies to all the graphs on the following pages.");
  l.fontSize = 24;
  screen_query.addWidget(l);
  filters = new QueryingWidget(50, 150);
  filters.onApply = () -> {
    // Table update
    table.data = filters.result;
    container.redraw();
    
    // Barplot update
    HashMap<String, Integer> map = StatisticFunctions.absoluteFrequency(filters.result.getStringColumn(barDropSelector.getSelectedString()));
    bar.categoriesX = map.keySet().toArray(new String[0]);
    bar.pointsY = new float[bar.categoriesX.length];
    for (String label : bar.categoriesX) {
      bar.setCategoryValue(label, map.get(label).floatValue());
    }
    bar_container.redraw();
  };
  screen_query.addWidget(filters);


  currentScreen = screen_home;
  screen_home.addWidget(new LabelWidget(250, 300, "Flights visualizer", 40));
  screen_home.addWidget(new LabelWidget(250, 400, "Welcome to the flights data visualizer!"));
  screen_home.addWidget(new LabelWidget(250, 450, "Click next page to continue."));
  
  screen_home.addWidget(new ButtonWidget(750, 550, "Next Page", () -> {
    currentScreen = screen_query;
  }));

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
  table = new TableWidget(50, 50, filters.result);
  container = new ContainerWidget(50, 50, 800, 700, 4000, 100000);
  container.addWidget(table);
  screen_table.addWidget(container);
  //  =================================================

  // barplot screen
  bar = new BarplotWidget(100, 20);
  bar_container = new ContainerWidget(50, 50, 600, 700, 600, 1000);
  bar_container.addWidget(bar);
  screen_barplot.addWidget(bar_container);
  barDropSelector = new DroplistWidget(700, 200, flights.columnNames.toArray(new String[0]));
  LabelWidget barSelectorLabel = new LabelWidget(700, 180, "Select column of interest.");
  screen_barplot.addWidget(barDropSelector);
  screen_barplot.addWidget(barSelectorLabel);
  barDropSelector.onSelected = () -> {
    // Barplot update
    HashMap<String, Integer> map = StatisticFunctions.absoluteFrequency(filters.result.getStringColumn(barDropSelector.getSelectedString()));
    bar.categoriesX = map.keySet().toArray(new String[0]);
    bar.pointsY = new float[bar.categoriesX.length];
    for (String label : bar.categoriesX) {
      bar.setCategoryValue(label, map.get(label).floatValue());
    }
    bar_container.redraw();
  };

  //ButtonWidget updateBarBtn = new ButtonWidget(500, 600, "Update",
  //  () -> {
  //  HashMap<String, Integer> map = StatisticFunctions.absoluteFrequency(filters.result.getStringColumn("ORIGIN"));
  //  bar.categoriesX = map.keySet().toArray(new String[0]);
  //  bar.pointsY = new float[bar.categoriesX.length];
  //  for (String label : bar.categoriesX) {
  //    bar.setCategoryValue(label, map.get(label).floatValue()); //<>//
  //  }
  //}
  //);
  //updateBarBtn.onClick.run();
  //screen_barplot.addWidget(updateBarBtn);
  screen_barplot.addWidget(new ButtonWidget(50, 800, "Previous Page",
    () -> {
    currentScreen = screen_table;
  }
  ));
  screen_barplot.addWidget(new ButtonWidget(750, 800, "Next Page",
    () -> {
    currentScreen = screen_piechart;
  }
  ));

  // Pie chart screen
  // Add the PieChart screen by Damon
  // Edited by William
  TextFieldWidget input = new TextFieldWidget(550, 50, 200, 40, "Enter Origin Airport");
  LabelWidget pieChartLabel = new LabelWidget(300,50, "Piechart: Origin -> Dest");
  screen_piechart.addWidget(pieChartLabel);
  PieChartWidget pie = new PieChartWidget(100, 100, flights.data);
  screen_piechart.addWidget(pie);
  screen_piechart.addWidget(input);
  screen_piechart.addWidget(new ButtonWidget(350, 500, "Generate PieChart", 
  () -> {
    String code = input.getText();   // Load the code from input TextField
    pie.setFilter(code);             // Call PieChart filter function
  }

)); //<>//

// PieChart goes back to Histogram
screen_piechart.addWidget(new ButtonWidget(50, 550, "Previous Page", 
  () -> {

    currentScreen = screen_barplot;
  }
  ));
  screen_piechart.addWidget(new ButtonWidget(750, 550, "Next Page", 
    () -> {
    currentScreen = screen_histogram;
  }
  ));

  // Histogram Screen
  HistogramWidget hist = new HistogramWidget(10,10);
  screen_histogram.addWidget(hist);
  
  String[] histOptions = {"DEST_WAC", "ORIGIN_WAC", "DEP_TIME", "ARR_TIME"};
  DroplistWidget histDropList = new DroplistWidget(0,0, histOptions);
  hist.setValues(flights.data.getFloatColumn(histDropList.getSelectedString()));
  screen_histogram.addWidget(histDropList);
  ButtonWidget updateHistBtn = new ButtonWidget(500, 600, "Update",
    () -> {
    hist.setCategory(histDropList.getSelectedString());
    hist.setValues(flights.data.getFloatColumn(histDropList.getSelectedString()));
    }
  );
  updateHistBtn.onClick.run(); //<>//
  
  screen_histogram.addWidget(updateHistBtn);
  screen_histogram.addWidget(new ButtonWidget(50, 600, "Previous Page",
    () -> {
    currentScreen = screen_piechart;
  }
  ));
  screen_histogram.addWidget(new ButtonWidget(750, 600, "Next Page", 
    () -> {
    currentScreen = screen_Scatterplot;
  }
  ));

  

  // Scatter plot Screen
  screen_Scatterplot.addWidget(new ButtonWidget(50, 550, "Previous Page", 
  () -> {
    currentScreen = screen_histogram;
  }
  ));
  
  filters.apply();
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
