 //Damon edited on 17/3/2025
public class TextFieldWidget extends Widget {
  float w, h;
  color defaultColor = color(220);
  color activeColor = color(100, 200, 255);
  boolean isActive = false;
  String text = "";        // Stores user input text
  String placeholder;      // Placeholder text shown when input is empty
  int cursorPosition = 0;  // Current cursor position
  boolean showCursor = true;  // Controls blinking cursor visibility
  int lastBlinkTime = 0;   // For cursor blink timing

  public TextFieldWidget(float x, float y, float w, float h, String placeholder) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.placeholder = placeholder;
  }

  @Override
  public void draw() {
    fill(defaultColor);
    stroke(20);
    strokeWeight(isActive ? 3.0 : 1.0);
    rect(x, y, w, h, 5);  // Draw the input box
    strokeWeight(1.0);

    fill(0);
    textAlign(LEFT, CENTER);
    textSize(16);
    
    if (text.length() > 0) {
      text(text, x + 10, y + h / 2);  // Draw the input text
    } else {
      fill(100);
      text(placeholder, x + 10, y + h / 2);  // Show placeholder if is empty
    }
    
     // Handling the blinking cursor
    if (isActive) {
      if (millis() - lastBlinkTime > 500) { 
        refreshBlink(!showCursor);   // Toggle the cursor every 500ms
      }

      if (showCursor) {
        float cursorX = x + 10 + textWidth(text.substring(0, cursorPosition));
        line(cursorX, y + 10, cursorX, y + h - 10);  // Draw the cursor line
      }
    }
  }

  @Override
  // Activate or deactivate the text field on mouse click
 public boolean onMouseClicked(int mX, int mY) {
    boolean wasActive = isActive; 
    isActive = (mX > x && mX < x + w && mY > y && mY < y + h);
    refreshBlink(isActive);
    
    if (!wasActive && isActive) {
      println("TextFieldWidget activated");
    } else if (wasActive && !isActive) {
      println("TextFieldWidget deactivated");
    }
    
    return isActive;
}


   @Override
   // Changes to a text input cursor when the mouse hovers
 public void onMouseMoved(int mX, int mY) {
    if (mX > x && mX < x + w && mY > y && mY < y + h) {
      cursor(TEXT);   // Show text cursor when hovering over text field
    } else {
      //cursor(ARROW);
    }
  }


  @Override
  //use TextFieldWidget to handle the keyTpye input
public void onKeyPressed() {
  if (isActive) { //<>//
    if (key == BACKSPACE && text.length() > 0) {
      if (keyEvent.isControlDown()) {    // Using CTRL + BACKSPACE to delete a word
        int lastSpace = text.lastIndexOf(' ', cursorPosition - 1);
        if (lastSpace == -1) {
          text = ""; 
          cursorPosition = 0;
        } else {
          text = text.substring(0, lastSpace);
          cursorPosition = lastSpace;
        }
      } else {
        text = text.substring(0, cursorPosition - 1) + text.substring(cursorPosition);  // Delete a character
        cursorPosition = max(0, cursorPosition - 1);               // Move cursor back
      }
    } else if (key == ENTER) {
      //applyFilter();    // Placeholder for enter key action
    } else if (key == CODED) { //<>//
      if (keyCode == LEFT) {
        cursorPosition = max(0, cursorPosition - 1);               // Move cursor left //<>//
      } else if (keyCode == RIGHT) {
        cursorPosition = min(text.length(), cursorPosition + 1);   // Move cursor right
      }
    } else if (key >= 32 && key <= 126) {
      text = text.substring(0, cursorPosition) + key + text.substring(cursorPosition);
      cursorPosition++;
    }
    refreshBlink(true);   // Reset blink timer on input
  }
}

  private void refreshBlink(boolean newState) {
    showCursor = newState; 
    lastBlinkTime = millis();   // Reset blink timer
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


  // Placeholder function for enter key filtering (if needed externally
  private void applyFilter() {
    println("Filtering flights by: " + text.trim());
  }

  public String getText() {
    return text;   // Getter for input text
  }
}

//void keyPressed() {
//  if (focusedTextField != null) {
//    focusedTextField.handleKeyPressed();
//  }
//}
