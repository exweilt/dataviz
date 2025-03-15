public class TextFieldWidget extends Widget {
  float w, h;
  color defaultColor = color(220);
  color activeColor = color(100, 200, 255);
  boolean isActive = false;
  String text = "";  
  String placeholder;  

  public TextFieldWidget(float x, float y, float w, float h, String placeholder) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.placeholder = placeholder;
  }

  @Override
  public void draw() {
    fill(isActive ? activeColor : defaultColor);
    stroke(0);
    rect(x, y, w, h, 10);

    fill(0);
    textAlign(LEFT, CENTER);
    textSize(16);
    
    if (text.length() > 0) {
      text(text, x + 10, y + h / 2);
    } else {
      fill(100);
      text(placeholder, x + 10, y + h / 2);
    }
  }

  @Override
  public void onMouseClicked(int mX, int mY) {
      boolean wasActive = isActive; 

  // Once click into the textbox,switch to the active mode
  if (mX > x && mX < x + w && mY > y && mY < y + h) {
    isActive = !wasActive;
  } else {
    isActive = false;
  }

  if (!wasActive && isActive) {
    println("TextFieldWidget activated");
  } else if (wasActive && !isActive) {
    println("TextFieldWidget deactivated");
  }
 }

  public void keyTyped(char key) {
    if (isActive) {
      if (key == BACKSPACE && text.length() > 0) {
        text = text.substring(0, text.length() - 1);
      } else if (key == ENTER) {
        println("User entered: " + text);
      } else if (key >= 32 && key <= 126) {  
        text += key;
      }
    }
  }

  public String getText() {
    return text;
  }
}
