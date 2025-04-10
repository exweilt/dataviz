// Created by William 11/03
  // Data cleaning (specifically the first column with the 00:00 junk values)
  // Removed them using a .csv editor called Refine
import java.util.ArrayList;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

class DataLoading {
  private Table data;
  public ArrayList<String> columnNames = new ArrayList<>();

  public DataLoading(){}

  void loadData(String filename) {
    data = loadTable(filename, "header");
    //loops to retrieve column data from file
    for (int i=0;i<data.getColumnCount();i++){
      columnNames.add(data.getColumnTitle(i));
    }
  }
  
  void printColumns(){
    for(int i=0;i<data.getColumnCount();i++){
      print(columnNames.get(i)+",");
    }
  }
  // added on 12/03
  // returns an array of LocalDate values converted from strings with a specified start and endDate
  ArrayList<LocalDate> stringToDate(String startDate, String endDate){
    ArrayList<LocalDate> DatesArray = new ArrayList<>();
    boolean Starting = false;
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
   // loops to get flight dates
    for (int i=0;i<data.getStringColumn("FL_DATE").length;i++){
      println(data.getString(i, "FL_DATE"));
      // checks to see if flight date = start date
      if (data.getString(i, "FL_DATE").equals(startDate)){
        Starting = true;
       }
       //loops to add flight dates to array
       if (Starting == true){
         LocalDate date = LocalDate.parse(data.getString(i, "FL_DATE"), formatter);
         DatesArray.add(date);
       }
       if (data.getString(i, "FL_DATE").equals(endDate)){
        break;
       }
    }
    return DatesArray;
  }
}
