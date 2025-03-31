public class QueryingWidget extends Widget {
  public color fontColor = color (0);
  public float fontSize = 26;

  ButtonWidget addBtn;
  ButtonWidget applyBtn;
  ArrayList<String[]> filters; // Only 0 and 1 indicies, key : value

  DroplistWidget[] droplists;
  TextFieldWidget[] inputs;
  
  Table result = null;

  public QueryingWidget(float x_in, float y_in) {
    this.x = x_in;
    this.y = y_in;

    this.filters = new ArrayList<String[]>();

    droplists = new DroplistWidget[0];
    inputs = new TextFieldWidget[0];

    this.addBtn = new ButtonWidget(this.x, this.y, "+", () -> {
      this.addFilter();
    });

    this.applyBtn = new ButtonWidget(this.x + 100, this.y, "Apply", () -> {
      //this.apply();
    });
    
    reposition();
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
      if (droplists[i].isListDropped) {
        activeDroplist = droplists[i];
      } else {
        this.droplists[i].draw();
      }
      this.inputs[i].draw();
    }

    addBtn.draw();
    applyBtn.draw();
    
    if (activeDroplist != null)
      activeDroplist.draw();
  }

  void reposition() {
    droplists = new DroplistWidget[this.filters.size()];
    inputs = new TextFieldWidget[this.filters.size()];

    float currentY = this.y + 70.0;
    for (int i = 0; i < this.filters.size(); i++) {
      DroplistWidget newDrop = new DroplistWidget(this.x, currentY, flights.columnNames.toArray(new String[0]));
      droplists[i] = newDrop;

      TextFieldWidget newInput = new TextFieldWidget(this.x + newDrop.width + 15.0, currentY, 120., 40., "");
      inputs[i] = newInput;

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
  
  void apply() { //<>//
    //result = flights.;
    //result.columnNames
    
    for (TableRow row : flights.data.rows()) {
      boolean wasMet = true;
      for (int i = 0; i < filters.size(); i++) {
        if (!row.getString(filters.get(i)[0]).equals(filters.get(i)[1]))  {
          wasMet = false;
          break; //<>//
        }
        if (wasMet) {
          result.addRow(row);
        }
      }
    }
    print(result); //<>//
    //bar.categoriesX = StatisticFunctions.absoluteFrequency(result.getStringColumn("ORIGIN")).keySet().toArray(new String[0]);
  }

  void addFilter() {
    this.filters.add(new String[]{"", ""});
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
  }
  
  @Override
  public void onKeyPressed() {
    for (TextFieldWidget i : this.inputs) {
      i.onKeyPressed();
    }
  }
}
