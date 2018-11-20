int[] vals; //<>//
int curr1 = -1;
int curr2 = -1;
boolean firstRun = true;
boolean secondRun = false;
void setup() {
  size(640, 500);
  background(0);
  vals = new int[width];
  for (int i = 0; i < width; i++) {
    vals[i] = (int)random(height);
  }
}
void quickSort() {
  quick(0, vals.length);
}
int findIndexMax(int min, int maxEx) {
  int max = Integer.MIN_VALUE;
  int maxIndex = -1;
  for (int i = min; i<maxEx; i++) {
    if (vals[i] > max) {
      max = vals[i];
      maxIndex = i;
    }
  }
  return maxIndex;
}
void swapIndices(int a, int b) {
  int temp = vals[a];
  vals[a] = vals[b];
  vals[b] = temp;
}
void quick(int min, int max) {
  if (max - min < 2) return;
  int pivot = (int)random(min, max);
  swapIndices(pivot, max-1);
  pivot = max-1;
  int left = min;
  int right = pivot - 1;
  while (right >= left) {
    if (vals[left] >= vals[pivot] && vals[right] < vals[pivot]) {
      swapIndices(left, right);
      left++;
      right--;
    }
    if (vals[left] < vals[pivot])
      left++;
    if (vals[right] >= vals[pivot])
      right--;
    delay(1);
    curr1 = left;
    curr2 = right;
  }
  swapIndices(left, pivot);
  pivot = left;
  quick(min, pivot);
  quick(pivot+1, max);
  curr1 = -1;
  curr2 = -1;
}
void draw() {  
  background(0);
  for (int i = 0; i < width; i++) {
    stroke(255);
    if (i == curr1 || i == curr2)
      stroke(255, 0, 0);
    line(i, height, i, height-vals[i]);
  }
  if (firstRun) {
    firstRun = false;
    secondRun = true;
  }
  else if (secondRun) {
    delay(2000);
    secondRun = false;
    thread("quickSort");
  }
}
