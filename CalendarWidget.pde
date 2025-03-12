import java.time.LocalDate;
import java.time.DayOfWeek;
import java.time.YearMonth;
import java.time.format.TextStyle;
import java.util.Locale;

/**
  *  A GUI calendar widget.
  *
  *
  *  (c) Alexey added on 09/03/2025
  */
public class CalendarWidget extends Widget {
  private color bg = color(250, 250, 250, 255);
  private float width = 350.0f;
  private float height = 350.0f;
  private float cornerRadius = 30.0f;
  private color fontColor = color(40);
  private float horizontalPadding = 50.0f;
  
  private YearMonth activeMonth;
  private ButtonWidget leftBtn;
  private ButtonWidget rightBtn;
  
  private color weekdayColor = color(100);
  final private String[] weekdays = {"Mon", "Tue", "Wed", "Thu", "Fri", "Sun", "Sat"};

  public CalendarWidget(float x_in, float y_in) {
    this.x = x_in;
    this.y = y_in;
    
    this.activeMonth = YearMonth.of(2025, 03);
    
    this.leftBtn = new ButtonWidget(this.x + 10, this.y + 10, "<", () -> {
      this.activeMonth = this.activeMonth.minusMonths(1);
    });
    this.rightBtn = new ButtonWidget(this.x + this.width - 50, this.y + 10, ">", () -> {
      this.activeMonth = this.activeMonth.plusMonths(1);
    });
  }
  
  @Override
  public void draw() {
    noStroke();
    fill(this.bg);
    rect(this.x, this.y, this.width, this.height, this.cornerRadius);
    
    textSize(26);
    fill(this.fontColor);
    String monthName = this.activeMonth.getMonth().getDisplayName(TextStyle.FULL, Locale.getDefault());
    textAlign(CENTER);
    text(monthName + " " + this.activeMonth.getYear(), this.x + this.width/2, this.y + 40);
    
    textSize(18);
    float step = (this.width - this.horizontalPadding*2) / 6;
    fill(this.weekdayColor);
    for (int i = 0; i < weekdays.length; i++) {
      text(weekdays[i], this.x + this.horizontalPadding + i*step, this.y + 80);
    }
    
    int startWeekday = this.activeMonth.atDay(1).getDayOfWeek().getValue();
    int daysToDraw = this.activeMonth.lengthOfMonth();
    
    for (int day = 1; day <= daysToDraw; day++) {
      int weekday = (day-2+startWeekday) % 7;
      int row = (day-2+startWeekday) / 7;
      text(day, this.x + this.horizontalPadding + weekday*step, this.y + 80 + (row + 1)*step);
    }
    
    this.leftBtn.draw();
    this.rightBtn.draw();
    // Reset
    textAlign(LEFT);
  }

  @Override
  public void onMouseClicked(int mX, int mY) {
    this.leftBtn.onMouseClicked(mX, mY);
    this.rightBtn.onMouseClicked(mX, mY);
  }
  
  @Override
  public void onMouseMoved(int mX, int mY) {
    this.leftBtn.onMouseMoved(mX, mY);
    this.rightBtn.onMouseMoved(mX, mY);  
  }
}
