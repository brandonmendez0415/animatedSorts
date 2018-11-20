int[] vals; //<>// //<>// //<>//
int curr = 0;
void setup() {
  size(640, 500);
  vals = new int[width];
  for (int i = 0; i<width; i++) {
    vals[i] = (int)random(height);
  }
  thread("insertionSort");
}

void swap(int a, int b) {
  int temp = vals[a];
  vals[a] = vals[b];
  vals[b] = temp;
}

void insertionSort() {
  for (int i = 0; i < vals.length; i++) {
    for (int j = i-1; j >= 0; j--) {
      if (vals[j+1] < vals[j]) {
        curr = j;
        swap(j, j+1);
      } else {
        curr = -1;
        continue;
      }
      delay(1);
    }
  }
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
