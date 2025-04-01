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
    int colorIdx = 0;
    color[] palette = { color(200, 100, 100), color(100, 200, 150), color(100, 100, 250), color(250, 180, 50) };

    for (int i = 0; i < values.size(); i++) {
      float value = values.get(i);
      float angleSize = map(value, 0, total, 0, TWO_PI);

      fill(palette[colorIdx % palette.length]);
      arc(x, y, 200, 200, angle, angle + angleSize);

      angle += angleSize;
      colorIdx++;
    }

    // Draw legends next to the pie chart
    fill(0);
    textSize(12);
    for (int i = 0; i < labels.size(); i++) {
      text(labels.get(i), x + 150, y - 80 + i * 20);
    }
  }
}
