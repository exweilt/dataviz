/**
  *  A GUI table widget.
  *
  *
  *  (c) Alexey added on 09/03/2025
  */
public class TableWidget extends Widget {
  private color bg = color(250, 250, 250, 255);
  //private float width = 350.0f;
  //private float height = 350.0f;
  //private float cornerRadius = 30.0f;
  private color fontColor = color(40);
  //private float horizontalPadding = 50.0f;
  private Table data;
  private float fontSize = 17;
  private float[] columnWidths;
  private float columnPadding = 5.0f;
  //private float columnPaddingY = 2.0f;
  private float columnBaseHeight = 40.0f;
  
  

  public TableWidget(float x_in, float y_in, Table data) {
    this.x = x_in;
    this.y = y_in;
    this.data = data;
    
    updateColumnWidths();
  }
  
  @Override
  public void draw() {
    tb.textAlign(LEFT, CENTER); //<>//
    tb.textSize(fontSize);
    tb.fill(this.fontColor);
    
    float paddingX = 160.0f;
    float paddingY = 40.0f;
    float indexingPadding = 20.0f;
    
    tb.circle(this.x, this.y, 10.0);
    
    ///* Draw column Titles */
    //float totalPadding = indexingPadding + this.columnPadding * 3;
    //for (int j = 0; j < data.getColumnCount(); j++) {
    //  text(data.getColumnTitles()[j], this.x + totalPadding, this.y + columnPaddingY);
    //  totalPadding += this.columnWidths[j] + columnPadding * 2;
    //}
    
    for (int i = 0; i <= data.getRowCount(); i++) {
      float rowYPos = this.y + i*columnBaseHeight + columnBaseHeight/2;
      float totalPadding = columnPadding;  // reset
      
      //line(this.x, this.y, this.x + 1500, this.y);
      
      // Draw row index
      tb.text(i+1, this.x + totalPadding, rowYPos);
      totalPadding += indexingPadding + this.columnPadding * 2;
      
      int colnum = data.getColumnCount();
      
      for (int j = 0; j < colnum; j++) {
        if (i == 0) {
          tb.text(data.getColumnTitles()[j], this.x + totalPadding, rowYPos); //<>//
        } else {
          tb.text(data.getString(i-1, j), this.x + totalPadding, rowYPos);
        }
        totalPadding += this.columnWidths[j] + columnPadding * 2;
      }
      totalPadding -= columnPadding;
    }
    
    // Draw Vertical Lines
    tb.stroke(200);
    float currentX = this.x + columnPadding*2 + indexingPadding;
    for (int i = 0; i < data.getColumnCount(); i++) {
        tb.line(currentX, this.y, currentX, this.y + 3000);
        currentX += this.columnWidths[i] + columnPadding*2;
    }
    tb.line(currentX, this.y, currentX, this.y + 3000);
    
    // Draw Horizontal Lines
    //float currentY = this.y;
    float startX = this.x + indexingPadding + 2*columnPadding;
    for (int i = 0; i < data.getRowCount(); i++) {
        float yPos = this.y + i*(columnBaseHeight);
        tb.line(startX, yPos, startX + 2500, yPos);
    }
    tb.line(currentX, this.y, currentX, this.y + 3000);
    
    tb.textAlign(LEFT, BOTTOM);
  }
  
  public float determineTrueColumnWidth(int columnId) {
    textSize(this.fontSize);
    
    float maxWidth = textWidth(data.getColumnTitles()[columnId]);
    
    for (String s : data.getStringColumn(columnId)) {
      if (textWidth(s) > maxWidth) {
        maxWidth = textWidth(s);
      }
    }
    
    return maxWidth;
  }
  
  public void updateColumnWidths() {
    int columnCount = this.data.getColumnCount();
    float[] newWidths = new float[columnCount];
    
    for (int i = 0; i < columnCount; i++) {
      newWidths[i] = determineTrueColumnWidth(i);
    }
    
    this.columnWidths = newWidths;
  }

  @Override
  public boolean onMouseClicked(int mX, int mY) {
    return false;
  }
  
  @Override
  public void onMouseMoved(int mX, int mY) {

  }
}
