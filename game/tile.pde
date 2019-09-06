PImage[] tiles;

int grid = 16;
int mx, my;

final int AIR = 0;
final int WATER = 1;
final int SAND = 2;
final int GRASS = 3;

int[] solidTiles = {SAND, GRASS};

Tile tile;

class Tile {
  byte[][] id, texture;
  int w, h;
  Tile(int w, int h) {
    this.w = w;
    this.h = h;
    id = new byte[w][h];
    texture = new byte[w][h];
  }
}

void loadMap(int xx, int yy) {
  float d0 = 18;   
  float d1 = 10;
    for (int y = 0; y < tile.h; y++) {
      for (int x = 0; x < tile.w; x++) {
        float n0 = noise((x+xx)/d0, (y+yy)/d0, 0.0); 
        float n1 = noise((x+xx)/d1, (y+yy)/d1, 10.0); 
        float n = 1 - (n0*0.75 + n1*0.25); 
        if (n < 0.50) {
          tile.id[x][y] = WATER;
        } else if ( n < 0.60) {
          tile.id[x][y] = SAND;
        } else {
          tile.id[x][y] = SAND;
        }
      }
    }
  
}
