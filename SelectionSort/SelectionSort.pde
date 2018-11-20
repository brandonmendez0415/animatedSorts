int[] vals;
int curr = 0;
void setup() {
  size(640, 500);
  vals = new int[width];
  for (int i = 0; i<width; i++) {
    vals[i] = (int) random(height);
  }
  thread("selectionSort");
}
void swap(int a, int b) {
  int temp = vals[a];
  vals[a] = vals[b];
  vals[b] = temp;
}
void selectionSort() {
  for (int i = 0; i < vals.length; i++) {
    int min = Integer.MAX_VALUE;
    int minIndex = -1;
    for (int j = vals.length-1; j >= i; j--) {
      curr = j;
      if (vals[j] < min) {
        min = vals[j];
        minIndex = j;
      }
      delay(1);
    }
    if (minIndex != -1)
      swap(minIndex, i);
  }
  curr = -1;
}
void draw() {
  background(0);
  for (int i = 0; i<width; i++) {
    stroke(255);
    if (i == curr)
      stroke(255, 0, 0);
    line(i, height, i, height - vals[i]);
  }
}
