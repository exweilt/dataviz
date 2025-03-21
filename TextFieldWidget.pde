 //Damon edited on 17/3/2025
public class TextFieldWidget extends Widget {
  float w, h;
  color defaultColor = color(220);
  color activeColor = color(100, 200, 255);
  boolean isActive = false;
  String text = "";  
  String placeholder;  
  int cursorPosition = 0;
  boolean showCursor = true;
  int lastBlinkTime = 0;

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
    
     // Handling the blinking cursor
    if (isActive) {
      if (millis() - lastBlinkTime > 500) { 
        showCursor = !showCursor; 
        lastBlinkTime = millis();
      }

      if (showCursor) {
        float cursorX = x + 10 + textWidth(text.substring(0, cursorPosition));
        line(cursorX, y + 10, cursorX, y + h - 10);
      }
    }
  }

  @Override
  // texting whether is active or deactive
 public void onMouseClicked(int mX, int mY) {
    boolean wasActive = isActive; 
    isActive = (mX > x && mX < x + w && mY > y && mY < y + h);
    if (!wasActive && isActive) {
      println("TextFieldWidget activated");
    } else if (wasActive && !isActive) {
      println("TextFieldWidget deactivated");
    }
}


   @Override
   // Changes to a text input cursor when the mouse hovers
 public void onMouseMoved(int mX, int mY) {
    if (mX > x && mX < x + w && mY > y && mY < y + h) {
      cursor(TEXT);
    } else {
      cursor(ARROW);
    }
  }


  @Override
  //use TextFieldWidget to handle the keyTpye input
public void onKeyTyped(char key) {
  if (isActive) {
    if (key == BACKSPACE && text.length() > 0) {
      if (keyEvent.isControlDown()) {  
        int lastSpace = text.lastIndexOf(' ', cursorPosition - 1);
        if (lastSpace == -1) {
          text = ""; 
          cursorPosition = 0;
        } else {
          text = text.substring(0, lastSpace);
          cursorPosition = lastSpace;
        }
      } else {
        text = text.substring(0, cursorPosition - 1) + text.substring(cursorPosition);
        cursorPosition = max(0, cursorPosition - 1);
      }
    } else if (key == ENTER) {
      applyFilter();
    } else if (key == CODED) {
      if (keyCode == LEFT) {
        cursorPosition = max(0, cursorPosition - 1);
      } else if (keyCode == RIGHT) {
        cursorPosition = min(text.length(), cursorPosition + 1);
      }
    } else if (key >= 32 && key <= 126) {
      text = text.substring(0, cursorPosition) + key + text.substring(cursorPosition);
      cursorPosition++;
    }
  }
}

 //Method for dealing with CTRL + backspace
 public void handleKeyPressed() {
  if (isActive && key == BACKSPACE && keyEvent.isControlDown()) {  
    int lastSpace = text.lastIndexOf(' ', cursorPosition - 1);
    if (lastSpace == -1) {
      text = ""; 
      cursorPosition = 0;
    } else {
      text = text.substring(0, lastSpace);
      cursorPosition = lastSpace;
    }
  }
}


  // Move the "Enter" logic from dataviz to here
  private void applyFilter() {
    println("Filtering flights by: " + text.trim());
  }

  public String getText() {
    return text;
  }
}

void keyPressed() {
  if (focusedTextField != null) {
    focusedTextField.handleKeyPressed();
  }
}
