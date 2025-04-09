import java.util.Arrays;
/**
  *  Container to store widgets inside.
  *
  *  Allows to limit the children widgets to some rect area
  *  and provides scrollbars for navigation if they don't fit.
  *
  * (c) Lex added the Container class 01/04/2025
  */
public class ContainerWidget extends Widget {
  int contentWidth;
  int contentHeight;
  float width;
  float height;
  PGraphics buffer;
  Widget[] widgets = null;
  int contentX;
  int contentY;
  ScrollbarWidget hscroll;
  ScrollbarWidget vscroll;
  boolean hor=false;
  boolean ver=false;

  public ContainerWidget(float x, float y, float w, float h, int contentWidth, int contentHeight) {
    this.x = x;
    this.y = y;
    this.width = w;
    this.height = h;
    this.contentWidth = contentWidth;
    this.contentHeight = contentHeight;

    this.buffer = createGraphics(this.contentWidth, this.contentHeight);
    this.widgets = new Widget[0];
    
    hscroll = new ScrollbarWidget(this.x, this.y + this.height, w, 25., false);
    hscroll.progressMax = this.contentWidth - w;
    vscroll = new ScrollbarWidget(this.x + width, this.y, 25., h, true);
    vscroll.progressMax = this.contentHeight - h;
    
    redraw();
    //ScrollbarWidget vscroll;
  }
  
  public void draw() {
    //if (millis() % 20 == 0) {
    //  redraw();
    //}
    
    image(this.buffer, this.x, this.y, this.width, this.height, this.contentX, this.contentY, this.contentX + (int)this.width, this.contentY + (int)this.height);
    hscroll.setPosition(width*0.1,height, width*0.9, 25);
    vscroll.setPosition(width,height*0.1,25, height*0.9);
    if (hor == true)
      hscroll.draw();
      
    if (ver == true)
      vscroll.draw();
  }
  
  public void selectScrollOptions(boolean horizontal, boolean vertical){
    hor = horizontal;
    ver = vertical;
  }
  
  
   public void setPosition(float x, float y, float w, float h){
    this.x =x;
    this.y = y;
    this.width = w;
    this.height = h;
  }
    
  public void redraw() {
    this.buffer.beginDraw();
    this.buffer.clear();
    pushBuffer(this.buffer);
    
    for (int i = 0; i < this.widgets.length; i++) {
      this.widgets[i].draw();
    }
    
    popBuffer();
    this.buffer.endDraw();
  }
  
  //void drawHorizontalScrollbar() {
  //  float scrollHeight = 30.0f;
  //  fill(235);
  //  noStroke();
  //  rect(this.x, this.y + this.height, this.width, scrollHeight);
    
  //  fill(150);
  //  float scrollPos = this.x + this.contentX/this.contentWidth;
  //  float scrollWidth = this.width * (this.width)/this.contentWidth;
  //  rect(scrollPos, this.y + this.height, scrollWidth, scrollHeight );
    
  //  stroke(1);
  //}
  
  void addWidget(Widget w) {
    this.widgets = Arrays.copyOf(this.widgets, this.widgets.length + 1);
    this.widgets[this.widgets.length - 1] = w;
  }
  
   @Override
 public boolean onMouseClicked(int mX, int mY) {
    this.hscroll.onMouseClicked(mX, mY);
    
    return false;
}

   @Override
 public void onMouseMoved(int mX, int mY) {
    //this.hscroll.onMouseMoved(mX, mY);
  }
  
   @Override
 public void onMouseReleased(int mX, int mY) {
    this.hscroll.onMouseReleased(mX, mY);
    this.vscroll.onMouseReleased(mX, mY);
  }
  
   @Override
 public void onMousePressed(int mX, int mY) {
    this.hscroll.onMousePressed(mX, mY);
    this.vscroll.onMousePressed(mX, mY);
  }
  
   @Override
 public void onMouseDragged(int mX, int mY) {
    this.hscroll.onMouseDragged(mX, mY);
    this.vscroll.onMouseDragged(mX, mY);
    this.contentX = (int)hscroll.value;
    this.contentY = (int)vscroll.value;
  }
}
