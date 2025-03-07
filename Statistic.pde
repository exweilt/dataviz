/*

  Upload data 05/03/2025
  Contact me for more Statistical calculations

  INSTRUCTION TO USE STATISTICAL TOOL

  FORMAT --> RunCalculation.xxx(yyy)
  
  xxx --> Type of Calculation
  
  yyy --> Your data Array (REMIND THIS MUST BE A FLOAT ARRAY)
  
  
  
  BE CAREFUL WITH UPPERCASE AND LOWERCASE
  
  Correct use --> RunCalculation.mean(yyy)
  Wrong use --> RunCalculation.Mean(yyy)
  
  What Types of Calculations we have now?
  
  return type float -->
  mean
  median
  mode
  range
  variance
  standardDeviation
  interquartileRange
  percentile
  
  return type float[] -->
  zScores

*/

public static class StatisticFunctions {

  StatisticFunctions RunCalculation;
  
  float mean(float[] data) {
    float total = 0; //<>// //<>//
    for (int current = 0; current < data.length; current++) {
      total = total + data[0];
    }
    return total / data.length;
  }

  float median(float[] data) {
    if (data.length % 2 == 1) {
      return data[(data.length + 1) / 2];
    } else {
      return (data[data.length / 2] + data[data.length / 2 + 1]) / 2;
    }
  }

  float mode(float[] data) {
    HashMap<Float, Integer> freqMap = new HashMap<Float, Integer>();
    int maxCount = 0;
    float modeValue = data[0];

    for (float num : data) {
      int count = freqMap.getOrDefault(num, 0) + 1;
      freqMap.put(num, count);

      if (count > maxCount) {
        maxCount = count;
        modeValue = num;
      }
    }
    return modeValue;
  }
  
  float range(float[] data) {
    float minVal = data[0];
    float maxVal = data[0];

    for (int current = 1; current < data.length; current++) {
      if (data[current] < minVal) {
        minVal = data[current];
      }
      if (data[current] > maxVal) {
        maxVal = data[current];
      }
    }
    return maxVal - minVal;
  }
  
  float variance(float[] data) {
    int n = data.length;
    if (n == 0) return 0;

    float mean = RunCalculation.mean(data);

    float varianceSum = 0;
    for (float num : data) {
      varianceSum += (num - mean) * (num - mean);
    }
    return varianceSum / n;
  }
  
  float standardDeviation(float[] data) {
    float variance = RunCalculation.variance(data);
    return sqrt(variance);
  }
  
  float interquartileRange(float[] data) {
    int n = data.length;
    if (n < 2) return 0;
  
    float[] sortedArr = sort(data);
  
    float Q1 = percentile(sortedArr, 25);
    float Q3 = percentile(sortedArr, 75);
  
    return Q3 - Q1;
  }
  
  float percentile(float[] data, float percent) {
    float[] sortedArr = sort(data);
    float index = (percent / 100) * (sortedArr.length - 1);
    int lowerIndex = floor(index);
    int upperIndex = ceil(index);
  
    if (lowerIndex == upperIndex) {
      return sortedArr[lowerIndex];
    } else {
      float weight = index - lowerIndex;
      return sortedArr[lowerIndex] * (1 - weight) + sortedArr[upperIndex] * weight;
    }
  }
  
  float[] zScores(float[] data) {
    int n = data.length;
    if (n == 0) return new float[0];
  
    float mean = this.mean(data);
  
    float stdDev = RunCalculation.standardDeviation(data);
  
    float[] zScores = new float[n];
    for (int current = 0; current < n; current++) {
      zScores[current] = (data[current] - mean) / stdDev;
    }
  
    return zScores;
  }
  
  /**
    *  Calculate pearson correlation coefficient between two columns of floats.
    *  Used in constructing correlation matricies.
    * 
    *
    *  (c) Lex added on 6/03/2025
    */
  static float pearson(float[] x, float[] y) {
    if (x == null || y == null) {
      throw new NullPointerException("Columns x and y must not be null pointers.");
    }
    if (x.length != y.length) {
      throw new IllegalArgumentException("Columns must be of the same length.");
    }
    if (x.length <= 0) {
      throw new IllegalArgumentException("Column length must be greater than zero.");
    }
    
    if (x == y) {
      return 1.0f; // Doesn't catch if two arrays are the same by content but have different pointers.
    }
    
    int numberOfElements = x.length; // x.length == y.length
    
    float meanX = StatisticFunctions.mean(x);
    float meanY = StatisticFunctions.mean(y);
    
    float[] centeredX = new float[numberOfElements];
    float[] centeredY = new float[numberOfElements];
    
    // Center X and Y
    for (int idx = 0; idx < numberOfElements; idx++) {
      centeredX[idx] = x[idx] - meanX;
      centeredY[idx] = y[idx] - meanY;
    }
    
    float nominator = 0;
    for (int idx = 0; idx < numberOfElements; idx++) {
      nominator += centeredX[idx] * centeredY[idx];
    }
    
    float sumSquaresX = 0;
    float sumSquaresY = 0;
    for (int idx = 0; idx < numberOfElements; idx++) {
      sumSquaresX += centeredX[idx] * centeredX[idx];
      sumSquaresY += centeredY[idx] * centeredY[idx];
    }
    
    float denominator = sqrt(sumSquaresX * sumSquaresY);
    
    return nominator / denominator;
  }
  
  /**
    *  Constructs pearson correlation matrix between columns of the table.
    *  This doesn't work with qualitative data.
    *
    *  @param table with all the columns inside.
    *         WARNING: all the columns must be float containing.
    *  @return 2d array n by n where n is the number of columns in the table,
    *          rows are top-down, columns are left-right.
    *  
    *  
    *  (c) Alexey added on 07/03/2025
    */
  public static float[][] calculateCorrelationMatrix(Table data) {
    //int numberOfRows = data.getRowCount();
    int numberOfColumns = data.getColumnCount();
    float[][] correlationMatrix = new float[numberOfColumns][numberOfColumns];
    
    // The matrix is filled like this: going through the triangle left-to-right, top-to-bottom
    // and copying each element transposing it diagonally.
    for (int i = 0; i < numberOfColumns; i++) {
      correlationMatrix[i][i] = 1.0f;  // Correlation of the column with itself is 1
      
      // The rest in pairs
      for (int j = i + 1; j < numberOfColumns; j++) {
        float correlation = StatisticFunctions.pearson(data.getFloatColumn(i), data.getFloatColumn(j));
        
        correlationMatrix[i][j] = correlation;
        correlationMatrix[j][i] = correlation;
      }
    }
    
    return correlationMatrix;
  }
}
