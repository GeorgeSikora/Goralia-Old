// Help points
int p1x, p1y;
int p2x, p2y;

void mousePressed() {
  if (mouseButton == LEFT) {
    p1x = mouseX/scale;
    p1y = mouseY/scale;
  }
  if (mouseButton == RIGHT) {
    p2x = mouseX/scale;
    p2y = mouseY/scale;
  }
}
void mouseReleased() {
  for (Inventory i : inventory) {
    i.mouseReleased();
  }
}