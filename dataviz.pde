/* Resources */ //<>// //<>// //<>// //<>// //<>// //<>//
PFont mainFont;
public static PShape checkmarkShape = null;
public static PShape arrowdownShape = null;
public static PShape arrowupShape = null;
public static PShape binShape = null;

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

ButtonWidget rightHomeScreenBtn = new ButtonWidget(100,200);
ButtonWidget leftFilterScreenBtn = new ButtonWidget(100, 100);
ButtonWidget rightFilterScreenBtn = new ButtonWidget(100, 200);
ButtonWidget leftTableScreenBtn = new ButtonWidget(100, 100);
ButtonWidget rightTableScreenBtn = new ButtonWidget(100, 200);
ButtonWidget leftBarScreenBtn = new ButtonWidget(100, 100);
ButtonWidget rightBarScreenBtn = new ButtonWidget(100, 200);
ButtonWidget leftPieScreenBtn = new ButtonWidget(100, 100);
ButtonWidget rightPieScreenBtn = new ButtonWidget(100, 200);
ButtonWidget leftHistScreenBtn = new ButtonWidget(100, 100);
ButtonWidget rightHistScreenBtn = new ButtonWidget(100, 200);

PImage bg;
int y;

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

  PieChartWidget pie;  // Announce the declaration of pie for filters.onApply part
void setup() {
  size(1000, 900);
  surface.setTitle("Plane flights data Visualizer");
  surface.setResizable(true);
  tb = getGraphics();

  loadResources();
  flights.loadData("flights2kCleaned.csv");


  currentScreen = new Screen(color(245, 245, 245));


  //bar = new BarplotWidget(400, 50);
  //currentScreen.addWidget(bar);

  bg = loadImage("Flight.jpg");

  // Added by Haojin 27/03/2025
  // Modified and cleaned by William 02/04
  // Display all different screens

  Screen screen_home = new Screen();
  Screen screen_query = new Screen(color(245, 245, 245));
  Screen screen_table = new Screen(color(245, 245, 245));
  Screen screen_barplot = new Screen(color(245, 245, 245));
  Screen screen_histogram = new Screen(color(245, 245, 245));
  Screen screen_piechart = new Screen(color(245, 245, 245));  // added by Damon
  Screen screen_Scatterplot = new Screen(color(245, 245, 245));

  // Home screen
  currentScreen = screen_home;
  screen_home.addWidget(new LabelWidget(250, 300, "This is Home Page", 40));
  screen_home.addWidget(new LabelWidget(250, 400, "Welcome to the flights data visualizer!"));
  screen_home.addWidget(new LabelWidget(250, 450, "Click next page to continue."));
  
  rightHomeScreenBtn = new ButtonWidget(displayWidth*0.85f, displayHeight*0.75f, "Next Page",
    () -> {
    currentScreen = screen_query;
  });
  screen_home.addWidget(rightHomeScreenBtn);
  
  
  
  // Filter Screen
  leftFilterScreenBtn = new ButtonWidget(displayWidth*0.05f, displayHeight*0.75f, "Previous Page",
    () -> {
    currentScreen = screen_home;
  });
  rightFilterScreenBtn = new ButtonWidget(displayWidth*0.85f, displayHeight*0.75f, "Next Page",
    () -> {
    currentScreen = screen_table;
  });
  
  screen_query.addWidget(leftFilterScreenBtn);
  screen_query.addWidget(rightFilterScreenBtn);
  LabelWidget l = new LabelWidget(50, 50, "Filters and sorting here applies to all the graphs on the following pages.");
  l.fontSize = 24;
  screen_query.addWidget(l);
  // QueryingWidget
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
    barContainer.redraw();
    
     pie.setFilterFromUI();
  };
  screen_query.addWidget(filters);


  //currentScreen = screen_home;
  //screen_home.addWidget(new LabelWidget(250, 300, "Flights visualizer", 40));
  //screen_home.addWidget(new LabelWidget(250, 400, "Welcome to the flights data visualizer!"));
  //screen_home.addWidget(new LabelWidget(250, 450, "Click next page to continue."));
  
  
  //  ================= Table Screen ====================
  leftTableScreenBtn = new ButtonWidget(displayWidth*0.05f, displayHeight*0.75f, "Previous Page",
    () -> {
    currentScreen = screen_query;
  });
  rightTableScreenBtn = new ButtonWidget(displayWidth*0.85f, displayHeight*0.75f, "Next Page",
    () -> {
    currentScreen = screen_barplot;
  });
  screen_table.addWidget(leftTableScreenBtn);
  screen_table.addWidget(rightTableScreenBtn);
  table = new TableWidget(width*0.1f, height*0.1f, filters.result);
  container = new ContainerWidget(width*0.1f, height*0.1f, width*0.8, height*0.8, 4000, 10000); // edited by William value changed from 100000 to 10000
  container.addWidget(table);
  container.selectScrollOptions(true, true);
  screen_table.addWidget(container);

  // =============================== Barplot Screen ===============================
  bar = new BarplotWidget(100, 100);
 //<>//
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
    barContainer.redraw();
  };  
  barContainer = new ContainerWidget(width*0.1f, height*0.1f, width*0.8, height*0.8,width,8000);
  barContainer.addWidget(bar);
  barContainer.selectScrollOptions(false,true);
  barContainer.redraw();
  screen_barplot.addWidget(barContainer);
  leftBarScreenBtn = new ButtonWidget(displayWidth*0.05f, displayHeight*0.75f, "Previous Page",
    () -> {
    currentScreen = screen_table;
  });
  rightBarScreenBtn = new ButtonWidget(displayWidth*0.85f, displayHeight*0.75f, "Next Page",

    () -> {
    currentScreen = screen_piechart;
  });
  screen_barplot.addWidget(leftBarScreenBtn);
  screen_barplot.addWidget(rightBarScreenBtn);
  
  

  // =============================== Pie Chart Screen ===============================
  // Add the PieChart screen by Damon
  // Edited by William

  pie = new PieChartWidget(100, 100, filters); // get QueryingWidget Filter
  screen_piechart.addWidget(pie);
  //pieContainer = new ContainerWidget(width*0.1f, height*0.1f, width*0.8, height*0.8,1000,1000);
  //pieContainer.addWidget(pie);
  //pieContainer.selectScrollOptions(false,false);
  //pieContainer.redraw();
  //screen_piechart.addWidget(pieContainer);
  
  screen_piechart.addWidget(new ButtonWidget(350, 500, "Generate PieChart", 
  () -> {
    pie.setFilterFromUI();   // Obtain the filter fields and values from the UI of PieChart itself
  }
)); 

  leftPieScreenBtn = new ButtonWidget(displayWidth*0.05f, displayHeight*0.75f, "Previous Page",
    () -> {
    currentScreen = screen_barplot;
  });
  rightPieScreenBtn = new ButtonWidget(displayWidth*0.85f, displayHeight*0.75f, "Next Page",
    () -> {
    currentScreen = screen_histogram;
  });
  screen_piechart.addWidget(leftPieScreenBtn);
  screen_piechart.addWidget(rightPieScreenBtn); //<>//

  // =============================== Histogram Screen ===============================
  HistogramWidget hist = new HistogramWidget(width*0.1f, height*0.8f);
  histContainer = new ContainerWidget(width*0.1f, height*0.1f, width*0.8, height*0.8,10000,1000);
  histContainer.addWidget(hist);
  histContainer.selectScrollOptions(true,false);
  histContainer.redraw();
  screen_histogram.addWidget(histContainer);
  
  String[] histOptions = {"DEST_WAC", "ORIGIN_WAC", "DEP_TIME", "ARR_TIME"};
  DroplistWidget histDropList = new DroplistWidget(0,0, histOptions);
  hist.setValues(flights.data.getFloatColumn(histDropList.getSelectedString()));
  screen_histogram.addWidget(histDropList);
  ButtonWidget updateHistBtn = new ButtonWidget(500, 600, "Update",
    () -> {
    hist.setCategory(histDropList.getSelectedString());
    hist.setValues(flights.data.getFloatColumn(histDropList.getSelectedString()));
    histContainer.redraw();
    }
  );
  updateHistBtn.onClick.run(); //<>//
  
  screen_histogram.addWidget(updateHistBtn);
  leftHistScreenBtn = new ButtonWidget(displayWidth*0.05f, displayHeight*0.75f, "Previous Page",
    () -> {
    currentScreen = screen_piechart;
 });
  screen_histogram.addWidget(leftHistScreenBtn);
   //<>//

  // =============================== Scatter plot Screen ===============================
  
    //btn = new ButtonWidget(350, 100, "Click me!", () -> {
  //  interest = input.getText();
  //  scatter.setPointsX(flights.data.getFloatColumn(interest));
  //}
  //);
  scatter = new ScatterplotWidget(50, 50, "X", "Y");
  scatterSelectorX = new DroplistWidget(650, 200, flights.columnNames.toArray(new String[0]));
  scatterSelectorX.onSelected = () -> {
    scatter.setPointsX(filters.result.getFloatColumn(scatterSelectorX.getSelectedString()));
  };
  screen_Scatterplot.addWidget(scatterSelectorX);
  scatterSelectorY = new DroplistWidget(650, 500, flights.columnNames.toArray(new String[0]));
  scatterSelectorY.onSelected = () -> {
    scatter.setPointsY(filters.result.getFloatColumn(scatterSelectorY.getSelectedString()));
  };
  screen_Scatterplot.addWidget(scatterSelectorY);
  screen_Scatterplot.addWidget(new LabelWidget(650, 180, "Select X data"));
  screen_Scatterplot.addWidget(new LabelWidget(650, 480, "Select Y data"));
  //scatter.setPointsX(flights.data.getFloatColumn("ORIGIN_WAC"));
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
  
  rightHomeScreenBtn.setPosition(width*0.85f, height*0.9f,"Next Page");
  leftFilterScreenBtn.setPosition(width*0.05f, height*0.9f,"Previous Page");
  rightFilterScreenBtn.setPosition(width*0.85f, height*0.9f,"Next Page");
  leftTableScreenBtn.setPosition(width*0.05f, height*0.9f,"Previous Page");
  rightTableScreenBtn.setPosition(width*0.85f, height*0.9f,"Next Page");
  leftBarScreenBtn.setPosition(width*0.05f, height*0.9f,"Previous Page");
  rightBarScreenBtn.setPosition(width*0.85f, height*0.9f,"Next Page");
  leftPieScreenBtn.setPosition(width*0.05f, height*0.9f,"Previous Page");
  rightPieScreenBtn.setPosition(width*0.85f, height*0.9f,"Next Page");
  leftHistScreenBtn.setPosition(width*0.05f, height*0.9f,"Previous Page");
  
  container.setPosition(width*0.01f,height*0.01f, width*0.9f, height*0.8f);
  barContainer.setPosition(width*0.01f,height*0.01f, width*0.9f, height*0.8f);
  histContainer.setPosition(width*0.01f,height*0.01f, width*0.9f, height*0.8f);
  //pieContainer.setPosition(width*0.4f,height*0.4f, width*0.8f, height*0.8f);
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
