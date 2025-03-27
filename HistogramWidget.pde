// Histogram Widget Created By William 26/03
public class HistogramWidget extends Widget {

  private color bg = color(30, 230, 230, 55);
  private float width = 350.0f;
  private float height = 500.0f;
  private String category;
  public ArrayList<Float> seenValues = new ArrayList<>();
  public float[] values;
  public ArrayList<Integer> frequency = new ArrayList<>();
  public float scaleY = 1.0f;
  private color lableColour = color(230, 10, 10);
  public int xLimit=0;

  public HistogramWidget(float x_in, float y_in) {
    this.x = x_in;
    this.y = y_in;
  }

  @Override
    public void draw() {
    // Background rectangle
    fill(this.bg);
    noStroke();
    rect(this.x, this.y, this.width, this.height);

    // sets the Column Width
    float COLUMN_WIDTH = 50.0f;

    float bottomY = this.y + this.height - 60;
    textSize(12);

    for (int i = 0; i < xLimit; i++) {
      float columnX = this.x + i * (COLUMN_WIDTH) + 40.;
      
      fill(30);
      text(seenValues.get(i), columnX + 10, bottomY + 30.0);
      
      strokeWeight(1.0);
      stroke(150);
      line(columnX+25, bottomY+15, columnX+25, bottomY);
      
      stroke(0);
      strokeWeight(2);
      fill (lableColour);
      rect(columnX, bottomY, COLUMN_WIDTH, -(frequency.get(i)) * this.scaleY);
    }

    fill(30);
    text(this.category, width/2-45, bottomY + 50.0);
    

    fill(30);
    for (int tickY = 0; tickY <= 500; tickY += 50) {
      float yPos = bottomY - tickY * this.scaleY +5;
      text(tickY, this.x + 5., yPos);
      strokeWeight(1.0);
      stroke(150);
      line(this.x+28, yPos-5, this.x + 36.0, yPos-5);
    }

    textAlign(LEFT);
    strokeWeight(1.0);
  }

  @Override
    public void onMouseClicked(int mX, int mY) {
  }

  @Override
    public void onMouseMoved(int mX, int mY) {
  }

  public void setCategory(String category) {
    this.category = category;
  }

  public String getCategory() {
    return this.category;
  }
  
  public void setXLimit(int x){
    xLimit = x;
  }

  
  public void setValues(float[] values) {
    this.values = values;
    
    //Finds the frequency's
    for (int i=0; i<values.length; i++) {
      for (int l=0; l<seenValues.size(); l++) {
        float temp = seenValues.get(l);
        if (i>=values.length)
          break;
        if (values[i] == temp)
          i++;
      }
      if (i>=values.length)
        break;

      float temp = values[i];
      int freq=0;
      for (int k=0; k<values.length; k++) {
        if (values[k] == temp) {
          freq++;
        }

        if (k == values.length - 1) {
          frequency.add(freq);
          seenValues.add(temp);
          break;
        }
      }
    }
    println(frequency);
  }
  
  //public void setValues(String[] values) {
  //  this.values = values;
    
  //  //Finds the frequency's
  //  for (int i=0; i<values.length; i++) {
  //    for (int l=0; l<seenValues.size(); l++) {
  //      float temp = seenValues.get(l);
  //      if (values[i] == temp)
  //        i++;
  //    }
  //    if (i>seenValues.size())
  //      break;

  //    float temp = values[i];
  //    int freq=0;
  //    for (int k=0; k<values.length; k++) {
  //      if (values[k] == temp) {
  //        freq++;
  //      }

  //      if (k == values.length - 1) {
  //        frequency.add(freq);
  //        seenValues.add(temp);
  //        break;
  //      }
  //    }
  //  }
  //  println(frequency);
  //}

  public ArrayList<Integer> getFrequency() {
    return frequency;
  }
}
