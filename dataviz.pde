/* Resources */
PFont mainFont;
public static PShape checkmarkShape = null;
public ArrayList<DataLoading> dataFiles = new ArrayList<>();
DataLoading flights = new DataLoading();
Screen currentScreen;
TextFieldWidget focusedTextField = null;  // Added on 17/03/2025 by Damon
ScatterplotWidget scatter = new ScatterplotWidget(50, 50, "X", "Y");
TextFieldWidget input = new TextFieldWidget(550, 50, 200, 40, "Enter Airport Code" );
ButtonWidget btn;

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

  btn = new ButtonWidget(350, 100, "Click me!", () -> {
    interest = input.getText();
    scatter.setPointsX(flights.data.getFloatColumn(interest));
  });
  
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
  
   filters = new QueryingWidget(50, 50);
   currentScreen.addWidget(filters);
   
   
   
  //currentScreen.addWidget(new ButtonWidget(250, 100, "Click me!", () -> { println("Button clicked!"); }));
  //currentScreen.addWidget(new CheckboxWidget(450, 100));
  //currentScreen.addWidget(new ScatterplotWidget(600, 10));
  //currentScreen.addWidget(new CalendarWidget(50, 250));
  //currentScreen.addWidget(new LabelWidget(100, 200, "LabelWIdget"));
  
  // Added by Haojin 27/03/2025
  // Display all different screens
  
  Screen screen_home = new Screen(color(245, 245, 245));
  Screen screen_barplot = new Screen(color(245, 245, 245));
  Screen screen_calendar = new Screen(color(245, 245, 245));
  Screen screen_histogram = new Screen(color(245, 245, 245));
  Screen screen_Scatterplot = new Screen(color(245, 245, 245));
  
  currentScreen = screen_home;
  screen_home.addWidget(new LabelWidget(375, 300, "This is Home Page"));
  
  screen_home.addWidget(new ButtonWidget(750, 550, "Next Page", 
    () -> {
        currentScreen = screen_barplot;
    }
  ));
  
  screen_barplot.addWidget(new BarplotWidget(100, 0));
  screen_barplot.addWidget(new ButtonWidget(50, 550, "Previous Page", 
    () -> {
        currentScreen = screen_home;
    }
  ));
  screen_barplot.addWidget(new ButtonWidget(750, 550, "Next Page", 
    () -> {
        currentScreen = screen_calendar;
    }
  ));
  
  screen_calendar.addWidget(new CalendarWidget(0, 0));
  screen_calendar.addWidget(new ButtonWidget(50, 550, "Previous Page", 
    () -> {
        currentScreen = screen_barplot;
    }
  ));
  screen_calendar.addWidget(new ButtonWidget(750, 550, "Next Page", 
    () -> {
        currentScreen = screen_histogram;
    }
  ));
  
  // screen_histogram.addWidget(new HistogramWidget(0, 0));
  screen_histogram.addWidget(new ButtonWidget(50, 550, "Previous Page", 
    () -> {
        currentScreen = screen_calendar;
    }
  ));
  screen_histogram.addWidget(new ButtonWidget(750, 550, "Next Page", 
    () -> {
        currentScreen = screen_Scatterplot;
    }
  ));
  
  screen_Scatterplot.addWidget(new ScatterplotWidget(100, 0, "Sample X", "Sample Y"));
  screen_Scatterplot.addWidget(new ButtonWidget(50, 550, "Previous Page", 
    () -> {
        currentScreen = screen_histogram;
    }
  ));

}

void draw() {
  currentScreen.drawScreen();
}

void keyTyped() {
  currentScreen.onKeyTyped(key);
}


void mouseClicked() {
  currentScreen.onMouseClicked(mouseX, mouseY);
}

void mouseMoved() {
  currentScreen.onMouseMoved(mouseX, mouseY);
}
