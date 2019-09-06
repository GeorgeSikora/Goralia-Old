Animations anim;

class Animations {
  PImage[] player, grass, tree;

  int right[] = {0, 5};
  int left[] = {6, 11};
  int down[] = {12, 17};
  int up[] = {18, 23};

  int idleLeft[] = {8, 8};
  int idleRight[] = {2, 2};
  int idleDown[] = {12, 12};
  int idleUp[] = {19, 19};

  int minningRight[] = {24, 25};
  int minningLeft[] = {26, 27};

  Animations() {
    grass = cut("data/graphics/tree.png", 20, 40);
    player = cut("data/graphics/player.png", 20, 20);
    tree = cut("data/graphics/tree.png", 40, 40);
  }
}

PImage[] cut(String data, int tileW, int tileH) {
  PImage imageSet = loadImage(data);
  PImage[] imageTiles = new PImage[imageSet.width/tileW*imageSet.height/tileH];
  int x = 0, y = 0;
  for (int i = 0; i < imageTiles.length; i++) {
    imageTiles[i] = imageSet.get(x*tileW, y*tileH, tileW, tileH);
    x++;
    if (x >= imageSet.width/tileW) {
      x=0;
      y++;
    }
  }
  return imageTiles;
}
