// Histogram Widget Created By William 26/03
import java.util.ArrayList;
import java.util.Arrays;
import java.util.stream.Collectors;
public class HistogramWidget extends Widget {

  private color bg = color(30, 230, 230, 55);
  private float width = 900.0f;
  private float height = 600.0f;
  private String category;
  private float scaleY = 0.5f;
  private color lableColour = color(230, 10, 10);
  public ArrayList<Float> seenValues = new ArrayList<>();
  public float[] values;
  public ArrayList<Integer> frequency = new ArrayList<>();
  public int xLimit=23;

  public HistogramWidget(float x_in, float y_in) {
    this.x = x_in;
    this.y = y_in;
  }

  @Override
    public void draw() {
    
    float nextValue = 1.0;
    
    // Background rectangle
    fill(this.bg);
    noStroke();
    rect(this.x, this.y, this.width, this.height);

    // sets the Column Width
    float COLUMN_WIDTH = 35.0f;

    float bottomY = this.y + this.height - 60;
    textSize(9);
    float columnX = this.x + 40;
    
    
    for (int i = 0; i < xLimit; i++) {
      fill(30);
      text(nextValue, columnX + 10, bottomY + 30.0);
      
      
      stroke(150);
      line(columnX+17, bottomY+15, columnX+17, bottomY);
      
      // loops to find column values
      int tempI = i;
      for (int k=0;k<seenValues.size();k++){
        if ((seenValues.get(k) - nextValue) == 0.0){
          i = k;
          break;
        }  
      }
      if ((seenValues.get(i)-nextValue) != 0){
        fill (lableColour);
        i = tempI;
      }    
      else {
        strokeWeight(1.5);
        fill(lableColour);
        rect(columnX, bottomY, COLUMN_WIDTH, -frequency.get(i));
        strokeWeight(1);
        i = tempI;
      } //<>// //<>// //<>// //<>//
      columnX += COLUMN_WIDTH;
      nextValue++;
      //if (nextValue > seenValues.size()) break;
    }

    fill(30);
    textSize(14);
    text(this.category, width/2-45, bottomY + 50.0);
    

    fill(30);
    for (int tickY = 0; tickY <= 600; tickY += 50) {
      float yPos = bottomY - tickY * this.scaleY +5;
      textSize(9);
      text(tickY, this.x + 5., yPos);
      strokeWeight(1.0);
      stroke(10);
      line(this.x+28, yPos-5, this.x + 36.0, yPos-5);
    }

    textAlign(LEFT);
    strokeWeight(1.0);
  }

  @Override
    public boolean onMouseClicked(int mX, int mY) {
      return false;
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
    // Resets Variables on Set
    seenValues.clear();
    frequency.clear();
    //Finds the frequency's
    for (int i=0; i<values.length;i++){
      float current = values[i];
      
      // handle NaN edge case
      if (Float.isNaN(current))
        println("NAN FOUND");
      
      boolean isProcessed = false;
      for (float seen : seenValues) {
        if (seen == current){
          isProcessed = true;
          break;
        }
      }
      if (isProcessed) 
        continue;
      
      // Frequency
      int freq = 0;
      for (int k=0;k<values.length;k++){
        if (values[k] - current == 0){
          freq++;
        }
      }
      frequency.add(freq);
      seenValues.add(current);
    }
    
    seenValues = seenValues.stream().distinct().collect(Collectors.toCollection(ArrayList::new));
    frequency = frequency.stream().collect(Collectors.toCollection(ArrayList::new));
    
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
