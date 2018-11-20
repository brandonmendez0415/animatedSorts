int[] vals; //<>//
boolean firstRun = true;
boolean secondRun = false;
int curr = -1;

void setup() {
  size(640, 500);
  background(0); //<>//
  vals = new int[width];
  for (int i = 0; i < width; i++) {
    vals[i] = (int)random(height);
  }
}
int[] mergeCombine(int[] a, int[] b, int min) {
  int[] combined = new int[a.length + b.length];
  int i = 0;
  int j = 0;
  while (i < a.length || j < b.length) {
    if (i < a.length && j < b.length) {
      if (a[i] <= b[j]) {
        vals[min + i + j] = a[i];
        combined[i + j] = a[i];
        i++;
      } else if (b[j] <= a[i]) {
        vals[min + i + j] = b[j];
        combined[i+j] = b[j];
        j++;
      }
    } else if (i < a.length && j>=b.length) {
      vals[min + i + j] = a[i];
      combined[i + j] = a[i];
      i++;
    } else {
      vals[min + i + j] = b[j];
      combined[i + j] = b[j];
      j++;
    }
    curr = min + i + j;
    delay(1);
  }
  return combined;
}

int[] splitArray(int[] a, int min, int max) {
  if (max-min == 1) {
    return new int[] {a[min]};
  }
  int midpoint = (min + max)/2;
  int[] splitmerge = mergeCombine(splitArray(a, min, midpoint), splitArray(a, midpoint, max), min);
  return splitmerge;
}
void mergeSort() {
  splitArray(vals, 0, vals.length);
}

void draw() {  
  background(0); //<>//
  for (int i = 0; i < width; i++) {
    stroke(255);
    if (i == curr) //<>//
      stroke(255,0,0);
    line(i, height, i, height-vals[i]);
  }
  if (firstRun) {
    firstRun = false;
    secondRun = true;
  }
  else if (secondRun) {
    delay(2000);
    secondRun = false;
    thread("mergeSort");
  }
}
