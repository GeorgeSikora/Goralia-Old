void keyPressed() {
  if (key=='x' || key=='X')
    showInfo = !showInfo;
  if (key=='c' || key=='C') {
    if (cam.mode) {
      cam.x = 0;
      cam.y = 0;
      cam.mode = false;
    } else {
      cam.zw = width/2;
      cam.zh = height/2;
      cam.x = player.x-width/2;
      cam.y = player.y-height/2;
      cam.mode = true;
    }
  }
  if (key=='-') {
    cam.zw+=width/100+cam.zw/8;
    cam.zh+=height/100+cam.zh/8;
  }
  if (key=='+') {
    cam.zw-=width/100+cam.zw/8;
    cam.zh-=height/100+cam.zh/8;
  }

  // Player movement
  // if (!cam.mode && !chat.open) {
  if (key=='a' || key=='A') 
    player.left = 1;
  if (key=='d' || key=='D')
    player.right = 1;
  if (key=='w' || key=='W')
    player.up = 1;
  if (key=='s' || key=='S')
    player.down = 1;
  // Inventory
  if (key=='q' || key=='Q') {
    if (takenCount>0) {
      takenCount--;
    }
    //}
  }

  chat.keyPressed();
  /*
  if (key == CODED) {
   if (keyCode == UP) {
   println("yes");
   chat.open = !chat.open;
   }
   }*/
}

void keyReleased() {
  player.lastUp = player.up;
  player.lastDown = player.down;
  player.lastLeft = player.left;
  player.lastRight = player.right;

  if (key=='a' || key=='A')
    player.left = 0;
  if (key=='w' || key=='W')
    player.up = 0;
  if (key=='s' || key=='S')
    player.down = 0;
  if (key=='d' || key=='D') {
    player.right = 0;
  }
}
