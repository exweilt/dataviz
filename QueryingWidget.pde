/**
  * Querying GUI widget.
  *
  * Groups together buttons used for specifying filters and sorting over the data
  *   and performs selection. The selected data then can be accessed with
  *   query.result member which is Table.
  *
  * Every filter is a group of 3 elements:
  *   - Droplist (for column selection)
  *   - Text field (for value to be equal)
  *   - Delete button
  * And they are stored inside ArrayLists each element has its own ArrayList.
  *
  *
  * (c) Created by Alexey
  */
public class QueryingWidget extends Widget {
  public color fontColor = color(0);
  public float fontSize = 26;

  public Runnable onApply; // Optional function which should be called after the new filters were applied

  public Table result = null;   // The result of selection. Updated when apply button is clicked.

  private ButtonWidget addBtn;    // The button to add new filters
  private ButtonWidget applyBtn;  // The button to run selection

  private ArrayList<DroplistWidget> droplists;
  private ArrayList<TextFieldWidget> inputs;
  private ArrayList<ButtonWidget> deleteButtons;

  private CheckboxWidget sortCheckbox;  // Whether it should sort the data
  private DroplistWidget sortColumn;    // The column to sort by
  private DroplistWidget sortType;      // The sorting direction (Ascending or Descending)

  /**
    * Construct the Querying Widget.
    *
    */
  public QueryingWidget(float x, float y) {
    this.x = x;
    this.y = y;

    // Create empty lists for filter elements
    droplists = new ArrayList<DroplistWidget>();
    inputs = new ArrayList<TextFieldWidget>();
    deleteButtons = new ArrayList<ButtonWidget>();

    // Create add filter button
    this.addBtn = new ButtonWidget(this.x, this.y, "+", () -> {
      this.addFilter();
    });

    // Create "apply selection" button
    this.applyBtn = new ButtonWidget(this.x + 490, this.y, "Apply selection", () -> {
      this.apply();
    });
    
    // Create button for sorting
    sortCheckbox = new CheckboxWidget(this.x + 770, this.y - 5);
    sortColumn = new DroplistWidget(this.x + 700, this.y + 50, flights.columnNames.toArray(new String[0]));
    sortType = new DroplistWidget(this.x + 980, this.y + 50, new String[] {"Ascending", "Descending"});
    
    reposition(); // Update buttons' positions automatically
    this.apply(); // Set result to something
  }

  @Override
  public void draw() {
    textAlign(LEFT, TOP);

    // Draw filters text
    fill(fontColor);
    textSize(this.fontSize);
    text("Filters", this.x, this.y);

    // Draw no filters text if there is no filters yet.
    if (droplists.size() == 0) {
      fill(140);
      text("No filters applied.", this.x, this.y + 50);
    } 
    
    // Iterate through elements and draw them.
    // In the case of droplist we may draw them part by part by part to allow for drawing "on top"
    DroplistWidget activeDroplist = null;
    for (int i = 0; i < droplists.size(); i++) {
      if (droplists.get(i).isListDropped) {
        activeDroplist = droplists.get(i);
      } else {
        this.droplists.get(i).draw();
      }
      this.inputs.get(i).draw();
      this.deleteButtons.get(i).draw();
    }

    if (activeDroplist != null) //<>//
      activeDroplist.draw();  // Draw the current dropped list after all the others so it is on top!

    // Draw buttons //<>//
    this.addBtn.draw();
    this.applyBtn.draw();
    
    // Draw elements for sorting
    textAlign(LEFT, TOP);
    fill(fontColor);
    textSize(this.fontSize);
    text("Sort", this.x + 700, this.y); //<>//
    this.sortCheckbox.draw();
    this.sortColumn.draw();
    this.sortType.draw(); //<>//
  }

  /**
    * Update y positions of all buttons according to the order.
    *
    */
  public void reposition() {
    float currentY = this.y + 70.0;
    for (int i = 0; i < this.droplists.size(); i++) {
      droplists.get(i).y = currentY;
      droplists.get(i).updateButtons();
      
      inputs.get(i).y = currentY;
      deleteButtons.get(i).y = currentY;

      currentY += 50.0;
    }

    currentY += 40;
    this.addBtn.y = currentY;

    this.applyBtn.y = currentY;
  }
  
  /**
    * Filter the data and sort it. Load it inside result.
    *
    */
  void apply() {
    result = flights.data.copy();
    result.clearRows();   // Reset result table, but copy column titles!
    
    // For each row and for each filter if every filter is met append the row to the result. 
    for (TableRow row : flights.data.rows()) {
      boolean wasMet = true;
      for (int i = 0; i < droplists.size(); i++) {
        if (!row.getString(droplists.get(i).getSelectedString()).toLowerCase().contains(inputs.get(i).text.toLowerCase()))  {
          wasMet = false;
          break; 
        }
      } 
      if (wasMet) {
        result.addRow(row);
      }
    }
    

    // Optional sorting
    if (this.sortCheckbox.isChecked) {
      if (sortType.getSelectedString() == "Ascending") {
        result.sort(sortColumn.getSelectedString());
      } else {
        result.sortReverse(sortColumn.getSelectedString());
      }
    }
    
    if (this.onApply != null) {
      this.onApply.run(); // Call optional function to notify
    }
  }
  
  // added by Damon for Piechart logic
  public String[] getAvailableFields() {
    if (flights != null && flights.data != null) {
      return flights.data.getColumnTitles();
    }
    return new String[0];
  }

  // Create new filter
  void addFilter() {
    // Create new droplist
    DroplistWidget newDrop = new DroplistWidget(this.x, 0, flights.columnNames.toArray(new String[0]));
    droplists.add(newDrop);
    
    // Create new input element
    TextFieldWidget newInput = new TextFieldWidget(this.x + newDrop.width + 15.0, 0, 120., 40., "");
    newInput.h = newDrop.mainButton.height;
    inputs.add(newInput);   
    
     // Create new delete button
    ButtonWidget newDelete = new ButtonWidget(newInput.x + newInput.w + 15.0, 0, "", () -> {
      deleteFilter(newDrop);
    });
    newDelete.fixedWidth = true;
    newDelete.width = newDelete.height;
    newDelete.setOptionalIcon(binShape);
    deleteButtons.add(newDelete);
      
    // Update positions
    this.reposition();
  }

  /**
    * Delete elements of filter at index idx
    *
    */
  void deleteFilter(int idx) {
    droplists.remove(idx);
    inputs.remove(idx);
    deleteButtons.remove(idx);
    this.reposition();
  }
  
  /**
    * Delete elements of filter given some droplist object.
    *
    */
  void deleteFilter(DroplistWidget drop) {
    int idx = droplists.indexOf(drop);
    if (idx >= 0) {
      droplists.remove(idx);
      inputs.remove(idx);
      deleteButtons.remove(idx);
      this.reposition();
    }
  }

  @Override
  public boolean onMouseClicked(int mX, int mY) {
    // Handle droplists
    for (DroplistWidget d : this.droplists) {
      if (d.onMouseClicked(mX, mY))
        return true;
    }
    
    // Handle text fields
    for (TextFieldWidget i : this.inputs) {
      i.onMouseClicked(mX, mY);
    }
    
    // Handle delete buttons
    for (int i = 0; i < deleteButtons.size(); i++) {
      this.deleteButtons.get(i).onMouseClicked(mX, mY);
    }
    
    // Handle the rest
    this.addBtn.onMouseClicked(mX, mY);
    this.applyBtn.onMouseClicked(mX, mY);
    
    this.sortCheckbox.onMouseClicked(mX, mY);
    this.sortColumn.onMouseClicked(mX, mY);
    this.sortType.onMouseClicked(mX, mY);
    
    return false;
  }

  @Override
  public void onMouseMoved(int mX, int mY) {
    this.addBtn.onMouseMoved(mX, mY);
    this.applyBtn.onMouseMoved(mX, mY);

    for (DroplistWidget d : this.droplists) {
      d.onMouseMoved(mX, mY);
    }
    
    for (TextFieldWidget i : this.inputs) {
      i.onMouseMoved(mX, mY);
    }
    
    for (ButtonWidget b : this.deleteButtons) {
      b.onMouseMoved(mX, mY);
    }
  }
  
  @Override
  public void onKeyPressed() {
    for (TextFieldWidget i : this.inputs) {
      i.onKeyPressed();
    }
  }
}
