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
  //PGraphics buffer;
  Widget[] widgets = null;
  int contentX;
  int contentY;
  ScrollbarWidget hscroll;
  ScrollbarWidget vscroll;


  public ContainerWidget(float x, float y, float w, float h, int contentWidth, int contentHeight) {
    this.x = x;
    this.y = y;
    this.width = w;
    this.height = h;
    this.contentWidth = contentWidth;
    this.contentHeight = contentHeight;
    this.widgets = new Widget[0];
    
    // horizontal scrollbar
    hscroll = new ScrollbarWidget(this.x, this.y + this.height, w, 25., false);
    hscroll.progressMax = this.contentWidth - w;
    
    // vertical scrollbar
    vscroll = new ScrollbarWidget(this.x + width, this.y, 25., h, true);
    vscroll.progressMax = this.contentHeight - h;
    
    onMouseDragged(0, 0);
    
    redraw();
    
  }
  
  public void draw() {
   
    pushClip(new Clip(this.x, this.y, this.width, this.height));
    for (int i = 0; i < this.widgets.length; i++) {
      this.widgets[i].x = this.x - contentX + 40.;
      this.widgets[i].y = this.y - contentY + 40.;
      this.widgets[i].draw();
    }
    popClip();
    hscroll.draw();
    vscroll.draw();
  }
    
 
  
  
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
    
   
    
    for (int i = 0; i < this.widgets.length; i++) {
      this.widgets[i].x = this.x - contentX + 40.;
      this.widgets[i].y = this.y - contentY + 40.;
    }
  }
  
  void setContentWidth(int newWidth) {
    this.contentWidth = newWidth;
    hscroll.progressMax = max(newWidth - this.width, 0);
  }
  
  void setContentHeight(int newHeight) {
    this.contentHeight = newHeight;
    vscroll.progressMax = max(newHeight - this.height, 0);
  }
}
