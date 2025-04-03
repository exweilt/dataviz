public class QueryingWidget extends Widget {
  public color fontColor = color (0);
  public float fontSize = 26;

  ButtonWidget addBtn;
  ButtonWidget applyBtn;
  ArrayList<String[]> filters; // Only 0 and 1 indicies, key : value

  ArrayList<DroplistWidget> droplists;
  ArrayList<TextFieldWidget> inputs;
  ArrayList<ButtonWidget> deleteButtons;
  
  public Table result = null;

  public QueryingWidget(float x_in, float y_in) {
    this.x = x_in;
    this.y = y_in;

    this.filters = new ArrayList<String[]>();

    droplists = new ArrayList<DroplistWidget>();
    inputs = new ArrayList<TextFieldWidget>();
    deleteButtons = new ArrayList<ButtonWidget>();

    this.addBtn = new ButtonWidget(this.x, this.y, "+", () -> {
      this.addFilter();
    });

    this.applyBtn = new ButtonWidget(this.x + 100, this.y, "Apply", () -> {
      this.apply();
    });
    
    reposition();
    this.apply();
  }

  @Override
  public void draw() {
    textAlign(LEFT, TOP);

    fill(this.fontColor);
    textSize(this.fontSize);
    text("Filters", this.x, this.y);

    if (filters.size() == 0) {
      fill(140);
      text("No filters applied.", this.x, this.y + 50);
    }
    
    DroplistWidget activeDroplist = null;
    for (int i = 0; i < filters.size(); i++) {
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
  }

  void reposition() {
    droplists = new ArrayList<DroplistWidget>();
    inputs = new ArrayList<TextFieldWidget>();
    deleteButtons = new ArrayList<ButtonWidget>();

    float currentY = this.y + 70.0;
    for (int i = 0; i < this.filters.size(); i++) {
      final int finalIdx = i;
      
      //// Generate new
      //if (i >= droplists.size()) {
      //  DroplistWidget newDrop = new DroplistWidget(this.x, currentY, flights.columnNames.toArray(new String[0]));
      //  droplists.add(newDrop); //<>//
        
      //  TextFieldWidget newInput = new TextFieldWidget(this.x + newDrop.width + 15.0, currentY, 120., 40., "");
      //  newInput.h = newDrop.mainButton.height;
      //  inputs.add(newInput);   
        
      //  ButtonWidget newDelete = new ButtonWidget(newInput.x + newInput.w + 15.0, currentY, "", () -> {
      //    deleteFilter(finalIdx);
      //  });
      //  newDelete.fixedWidth = true;
      //  newDelete.width = newDelete.height;
      //  newDelete.setOptionalIcon(binShape); //<>//
      //  deleteButtons.add(newDelete);
      //}
      
      DroplistWidget newDrop = new DroplistWidget(this.x, currentY, flights.columnNames.toArray(new String[0]));
      droplists.add(newDrop);
      
      TextFieldWidget newInput = new TextFieldWidget(this.x + newDrop.width + 15.0, currentY, 120., 40., "");
      newInput.h = newDrop.mainButton.height;
      inputs.add(newInput);   
      
      ButtonWidget newDelete = new ButtonWidget(newInput.x + newInput.w + 15.0, currentY, "", () -> {
        deleteFilter(finalIdx);
      });
      newDelete.fixedWidth = true;
      newDelete.width = newDelete.height;
      newDelete.setOptionalIcon(binShape);
      deleteButtons.add(newDelete);

      currentY += 50.0;
    }
    
    //// Hotfix
    //if (droplists.length > 0) {
    //  droplists[droplists.length - 1].setListDropped(false);
    //}

    currentY += 40;
    this.addBtn.y = currentY;

    this.applyBtn.y = currentY;
  }
  
  void apply() {
    result = flights.data.copy();
    result.clearRows(); //<>//
    
    for (TableRow row : flights.data.rows()) {
      boolean wasMet = true;
      for (int i = 0; i < filters.size(); i++) {
        if (!row.getString(droplists.get(i).getSelectedString()).toLowerCase().contains(inputs.get(i).text.toLowerCase()))  {
          wasMet = false;
          break;
        }
      }
      if (wasMet) {
        result.addRow(row);
      }
    }
    
    println(result.getRowCount());
    this.result = result; //<>//
    //bar.categoriesX = StatisticFunctions.absoluteFrequency(result.getStringColumn("ORIGIN")).keySet().toArray(new String[0]);
  }

  void addFilter() {
    this.filters.add(new String[]{"", ""});
    this.reposition();
  }

  void deleteFilter(int idx) {
    this.filters.remove(idx);
    droplists.remove(idx);
    inputs.remove(idx);
    deleteButtons.remove(idx);
    this.reposition();
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
    
    for (ButtonWidget b : this.deleteButtons) {
      b.onMouseClicked(mX, mY);
    }
    
    this.addBtn.onMouseClicked(mX, mY);
    this.applyBtn.onMouseClicked(mX, mY);
    
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
