/* 
  You can change the screen creating objects
  Then use currentScreen = obj
*/



public class Screen {
  ArrayList<Widget> widgets = new ArrayList<Widget>();
  color bgColor;
  
  Screen(color bgColor) {
    this.bgColor = bgColor;
  }
  
  public void addWidget(Widget w) {
    widgets.add(w);
  }

  public void drawScreen() {
    background(bgColor);
    for (Widget w : widgets) {
      w.draw();
    }
  }
  
 public void onMouseClicked(int mX, int mY) {
  boolean widgetActivated = false;

  // First iterate through all TextFieldWidgets to ensure they prioritize click events
  for (Widget w : widgets) {
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
    for (Widget w : widgets) {
      if (!(w instanceof TextFieldWidget)) {
        w.onMouseClicked(mX, mY);
      }
    }
  }
}


  public void onMouseMoved(int mX, int mY) {
    for (Widget w : widgets) {
      w.onMouseMoved(mX, mY);
    }
  }
  
  public void onKeyPressed() {
   for (Widget w : widgets) {
     w.onKeyPressed();
    }
  }

}
