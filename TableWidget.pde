/**
  *  A GUI table widget.
  *
  *
  *  (c) Alexey added on 09/03/2025
  */
public class TableWidget extends Widget {
  public color bg = color(255, 255, 255, 255);
  public color fontColor = color(40);
  public Table data;                            // the table to visualize.

  private float[] columnWidths;
  private float columnPadding = 5.0f;
  private float fontSize = 17;
  private float columnBaseHeight = 40.0f;

  /**
    * Construct Table widget object.
    *
    */
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
    
    float indexingPadding = 20.0f;
    
    // Find approximate boundaries of the table so we can skip drawing what is not needed.
    float minClipY = 0.0;
    float maxClipY = 100000;
    if (currentClip != null) {
      minClipY = currentClip.y;
      maxClipY = currentClip.y + currentClip.h;
    }

    // Draw background
    fill(this.bg);
    noStroke();
    rect(currentClip.x, currentClip.y, currentClip.w, currentClip.h);

    fill(this.fontColor);
    // Iterate through each row...
    for (int i = 0; i <= data.getRowCount(); i++) {
      float rowYPos = this.y + i*columnBaseHeight + columnBaseHeight/2; // Y pos of the row

      if (rowYPos <= minClipY) {
        continue; // skip rows above the clipping zone
      } else if (rowYPos > maxClipY) {
        break;    // skip rows below the clipping zone
      }

      float totalPadding = columnPadding;  // reset
           
      // Draw row index
      text(i+1, this.x + totalPadding - 20., rowYPos);
      totalPadding += indexingPadding + this.columnPadding * 2;
      
      int colnum = data.getColumnCount();

      // Iterate through each column of a row...
      for (int j = 0; j < colnum; j++) {
        if (i == 0) {
          // Draw titles of columns as top row.
          text(data.getColumnTitles()[j], this.x + totalPadding, rowYPos);
        } else {
          // Draw values of columns.
          text(data.getString(i-1, j), this.x + totalPadding, rowYPos);
        }

        // Go next column by increasing the position of drawing.
        totalPadding += this.columnWidths[j] + columnPadding * 2; //<>//
      }
    }
    
    // ==================== Draw Vertical Lines ====================
    stroke(200);
    float currentX = this.x + columnPadding*2 + indexingPadding; // x pos of current column
    float startY = max(this.y, minClipY); // Optimization: to start from
    // For each column draw a vertical line.
    for (int i = 0; i < data.getColumnCount(); i++) {
      line(currentX, startY, currentX, maxClipY);
      currentX += this.columnWidths[i] + columnPadding*2;
    }
    line(currentX, this.y, currentX, this.y + 3000);
    // =============================================================
    
    // =================== Draw Horizontal Lines ===================
    float w = getWidth();
    float startX = this.x + indexingPadding + 2*columnPadding; // Optimization
    // For each VISIBLE row draw a horizontal line.
    for (int i = 0; i < data.getRowCount() + 1; i++) {
      float yPos = this.y + i*(columnBaseHeight);
      if (yPos <= minClipY) {
        continue; // Skip rows above visible zone
      } else if (yPos > maxClipY) {
        break;    // Skip rows below visible zone
      }
      line(startX, yPos, startX + w, yPos);
    }
    // =============================================================
    
    textAlign(LEFT, BOTTOM); // Revert styles
  }
  
  /**
    * Calculate width(float) of some column i taking into account
    * the longest possible value and font size(so everything can fit inside such a column).
    *
    */
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
  
  /**
    * Form array of individual widths for each column.
    *
    * This is needed to ensure that every possible value can fit inside columns.
    * Please call this method after updating the data member.
    *
    */
  public void updateColumnWidths() {
    int columnCount = this.data.getColumnCount();
    float[] newWidths = new float[columnCount];
    
    for (int i = 0; i < columnCount; i++) {
      newWidths[i] = determineTrueColumnWidth(i);
    }
    
    this.columnWidths = newWidths;
  }
  
  /**
    * Calculate total width of the table.
    *
    */
  public float getWidth() {
    float sum = 0.0f;

    for (float w : this.columnWidths) {
      sum += w;
    }
    
    return sum + 270.0; // Plus some magic number(simply make a bit wider)
  }

  /**
    * Calculate total height of the table.
    *
    */
  public float getHeight() {
    // The magic number here is just to make the table A BIT TALLER for the container to display surroundings.
    return data.getRowCount() * this.columnBaseHeight + 70.0;
  }
}
