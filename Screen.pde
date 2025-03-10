/* 
  You can change the screen creating objects
  Then use currentScreen = obj
*/

ScreenManager defaultScreen;
ScreenManager currentScreen;

public class ScreenManager {
  ArrayList<Widget> widgets = new ArrayList<Widget>();
  color bgColor;
  
  ScreenManager(color bgColor) {
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
  
}
