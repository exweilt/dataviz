/* Resources */ //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
PFont mainFont;

// Sets Image Icon variables 
public static PShape checkmarkShape = null;
public static PShape arrowdownShape = null;
public static PShape arrowupShape = null;
public static PShape binShape = null;

//  Instantiating Widgets
DataLoading flights = new DataLoading();
Screen currentScreen;
TextFieldWidget focusedTextField = null;  // Added on 17/03/2025 by Damon // modified by william
ScatterplotWidget scatter;
ButtonWidget btn;
TableWidget table;
ContainerWidget container;
DroplistWidget barDropSelector;
DroplistWidget scatterSelectorX;
DroplistWidget scatterSelectorY;
BarplotWidget bar;
ContainerWidget barContainer;
HistogramWidget hist;
ContainerWidget histContainer;
ContainerWidget pieContainer;
QueryingWidget filters;
PieChartWidget pie;
PImage bg;

// Sets the button pressed
boolean buttonWasPressedDuringFrame = false; 


String interest = "";
/**
 *  Load static resources such as fonts and images at the start of the program.
 *
 *  Alex added on 12/03/2025
 */
private void loadResources() {
  // Loads the Icons
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
  // Creates the default screen size and loads the dataset
  size(1300, 900);
  surface.setTitle("Plane flights data Visualizer");
  loadResources();
  flights.loadData("flights10k.csv");
  bg = loadImage("Flight.jpg");

  // Added by Haojin 27/03/2025
  // Modified and cleaned by William 02/04
  
  // Instantiate all the different screens
  Screen screen_home = new Screen(bg);
  Screen screen_query = new Screen(color(255));
  Screen screen_table = new Screen(color(255));
  Screen screen_barplot = new Screen(color(255));
  Screen screen_histogram = new Screen(color(255));
  Screen screen_piechart = new Screen(color(255));  // added by Damon
  Screen screen_Scatterplot = new Screen(color(255));

  // Home screen
  currentScreen = screen_home; // Sets the current screen as home
  screen_query.addWidget(new ButtonWidget(50, 550, "Previous Page",
    () -> {
    currentScreen = screen_home;
  }
  ));
  screen_query.addWidget(new ButtonWidget(1100, 550, "Next Page",
    () -> {
    currentScreen = screen_table;
  }
  ));
  
  // Sets the logic for the filtering screen
  LabelWidget l = new LabelWidget(200, 25, "Filters and sorting here applies to all the graphs on the following pages.", 16, 180);
  l.fontSize = 24;
  screen_query.addWidget(l);
  filters = new QueryingWidget(50, 50);
  filters.onApply = () -> {
    // Table update
    table.data = filters.result;
    //container.redraw();
    container.setContentWidth((int)table.getWidth());
    container.setContentHeight((int)table.getHeight());
    
    // Barplot update
    HashMap<String, Integer> map = StatisticFunctions.absoluteFrequency(filters.result.getStringColumn(barDropSelector.getSelectedString()));
    bar.categoriesX = map.keySet().toArray(new String[0]);
    bar.pointsY = new float[bar.categoriesX.length];
    for (String label : bar.categoriesX) {
      bar.setCategoryValue(label, map.get(label).floatValue());
    }

    bar.updateScale();
    barContainer.setContentWidth((int)bar.getWidth());
    barContainer.setContentHeight((int)bar.getHeight());
    println("new bar container width = ", (int)bar.getWidth());
    println("new bar container height = ", (int)bar.getHeight());
    //bar_container.redraw();
    pie.setFilterFromUI(); //<>//
  };
  
  screen_query.addWidget(filters);


  currentScreen = screen_home;
  screen_home.addWidget(new RectangleWidget(400, 270, 540, 270, color(0, 0, 0, 70)));
  screen_home.addWidget(new LabelWidget(480, 350, "Flights visualizer", 50, 255));
  screen_home.addWidget(new LabelWidget(500, 450, "Welcome to the flights data visualizer!", 18, 255));
  screen_home.addWidget(new LabelWidget(500, 500, "Click next page to continue.", 18, 255));
  
  screen_home.addWidget(new ButtonWidget(900, 650, "Next Page", () -> {
    currentScreen = screen_query;
  }));

  //  ================= Table Page ====================
  screen_table.addWidget(new ButtonWidget(50, 800, "Previous Page",
    () -> {
    currentScreen = screen_query;
  }
  ));
  screen_table.addWidget(new ButtonWidget(1100, 800, "Next Page",
    () -> {
    currentScreen = screen_barplot;
  }
  ));
  table = new TableWidget(50, 50, filters.result);
  container = new ContainerWidget(50, 50, 1200, 700, (int)table.getWidth(), (int)table.getHeight());
  container.addWidget(table);
  //container.selectScrollOptions(true, true);
  screen_table.addWidget(container); //<>//


  // barplot screen
  bar = new BarplotWidget(100, 20);
  bar.width = 600;
  barContainer = new ContainerWidget(50, 50, 900, 700, 600, 1000);
  barContainer.addWidget(bar);
  screen_barplot.addWidget(barContainer);
  barDropSelector = new DroplistWidget(1000, 200, flights.columnNames.toArray(new String[0]));
  LabelWidget barSelectorLabel = new LabelWidget(1000, 180, "Select column of interest.");
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

    //bar_container.redraw();
    bar.updateScale();
    barContainer.setContentWidth((int)bar.getWidth()); //<>//
    barContainer.setContentHeight((int)bar.getHeight());
    
    println("new bar container width = ", (int)bar.getWidth());
    println("new bar container height = ", (int)bar.getHeight());
  };

  //ButtonWidget updateBarBtn = new ButtonWidget(500, 600, "Update",
  //  () -> {
  //  HashMap<String, Integer> map = StatisticFunctions.absoluteFrequency(filters.result.getStringColumn("ORIGIN"));
  //  bar.categoriesX = map.keySet().toArray(new String[0]);
  //  bar.pointsY = new float[bar.categoriesX.length];
  //  for (String label : bar.categoriesX) {
  //    bar.setCategoryValue(label, map.get(label).floatValue());
  //  }
  //}
  //); //<>//
  //updateBarBtn.onClick.run();
  //screen_barplot.addWidget(updateBarBtn); //<>//
  screen_barplot.addWidget(new ButtonWidget(50, 800, "Previous Page",
    () -> {
    currentScreen = screen_table;
  }
  ));
  screen_barplot.addWidget(new ButtonWidget(750, 800, "Next Page",
    () -> {
    currentScreen = screen_piechart; //<>//
  }));
  //screen_barplot.addWidget(leftBarScreenBtn);
  //screen_barplot.addWidget(rightBarScreenBtn);
  
  

  // =============================== Pie Chart Screen ===============================
  // Add the PieChart screen by Damon
  // Edited by William

  pie = new PieChartWidget(100, 100, filters); // get QueryingWidget Filter
  screen_piechart.addWidget(pie);
  //pieContainer = new ContainerWidget(width*0.1f, height*0.1f, width*0.8, height*0.8,1000,1000);
  //pieContainer.addWidget(pie); //<>//
  //pieContainer.selectScrollOptions(false,false);
  //pieContainer.redraw(); //<>//
  //screen_piechart.addWidget(pieContainer);
  
  screen_piechart.addWidget(new ButtonWidget(350, 500, "Generate PieChart", 
  () -> {
    pie.setFilterFromUI();   // Obtain the filter fields and values from the UI of PieChart itself
  }
)); 
 //<>//



// PieChart goes back to Histogram
screen_piechart.addWidget(new ButtonWidget(50, 550, "Previous Page", 
  () -> {
    currentScreen = screen_barplot;
  }));
  
  screen_piechart.addWidget(new ButtonWidget(1000, 550, "Next Page", 
  () -> {
    currentScreen = screen_histogram;
  }));
  
  //rightPieScreenBtn = new ButtonWidget(displayWidth*0.85f, displayHeight*0.75f, "Next Page",
  //  () -> { //<>//
  //  currentScreen = screen_histogram;
  //});
  //screen_piechart.addWidget(leftPieScreenBtn);
  //screen_piechart.addWidget(rightPieScreenBtn); //<>//

  // =============================== Histogram Screen ===============================
  HistogramWidget hist = new HistogramWidget(0,600);
  histContainer = new ContainerWidget(50, 50, 600, 600,10000,1000);
  histContainer.addWidget(hist);
  //histContainer.selectScrollOptions(true,false);
  histContainer.redraw();
  screen_histogram.addWidget(hist);
  
  String[] histOptions = {"DEST_WAC", "ORIGIN_WAC", "DEP_TIME", "ARR_TIME"};
  DroplistWidget histDropList = new DroplistWidget(0,0, histOptions);
  hist.setValues(flights.data.getFloatColumn(histDropList.getSelectedString()));
  screen_histogram.addWidget(histDropList);
  ButtonWidget updateHistBtn = new ButtonWidget(500, 600, "Update",
    () -> {
    hist.setCategory(histDropList.getSelectedString());
    hist.setValues(flights.data.getFloatColumn(histDropList.getSelectedString()));
    histContainer.redraw(); //<>//
    }
  ); //<>//
  updateHistBtn.onClick.run(); //<>//
  
  screen_histogram.addWidget(updateHistBtn);
  //leftHistScreenBtn = new ButtonWidget(displayWidth*0.05f, displayHeight*0.75f, "Previous Page",
  //  () -> {
  //  currentScreen = screen_piechart;

  //}
  //));
  screen_histogram.addWidget(new ButtonWidget(50, 600, "Previous Page", 
    () -> {
    currentScreen = screen_piechart;
  } //<>// //<>//
  ));
  screen_histogram.addWidget(new ButtonWidget(750, 600, "Next Page", 
    () -> {
    currentScreen = screen_Scatterplot;
  } //<>// //<>//
  ));
 //<>// //<>//

  // =============================== Scatter plot Screen =============================== //<>//
  // Initializes the scatter plot Widget and both axis - selector dropdownn widgets //<>//
  scatter = new ScatterplotWidget(50, 50, "X", "Y");
  scatterSelectorX = new DroplistWidget(650, 150, flights.columnNames.toArray(new String[0]));
  scatterSelectorX.onSelected = () -> {
    scatter.setPointsX(filters.result.getFloatColumn(scatterSelectorX.getSelectedString())); //<>//
    scatter.text_x = scatterSelectorX.getSelectedString();
    
    if (scatter.getPointsX().length >= 1) {
      scatter.setMinX(StatisticFunctions.min(scatter.getPointsX()));
      scatter.setMaxX(StatisticFunctions.max(scatter.getPointsX()));
    }
  };
  screen_Scatterplot.addWidget(scatterSelectorX);
  scatterSelectorY = new DroplistWidget(1000, 150, flights.columnNames.toArray(new String[0]));
  scatterSelectorY.onSelected = () -> {
    scatter.setPointsY(filters.result.getFloatColumn(scatterSelectorY.getSelectedString()));
    scatter.text_y = scatterSelectorY.getSelectedString();
    
    if (scatter.getPointsY().length >= 1) {
      scatter.setMinY(StatisticFunctions.min(scatter.getPointsY()));
      scatter.setMaxY(StatisticFunctions.max(scatter.getPointsY()));
    }
  };
  
  // Adds the widgets the scatter screen
  screen_Scatterplot.addWidget(scatterSelectorY);
  screen_Scatterplot.addWidget(new LabelWidget(650, 120, "Select X data"));
  screen_Scatterplot.addWidget(new LabelWidget(1000, 120, "Select Y data"));
  scatter.setPointsY(flights.data.getFloatColumn("DISTANCE"));

  scatter.setMinX(-1.0);
  scatter.setMaxX(100.0);
  scatter.setMinY(-10.0);
  scatter.setMaxY(3000.0);
  screen_Scatterplot.addWidget(new ButtonWidget(50, 650, "Previous Page", 
  () -> {
    currentScreen = screen_histogram;
  }
  ));
  screen_Scatterplot.addWidget(scatter);
  filters.apply();
}

public void draw() {
  currentScreen.drawScreen();
}

void keyPressed() {
  currentScreen.onKeyPressed();
  
  if (keyCode == LEFT) {
    container.contentX -= 20.0; //<>// //<>//
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
  currentScreen.onMouseReleased(mouseX, mouseY); //<>// //<>//
}

void mouseDragged() {
  currentScreen.onMouseDragged(mouseX, mouseY);
}

// Changes from buffer as it was inefficient 
class Clip {
  float x;
  float y;
  float w;
  float h;
  
  public Clip(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
}

Clip currentClip = null;
Clip[] clipStack = new Clip[0];

void pushClip(Clip newClip) {
  clipStack = Arrays.copyOf(clipStack, clipStack.length + 1);
  clipStack[clipStack.length - 1] = currentClip;
  currentClip = newClip;
  if (currentClip != null) {
    clip(currentClip.x, currentClip.y, currentClip.w, currentClip.h);
  } else {
    noClip();
  }
}

void popClip() {
  currentClip = clipStack[clipStack.length - 1];
  clipStack = Arrays.copyOf(clipStack, clipStack.length - 1);
  if (currentClip != null) {
    clip(currentClip.x, currentClip.y, currentClip.w, currentClip.h);
  } else {
    noClip();
  }
}
