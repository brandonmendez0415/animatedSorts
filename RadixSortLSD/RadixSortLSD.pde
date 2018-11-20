int[] vals;
int curr = -1;
boolean firstRun = true;
boolean secondRun = false;
void setup() {
  size(640, 500);
  vals = new int[width];
  for (int i = 0; i<width; i++) {
    vals[i] = (int)random(height);
  }
}

int findMax(int[] a) {
  int max = Integer.MIN_VALUE;
  for (int i = 0; i<a.length; i++) {
    if (a[i] > max) {
      max = a[i];
    }
  }
  return max;
}

void bin(int place) {
  int[] binned = new int[vals.length];
  int[] counts = new int[10];
  for (int i = 0; i<vals.length; i++) {
    counts[(vals[i]/place)%10]++;
  }
  for (int i = 1; i<counts.length; i++) {
    counts[i] += counts[i-1];
  }
  for (int i = vals.length - 1; i >= 0; i--) { 
    binned[counts[(vals[i]/place)%10] - 1] = vals[i]; 
    counts[(vals[i]/place)%10]--;
  }
  for (int i = 0; i<vals.length; i++) {
    curr = i;
    vals[i] = binned[i];
    delay(1);
  }
  curr = -1;
}

void radixSort() {
  int max = findMax(vals);
  for (int i = 1; max/i > 0; i *= 10) {
    bin(i);
  }
}

void draw() {
  background(0);
  for (int i = 0; i<width; i++) {
    stroke(255);
    if (i == curr)
      stroke(255, 0, 0);
    line(i, height, i, height - (vals[i]));
  }
  if (firstRun) {
    firstRun = false;
    secondRun = true;
  }
  else if (secondRun) {
    delay(2000);
    secondRun = false;
    thread("radixSort");
  }
}
