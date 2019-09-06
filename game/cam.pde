Camera cam;

class Camera {
  float x, y; 
  float speed = 5;
  float ox1, ox2, oy1, oy2;
  float zh, zw;
  boolean mode;
  Camera() {
    zw = width/2;
    zh = height/2;
  }
  void refresh() {
    if (mode) {
      //x -= (player.left - player.right)*speed*deltaTime;
      //y -= (player.up - player.down)*speed*deltaTime;

      ox1 =x-zw;
      ox2 =x+zw;
      oy1 =-y-zh;
      oy2 =-y+zh;
    } else {
      ox1=x-zw-zw/scale+player.x;
      ox2=x-zw+zw/scale+player.x;
      oy1=-y+zh-zh/scale-player.y;
      oy2=-y+zh+zh/scale-player.y;
    }
  }
}
