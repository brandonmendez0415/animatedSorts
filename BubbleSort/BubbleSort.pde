int[] vals;
int curr = 0;
void setup() {
  size(640, 500);
  vals = new int[width];
  for (int i = 0; i<width; i++) {
    vals[i] = (int) random(height);
  }
  thread("bubbleSort");
}
void swap(int a, int b) {
  int temp = vals[a];
  vals[a] = vals[b];
  vals[b] = temp;
}
void bubbleSort() {
  boolean sorted = false;
  while (!sorted) {
    sorted = true;
    for (int i = 0; i < vals.length-1; i++) {
      if (vals[i] > vals[i+1]) {
        swap(i, i+1);
        curr = i;
        delay(1);
        sorted = false;
      }
    }
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
