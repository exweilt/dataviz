public class QueryingWidget extends Widget {
  public color fontColor = color (0);
  public float fontSize = 26;

  ButtonWidget addBtn;
  ButtonWidget applyBtn;
  //ArrayList<String[]> filters; // Only 0 and 1 indicies, key : value

  ArrayList<DroplistWidget> droplists;
  ArrayList<TextFieldWidget> inputs;
  ArrayList<ButtonWidget> deleteButtons;
  Runnable onApply;
  CheckboxWidget sortCheckbox;
  DroplistWidget sortColumn;
  DroplistWidget sortType;
  
  public Table result = null;

  public QueryingWidget(float x_in, float y_in) {
    this.x = x_in;
    this.y = y_in;

    //this.filters = new ArrayList<String[]>();

    droplists = new ArrayList<DroplistWidget>();
    inputs = new ArrayList<TextFieldWidget>();
    deleteButtons = new ArrayList<ButtonWidget>();

    this.addBtn = new ButtonWidget(this.x, this.y, "+", () -> {
      this.addFilter();
    });

    this.applyBtn = new ButtonWidget(this.x + 490, this.y, "Apply selection", () -> {
      this.apply();
    });
    
    sortCheckbox = new CheckboxWidget(this.x + 770, this.y - 5);
    sortColumn = new DroplistWidget(this.x + 700, this.y + 50, flights.columnNames.toArray(new String[0]));
    sortType = new DroplistWidget(this.x + 980, this.y + 50, new String[] {"Ascending", "Descending"});
    
    reposition();
    this.apply();
  }

  @Override
  public void draw() {
    textAlign(LEFT, TOP);

    fill(fontColor);
    textSize(this.fontSize);
    text("Filters", this.x, this.y);

    if (droplists.size() == 0) {
      fill(140);
      text("No filters applied.", this.x, this.y + 50);
    } 
    //else {
    //  this.droplists.get(0).y = 600;
    //}
    
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

    addBtn.draw();
    applyBtn.draw();
    
    if (activeDroplist != null)
      activeDroplist.draw();
    
    textAlign(LEFT, TOP);
    fill(fontColor);
    textSize(this.fontSize);
    text("Sort", this.x + 700, this.y);
    this.sortCheckbox.draw();
    this.sortColumn.draw();
    this.sortType.draw();
  }

  void reposition() {
    //droplists = new ArrayList<DroplistWidget>();
    //inputs = new ArrayList<TextFieldWidget>();
    //deleteButtons = new ArrayList<ButtonWidget>();

    float currentY = this.y + 70.0;
    for (int i = 0; i < this.droplists.size(); i++) {
      final int finalIdx = i;
      
      //// Generate new //<>//
      //if (i >= droplists.size()) {
      //  DroplistWidget newDrop = new DroplistWidget(this.x, currentY, flights.columnNames.toArray(new String[0]));
      //  droplists.add(newDrop); //<>// //<>//
        
      //  TextFieldWidget newInput = new TextFieldWidget(this.x + newDrop.width + 15.0, currentY, 120., 40., "");
      //  newInput.h = newDrop.mainButton.height;
      //  inputs.add(newInput);   
        
      //  ButtonWidget newDelete = new ButtonWidget(newInput.x + newInput.w + 15.0, currentY, "", () -> {
      //    deleteFilter(finalIdx);
      //  }); //<>//
      //  newDelete.fixedWidth = true;
      //  newDelete.width = newDelete.height;
      //  newDelete.setOptionalIcon(binShape); //<>// //<>//
      //  deleteButtons.add(newDelete);
      //}
      
      //DroplistWidget newDrop = new DroplistWidget(this.x, currentY, flights.columnNames.toArray(new String[0]));
      //droplists.add(newDrop);
      droplists.get(i).y = currentY;
      droplists.get(i).updateButtons();
      
      //TextFieldWidget newInput = new TextFieldWidget(this.x + newDrop.width + 15.0, currentY, 120., 40., "");
      //newInput.h = newDrop.mainButton.height;
      //inputs.add(newInput);
      inputs.get(i).y = currentY;
      
      //ButtonWidget newDelete = new ButtonWidget(newInput.x + newInput.w + 15.0, currentY, "", () -> {
      //  deleteFilter(finalIdx);
      //});
      //newDelete.fixedWidth = true;
      //newDelete.width = newDelete.height;
      //newDelete.setOptionalIcon(binShape);
      //deleteButtons.add(newDelete);
      deleteButtons.get(i).y = currentY;

      currentY += 50.0;
    }
    
    //// Hotfix
    //if (droplists.length > 0) {
    //  droplists[droplists.length - 1].setListDropped(false);
    //}

    currentY += 40;
    this.addBtn.y = currentY; //<>//

    this.applyBtn.y = currentY;
  }
  
  void apply() {
    result = flights.data.copy();
    result.clearRows(); //<>//
    
    for (TableRow row : flights.data.rows()) {
      boolean wasMet = true;
      for (int i = 0; i < droplists.size(); i++) {
        if (!row.getString(droplists.get(i).getSelectedString()).toLowerCase().contains(inputs.get(i).text.toLowerCase()))  {
          wasMet = false;
          break;
        }
      } //<>//
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
    
    //println(result.getRowCount());
    //this.result = result; //<>//
    
    if (this.onApply != null) {
      this.onApply.run();
    }
    //bar.categoriesX = StatisticFunctions.absoluteFrequency(result.getStringColumn("ORIGIN")).keySet().toArray(new String[0]);
  }

  void addFilter() {
    //this.filters.add(new String[]{"", ""});
      DroplistWidget newDrop = new DroplistWidget(this.x, 0, flights.columnNames.toArray(new String[0]));
      droplists.add(newDrop);
      
      TextFieldWidget newInput = new TextFieldWidget(this.x + newDrop.width + 15.0, 0, 120., 40., "");
      newInput.h = newDrop.mainButton.height;
      inputs.add(newInput);   
      
      //int lastIdx = droplists.size() - 1;
      ButtonWidget newDelete = new ButtonWidget(newInput.x + newInput.w + 15.0, 0, "", () -> {
        deleteFilter(newDrop);
      });
      newDelete.fixedWidth = true;
      newDelete.width = newDelete.height;
      newDelete.setOptionalIcon(binShape);
      deleteButtons.add(newDelete);
      
    this.reposition();
  }

  void deleteFilter(int idx) {
    //this.filters.remove(idx);
    droplists.remove(idx);
    inputs.remove(idx);
    deleteButtons.remove(idx);
    this.reposition();
  }
  
  void deleteFilter(DroplistWidget drop) {
    //this.filters.remove(idx);
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
    for (DroplistWidget d : this.droplists) {
      if (d.onMouseClicked(mX, mY))
        return true;
    }
    
    for (TextFieldWidget i : this.inputs) {
      i.onMouseClicked(mX, mY);
    }
    
    for (int i = 0; i < deleteButtons.size(); i++) {
      this.deleteButtons.get(i).onMouseClicked(mX, mY);
    }
    
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
