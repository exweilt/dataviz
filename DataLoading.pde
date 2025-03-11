// Created by William 11/03
import java.util.ArrayList;
import java.util.Arrays;
Table flightData;
ArrayList<String> columnNames = new ArrayList<>();

void loadData(String filename) {
  flightData = loadTable(filename, "header");
  columnNames = new ArrayList<>(Arrays.asList("FL_DATE", "MKT_CARRIER",
  "MKT_CARRIER_FL_NUM", "ORIGIN", "ORIGIN_CITY_NAME", "OROGIN_STATE_ABR", 
  "ORIGIN_WAC", "DEST", "DEST_CITY_NAME", "DEST_CITY_ABR", "DEST_WAC", "CRS_DEP_TIME", 
  "DEP_TIME", "CRS_ARR_TIME", "ARR_TIME", "CANCELLED", "DIVERTED", "DISTANCE"));
}
// Data cleaning (specifically the first column with the 00:00 junk values)
// Removed them using a .csv editor called Refine

// Returns an ArrayList of a specified Column with a specified type
ArrayList<String> valuesOfColumnString(String column) {
  ArrayList<String> columnValues = new ArrayList<>();
  for (int i=0; i<columnNames.size(); i++) {
    if (column.equals(columnNames.get(i))) {
      columnValues = new ArrayList<>(Arrays.asList(flightData.getStringColumn(column)));
      print(columnValues);
      break;
    }
  }
  return columnValues;
}

ArrayList<Integer> valuesOfColumnInt(String column) {
  ArrayList<Integer> columnValues = new ArrayList<>();
  for (int i=0; i<columnNames.size(); i++) {
    if (column.equals(columnNames.get(i))) {
      for (String value : flightData.getStringColumn(column)) {
        columnValues.add(Integer.parseInt(value));
      }
      break;
    }
  }
  return columnValues;
}

ArrayList<Double> valuesOfColumnDouble(String column) {
  ArrayList<Double> columnValues = new ArrayList<>();
  for (int i=0; i<columnNames.size(); i++) {
    if (column.equals(columnNames.get(i))) {
      print("header found");
      for (String value : flightData.getStringColumn(column)) {
        columnValues.add(Double.parseDouble(value));
      }
      break;
    }
  }
  return columnValues;
}

// Returns a value of a specified row and column
int valueAtRowColumnInt(int row,String column) {
  int value =0;
  for (int i=0; i<columnNames.size(); i++) {
    if (column.equals(columnNames.get(i))) {
      value = flightData.getInt(row, column);
      break;
    }
  }
  return value;
}
String valueAtRowColumnString(int row,String column) {
  String value = null;
  for (int i=0; i<columnNames.size(); i++) {
    if (column.equals(columnNames.get(i))) {
      value = flightData.getString(row, column);
      break;
    }
  }
  return value;
}
double valueAtRowColumnDouble(int row,String column) {
  double value=0.0;
  for (int i=0; i<columnNames.size(); i++) {
    if (column.equals(columnNames.get(i))) {
      value = flightData.getFloat(row, column);
      break;
    }
  }
  return value;
}
