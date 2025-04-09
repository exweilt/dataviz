/**
  *  A GUI table widget.
  *
  *
  *  (c) Alexey added on 09/03/2025
  */
public class TableWidget extends Widget {
  private color bg = color(250, 250, 250, 255);
  private float width = 350.0f;
  private float height = 350.0f;
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
    this.data = filters.result;
    textAlign(LEFT, CENTER); //<>//
    textSize(fontSize);
    fill(this.fontColor);
    
    float paddingX = 160.0f;
    float paddingY = 40.0f;
    float indexingPadding = 20.0f;
    
    
    
    ///* Draw column Titles */
    //float totalPadding = indexingPadding + this.columnPadding * 3;
    //for (int j = 0; j < data.getColumnCount(); j++) {
    //  text(data.getColumnTitles()[j], this.x + totalPadding, this.y + columnPaddingY);
    //  totalPadding += this.columnWidths[j] + columnPadding * 2;
    //}
    
    float minClipY = 0.0;
    float maxClipY = 100000;
    if (currentClip != null) {
      minClipY = currentClip.y;
      maxClipY = currentClip.y + currentClip.h;
    }
    //fill(200, 200, 200, 200);
    background(255, 255, 255, 100);
    
    for (int i = 0; i <= data.getRowCount(); i++) {
      float rowYPos = this.y + i*columnBaseHeight + columnBaseHeight/2;
      if (rowYPos <= minClipY) {
        continue;
      } else if (rowYPos > maxClipY) {
        break;
      }
      float totalPadding = columnPadding;  // reset
     
      //line(this.x, this.y, this.x + 1500, this.y);
      
      // Draw row index
      text(i+1, this.x + totalPadding - 20., rowYPos);
      totalPadding += indexingPadding + this.columnPadding * 2;
      
      int colnum = data.getColumnCount();
      
      for (int j = 0; j < colnum; j++) {
        if (i == 0) {
          text(data.getColumnTitles()[j], this.x + totalPadding, rowYPos); //<>//
        } else {
          text(data.getString(i-1, j), this.x + totalPadding, rowYPos);
        }
        totalPadding += this.columnWidths[j] + columnPadding * 2;
      }
      totalPadding -= columnPadding;
      //println("Drawing line ", i);
      //this.width = totalPadding;
      //this.height = rowYPos;
    }
    
    
    // Draw Vertical Lines
    stroke(200);
    float currentX = this.x + columnPadding*2 + indexingPadding;
    float startY = max(this.y, minClipY);
    for (int i = 0; i < data.getColumnCount(); i++) {
        line(currentX, startY, currentX, maxClipY);
        currentX += this.columnWidths[i] + columnPadding*2;
    }
    line(currentX, this.y, currentX, this.y + 3000);
    
    // Draw Horizontal Lines
    //float currentY = this.y;
    float w = getWidth();
    float startX = this.x + indexingPadding + 2*columnPadding;
    for (int i = 0; i < data.getRowCount() + 1; i++) {
        float yPos = this.y + i*(columnBaseHeight);
        if (yPos <= minClipY) {
          continue;
        } else if (yPos > maxClipY) {
          break;
        }
        line(startX, yPos, startX + w, yPos);
    }
    line(currentX, this.y, currentX, this.y + this.height);
    
    textAlign(LEFT, BOTTOM);
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
  
  public float getWidth() {
    float sum = 0.0f;
    for (float w : this.columnWidths) {
      sum += w;
    }
    
    return sum + 270.0;
  }
  
  public float getHeight() {
    return data.getRowCount() * this.columnBaseHeight + 70.0;
  }
}
