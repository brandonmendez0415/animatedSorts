int[] vals;
int curr = -1;
boolean firstRun = true;
boolean secondRun = false;
void setup() {
  size(640, 500);
  vals = new int[width];
  for (int i = 0; i<width; i++) {
    vals[i] = (int)random(height*2);
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

void bin(int place, int min, int n) {
  if (place == 0)
    return; //<>//
  int[] binned = new int[n-min]; //<>//
  int[] counts = new int[10];
  int[] recount = new int[10];
  for (int i = min; i<n; i++) {
    counts[(vals[i]/place)%10]++;
    recount[(vals[i]/place)%10]++;
  }
  counts[0] += min;
  recount[0] += min;
  for (int i = 1; i<counts.length; i++) {
    counts[i] += counts[i-1];
    recount[i] += recount[i-1];
  }
  for (int i = n - 1; i >= min; i--) {  //<>//
    binned[(counts[(vals[i]/place)%10] - 1)-min] = vals[i]; 
    counts[(vals[i]/place)%10]--;
  }
  for (int i = 0; i<n-min; i++) {
    curr = min + i;
    vals[min + i] = binned[i];
    delay(1);
  }
  for (int i = 0; i<recount.length; i++) {
    int start = i == 0 ? min : recount[i-1];
    bin(place/10, start, recount[i]); //<>//
  }
  curr = -1;
}

void radixSort() {
  int max = findMax(vals);
  int order = (int)Math.pow(10, (int)Math.log10(max));
  bin(order, 0, vals.length);
}

void draw() {
  background(0);
  for (int i = 0; i<width; i++) {
    stroke(255);
    if (i == curr)
      stroke(255, 0, 0);
    line(i, height, i, height - (vals[i]/2));
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
