/**
  *  Base Widget class
  *
  *  All other widgets should inherit(extend) from it.
  *
  *
  * (c) Lex added the base Widget class 03/03/2025
  */
public class Widget {
  public float x;  // top left corner
  public float y;
  
  /**
    *  To be overrode inside child classes.
    */
  public void draw() {}
  
  /**
    *  Called immediatly, only once, after the mouse button was dipped.
    *  The cursor does NOT have to be over the widget for this to be executed!
    */
  public void onMousePressed(int mouseX_in, int mouseY_in) {}
  
  /**
    *  Called only once, after the mouse button was released without motion.
    *  The cursor does NOT have to be over the widget for this to be executed!
    */
  public void onMouseClicked(int mouseX_in, int mouseY_in) {}
  
  /**
    *  Called each frame when the mouse was moved.
    *  The cursor does NOT have to be over the widget for this to be executed!
    */
  public void onMouseMoved(int mouseX_in, int mouseY_in) {}
  
  public void onKeyTyped(char key) {}
}
