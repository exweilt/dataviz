/* 
  You can change the screen creating objects of this class
  Then use currentScreen = objectName to print current focusing screen
  Also you can add widget to the screen object´s arratlist to avoid printing them one by one 
*/



public class Screen {
  ArrayList<Widget> widgets = new ArrayList<Widget>();
  color bgColor;
  PImage bgImage;

  
  Screen(color bgColor) {
    this.bgColor = bgColor;
  }
  //Screen(){
  //  this.background = true;
  //}
  
  Screen(PImage img) {
    this.bgImage = img;
  }
  
  public void addWidget(Widget w) {
    widgets.add(w);
  }
  public void drawScreen() {

    if (this.bgImage != null) {
      image(bgImage, 0, 0, width, height);
    } else {
      background(bgColor);
    }
    
    for (Widget w : widgets) {
      w.draw();
    }
  }
  
 public void onMouseClicked(int mX, int mY) {
  boolean widgetActivated = false;
  buttonWasPressedDuringFrame = false; // Reset the global variable

  // First iterate through all TextFieldWidgets to ensure they prioritize click events
  for (int i = widgets.size() - 1; i >= 0; i--) {
    Widget w = widgets.get(i);
    if (w instanceof TextFieldWidget) {
      w.onMouseClicked(mX, mY);
      if (((TextFieldWidget) w).isActive) {
        focusedTextField = (TextFieldWidget) w;  // only focus on the currently selected TextField
        widgetActivated = true;
      }
    }
  }

  // If no TextFieldWidget is activated, continue to iterate through other widgets
  if (!widgetActivated) {
    focusedTextField = null;  // cancel the selected state for the textField
    for (int i = widgets.size() - 1; i >= 0; i--) {
      Widget w = widgets.get(i);
      if (!(w instanceof TextFieldWidget)) {
        w.onMouseClicked(mX, mY);
      }
    }
  }
}


  public void onMouseMoved(int mX, int mY) {
    cursor(ARROW);
    
    for (Widget w : widgets) {
      w.onMouseMoved(mX, mY);
    }
  }
  
  public void onKeyPressed() {
   for (Widget w : widgets) {
     w.onKeyPressed();
    }
  }


 public void onMouseReleased(int mX, int mY) {
   for (Widget w : widgets) {
     w.onMouseReleased(mX, mY);
    }
  }
  

 public void onMousePressed(int mX, int mY) {
   for (Widget w : widgets) {
     w.onMousePressed(mX, mY);
    }
  }
  

 public void onMouseDragged(int mX, int mY) {
   for (Widget w : widgets) {
     w.onMouseDragged(mX, mY);
    }
  }
}
