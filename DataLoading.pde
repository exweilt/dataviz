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
    for (int i=0;i<data.getStringColumn("FL_DATE").length;i++){
      println(data.getString(i, "FL_DATE"));
      if (data.getString(i, "FL_DATE").equals(startDate)){
        Starting = true;
       }
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
// Returns an ArrayList of a specified Column with a specified type
//ArrayList<String> valuesOfColumnString(String column) {
//  ArrayList<String> columnValues = new ArrayList<>();
//  for (int i=0; i<columnNames.size(); i++) {
//    if (column.equals(columnNames.get(i))) {
//      columnValues = new ArrayList<>(Arrays.asList(Data.getStringColumn(column)));
//      print(columnValues);
//      break;
//    }
//  }
//  return columnValues;
//}

// Returns a value of a specified row and column
//int valueAtRowColumnInt(int row,String column) {
//  int value =0;
//  for (int i=0; i<columnNames.size(); i++) {
//    if (column.equals(columnNames.get(i))) {
//      value = Data.getInt(row, column);
//      break;
//    }
//  }
//  return value;
//}
