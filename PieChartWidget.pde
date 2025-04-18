import java.util.*; 

public class PieChartWidget extends Widget {
  QueryingWidget filters;              // Change the logic toget data from filter.result
  DroplistWidget fieldSelector;       // For adding a dropbox

 // Show the PieChart data and state
   ArrayList<String> labels = new ArrayList<>();   // Stores the labels (categories) for the pie chart
   ArrayList<Float> values = new ArrayList<>();    // Stores the corresponding values
  
  String fieldName = "";
  String filterValue = "";

 // Create field selector using available fields
 PieChartWidget(float x, float y, QueryingWidget filters) {
    this.x = x;
    this.y = y;

    this.filters = filters;
    
    this.fieldSelector = new DroplistWidget(500, 50, filters.getAvailableFields()); 

  }

 public void setFilterFromUI() {
    String field = fieldSelector.getSelectedString();  // Get selected field from dropdown

    labels.clear();
    values.clear();

    Table result = filters.result;  // Read the results from the filter
    if (result == null || result.getRowCount() == 0) return;
    
    // Using the hashmap to count frequency of each unique value
    HashMap<String, Integer> counter = new HashMap<>();

    // Iterate through filtered table rows and build frequency map
    for (TableRow row : result.rows()) {
      String key = row.getString(field);
      if (key == null) continue;
      counter.put(key, counter.getOrDefault(key, 0) + 1);
    }
    
    // Convert frequency map into labels and values lists
    for (String key : counter.keySet()) {
      labels.add(key);
      values.add((float) counter.get(key));
    }
  }

  @Override
  public void draw() {
    fieldSelector.draw(); // Draw the dropdown selector
    
    if (labels == null || values == null || labels.size() == 0) return;
    
    colorMode(HSB, 255);  // For multiple colors in the piechart
    float total = 0;
    for (float v : values) total += v;

    float angle = 0;
    color[] palette = new color[labels.size()];
    for (int i = 0; i < labels.size(); i++) {
       float hue = map(i, 0, labels.size(), 0, 255);
       palette[i] = color(hue, 200, 255);   // for each new category we find from the dropbox we selected, assign a new unique color 
   }

    // Draw the pie sector corresponding to each category
    for (int i = 0; i < values.size(); i++) {
    float value = values.get(i);
    float angleSize = map(value, 0, total, 0, TWO_PI);

    fill(palette[i]);
    arc(x, y, 200, 200, angle, angle + angleSize);

    angle += angleSize;
  }

    // Draw legends next to the pie chart
    fill(0);
    textSize(12);
    for (int i = 0; i < labels.size(); i++) {
   // Draw the color cube for each legend(added by Damon on 03/04/2025)
     fill(palette[i]);
     rect(x + 150, y - 80 + i * 20, 12, 12);

  // Draw the corresponding label text
     fill(0);
      float percentage = values.get(i) / total * 100;
      String labelWithPercent = labels.get(i) + String.format(" (%.1f%%)", percentage);  // Display the percentage after the label
      text(labelWithPercent, x + 170, y - 70 + i * 20);  
     
     // Displyay the title for the piechart graph in real time
      fill(0);
      textAlign(LEFT);
      textSize(14);
      text("PieChart: " + fieldName + " = " + filterValue, x - 100, y - 120); 
      
       colorMode(RGB);  // Exit the multiple colors mode
     }
  }
     
      
  @Override
  public boolean onMouseClicked(int mx, int my) {
  fieldSelector.onMouseClicked(mx, my);  // Forward click to dropdown
  return false;  
  }

  @Override
  public void onMouseMoved(int mx, int my) {
    fieldSelector.onMouseMoved(mx, my);  // Forward movement to dropdown
  }
}
