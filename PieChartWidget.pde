import java.util.*; 

public class PieChartWidget extends Widget {
  Table data;
  String field;
  String airportCode;

  Map<String, Integer> dataMap;
  ArrayList<String> labels = new ArrayList<>();
  ArrayList<Float> values = new ArrayList<>();

  PieChartWidget(float x, float y, Table data) {
    this.x = x;
    this.y = y;
    this.data = data;
    this.field = "Origin"; 
    this.dataMap = new HashMap<>();
    
    colorMode(HSB, 255);  // For multiple colors in the piechart

  }

  public void setField(String f) {
  this.field = f;
  this.dataMap = new HashMap<String, Integer>();

  for (TableRow row : data.rows()) {
    String value = row.getString(field);
    if (value == null) continue;
    dataMap.put(value, dataMap.getOrDefault(value, 0) + 1);
  }
}

  public void setFilter(String airportCode) {
    this.airportCode = airportCode;

    // clear the data before
    this.labels.clear();
    this.values.clear();

    // Iterate over all rows in the CSV data and count the number of destination occurrences
    HashMap<String, Integer> destinationCount = new HashMap<>();

    for (TableRow row : data.rows()) {
      String origin = row.getString("ORIGIN");
      String dest = row.getString("DEST");

      if (origin.equalsIgnoreCase(airportCode)) {
        destinationCount.put(dest, destinationCount.getOrDefault(dest, 0) + 1);
      }
    }

    // Convert to labels and values for PieChart plotting
    for (String dest : destinationCount.keySet()) {
      labels.add(dest);
      values.add((float) destinationCount.get(dest));
    }
  }

  @Override
  public void draw() {
    if (labels == null || values == null || labels.size() == 0) return;

    float total = 0;
    for (float v : values) total += v;

    float angle = 0;
    color[] palette = new color[labels.size()];
    for (int i = 0; i < labels.size(); i++) {
       float hue = map(i, 0, labels.size(), 0, 255);
       palette[i] = color(hue, 200, 255);
   }

    for (int i = 0; i < values.size(); i++) {
    float value = values.get(i);
    float angleSize = map(value, 0, total, 0, TWO_PI);

    tb.fill(palette[i]);
    tb.arc(x, y, 200, 200, angle, angle + angleSize);

    angle += angleSize;
  }

    // Draw legends next to the pie chart
    tb.fill(0);
    tb.textSize(12);
    for (int i = 0; i < labels.size(); i++) {
   // Draw the color cube for each legend(added by Damon on 03/04/2025)
     tb.fill(palette[i]);
     tb.rect(x + 150, y - 80 + i * 20, 12, 12);

  // Draw the corresponding label text
     tb.fill(0);
      float percentage = values.get(i) / total * 100;
      String labelWithPercent = labels.get(i) + String.format(" (%.1f%%)", percentage);
      tb.text(labelWithPercent, x + 170, y - 70 + i * 20);  
     
     }
  }
}
