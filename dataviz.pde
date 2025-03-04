ButtonWidget btn;

void setup() {
  size(900, 600);
  btn = new ButtonWidget(100, 300, () -> { println("Button clicked!"); });
}

void draw() {
  background(0);
  
  fill(255, 0, 0);
  rect(100, 100, 100, 100);
  
  btn.draw();
}

void mouseClicked() {
  btn.onMouseClicked(mouseX, mouseY);
}
