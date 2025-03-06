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

class StatisticFunctions {

  StatisticFunctions RunCalculation;
  
  float mean(float[] data) {
    float total = 0; //<>//
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
}
