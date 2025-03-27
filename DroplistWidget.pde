/**
 *  A GUI drop-down list widget.
 *
 *  Use setOptions(String[] newOptions) and getSelectedString() to interact with this widget.
 *
 *
 *  (c) Lex created the class at 27/03/2025
 */
public class DroplistWidget extends Widget {
  public float width = 0;
  private float height = 0;

  public color bg = color(220);
  public color fg = color(42);
  public color hoveredBg = color(200);
  public color pressedBg = color(220);
  public color borderColor = color(190);
  public float borderWidth = 1.5f;

  float cornerRadius = 9.0;

  boolean isListDropped = false;

  String[] options = {"Apple", "Banana", "Orange", "Lemon"};
  int activeIndex = 0;

  float fontSize = 22.0f;

  private float longestOptionWidth;
  private float optionHeight;

  ButtonWidget[] optionButtons;
  ButtonWidget mainButton;

  public DroplistWidget(float x_in, float y_in, String[] options) {
    this.x = x_in;
    this.y = y_in;

    if (options != null) {
      this.options = options;
    }

    updateMaxOptionSize();
    updateButtons();
  }

  @Override
    public void draw() {
    this.mainButton.draw();

    if (isListDropped) {
      for (ButtonWidget b : this.optionButtons) {
        b.draw();
      }
    }
  }

  @Override
    public void onMouseClicked(int mX, int mY) {
    this.mainButton.onMouseClicked(mX, mY);

    if (isListDropped) {
      for (ButtonWidget b : this.optionButtons) {
        b.onMouseClicked(mX, mY);
      }
    }
  }

  @Override
    public void onMouseMoved(int mX, int mY) {
    this.mainButton.onMouseMoved(mX, mY);

    if (isListDropped) {
      for (ButtonWidget b : this.optionButtons) {
        b.onMouseMoved(mX, mY);
      }
    }
  }

  void updateButtons() {
    float currentY = this.y;
    this.width = this.longestOptionWidth + 24.0f;

    // Update main Button
    this.mainButton = new ButtonWidget(this.x, currentY, this.options[activeIndex] + " v", () -> {
      this.isListDropped = !this.isListDropped;
    }
    );
    this.mainButton.fixedWidth = true;
    this.mainButton.width = width;
    this.mainButton.bg = color(200);
    currentY += this.mainButton.height;

    // Update options
    this.optionButtons = new ButtonWidget[this.options.length];
    for (int i = 0; i < this.options.length; i++) {
      int finalI = i;
      ButtonWidget newButton = new ButtonWidget(this.x, currentY, this.options[i], () -> {
        selectOption(finalI);
      }
      );
      newButton.fixedWidth = true;
      newButton.width = width;
      newButton.fg = color(100);
      newButton.hoveredBg = color(15, 144, 240);
      newButton.hoveredFg = color(240);

      // Corner rounding of options
      if (i == 0 && this.options.length > 1) {
        newButton.setCornerRadius(0);
        newButton.tlRadius = cornerRadius;
        newButton.trRadius = cornerRadius;
      } else if (i == this.options.length - 1 && this.options.length > 1) {
        newButton.setCornerRadius(0);
        newButton.blRadius = cornerRadius;
        newButton.brRadius = cornerRadius;
      } else if (this.options.length > 1) {
        newButton.setCornerRadius(0);
      }

      this.optionButtons[i] = newButton;
      currentY += newButton.height;
    }
  }

  private void updateMaxOptionSize() {
    textSize(this.fontSize);

    float maxWidth = 0.0;
    for (String option : this.options) {
      float optionWidth = textWidth(option);
      if (maxWidth < optionWidth) {
        maxWidth = optionWidth;
      }
    }

    this.longestOptionWidth = maxWidth;

    this.optionHeight = textAscent() + textDescent();
  }

  void selectOption(int optionIndex) {
    this.activeIndex = optionIndex;

    this.updateButtons();
  }

  int getSelectedIndex() {
    return this.activeIndex;
  }

  String getSelectedString() {
    return this.options[this.activeIndex];
  }

  void setOptions(String[] newOptions) {
    this.options = newOptions;

    updateMaxOptionSize();
    updateButtons();
  }
}
