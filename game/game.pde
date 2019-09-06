void drawGame() {
  background(0);
  ortho(cam.ox1, cam.ox2, cam.oy1, cam.oy2);
  noStroke();

  /*
  for (int y = -1; y <= 1; y++) {
   for (int x = -1; x <= 1; x++) {
   pushMatrix();
   translate(0, 0, -chunkSize);
   image(background, x*chunkSize, y*chunkSize);
   popMatrix();
   if (showInfo) {
   noFill();
   stroke(255);
   rect(x*chunkSize, y*chunkSize, chunkSize, chunkSize);
   fill(255);
   text("Chunk: X=" + (player.cx + x) + " Y=" + (player.cy + y), x*chunkSize, y*chunkSize);
   }
   }
   }*/

  for (int y = 0; y < tile.h; y++) {
    for (int x = 0; x < tile.w; x++) {
      switch(tile.id[x][y]) {
      case WATER:
        fill(0, 0, 255);
        pushMatrix();
        translate(0, 0, -chunkSize);
        image(tiles[48], x*16, y*16);
        popMatrix();
        break;
      case SAND:
        fill(255, 255, 0);
        break;
      case GRASS:
        fill(0, 255, 0);
        break;
      }
      //rect(x*grid, y*grid, grid, grid);

      if (tile.texture[x][y] != -1) {

        pushMatrix();
        translate(0, 0, -chunkSize);
        image(tiles[tile.texture[x][y]], x*16, y*16);
        popMatrix();
      }
    }
  }

  noStroke();

  for (int i = 0; i < objects.size(); i++) {
    pushMatrix();
    int lay = objects.get(i).layer;
    if (lay == 0) {
      if (objects.get(i).y+25 > player.y) {
        lay = 1;
      } else {
        lay = -1;
      }
    }
    translate(0, 0, lay);
    objects.get(i).draw();
    popMatrix();
    for (int col = 0; col < objects.get(i).collisions.size(); col++) {
      pushMatrix();
      translate(-player.cx*chunkSize, -player.cy*chunkSize);
      objects.get(i).collisions.get(col).draw();
      popMatrix();
    }

    if (objects.get(i).remove) {
      objects.remove(i);
    }

    if (objects.get(i).id == 0) {
    }
  }

  pushMatrix();
  translate(player.x, player.y);
  player.draw();
  popMatrix();

  noFill();
  stroke(0, 255, 0);
  rectMode(CORNER);
  for (float xx = -chunksReload/2; xx <= chunksReload/2; xx+=chunkSize) { // OPRAVIT !!!!!!!!!!!!! místo /2 čistě jen dělitelné chunksize
    for (float yy = -chunksReload/2; yy <= chunksReload/2; yy+=chunkSize) {
      if (dist(player.x, player.y, xx, yy)<chunksReload/2) {
        rect(xx-chunkSize/2, yy-chunkSize/2, chunkSize, chunkSize);
        textSize(30);
        fill(0, 255, 0);
        textAlign(LEFT, TOP);
        text("x"+int((xx-chunkSize/2)/chunkSize+player.cx)+" y"+int((yy-chunkSize/2)/chunkSize+player.cy), xx-chunkSize/2, yy-chunkSize/2);
        noFill();
      }
    }
  }
  stroke(0, 0, 255);
  ellipseMode(CENTER);
  ellipse(player.x, player.y, chunksReload, chunksReload);

  pushMatrix();
  ortho(-width/2, width/2, -height/2, height/2);


  informations = "";
  infoAdd("FPS = " + int(frameRate));
  infoAdd("Objects = " + objects.size());
  infoAdd("player.x = " + player.x);
  infoAdd("player.y = " + player.y);
  infoAdd("chunkX = " + player.cx);
  infoAdd("chunkY = " + player.cy);
  infoAdd("mouseX = " + mouseX);
  infoAdd("mouseY = " + mouseY);
  infoAdd("World X = " + (player.cx * chunkSize + player.x));
  infoAdd("World Y = " + (player.cy * chunkSize + player.y));
  infoAdd("HPoint 1 x = " + p1x + "; y = " + p1y);
  infoAdd("HPoint 2 x = " + p2x + "; y = " + p2y);
  infoAdd("Hpoints distance x = " + abs(p1x-p2x) + "; y = " + abs(p1y-p2y));

  fill(0);
  textAlign(LEFT, TOP);
  text(informations, 5, 5, 100);

  ellipseMode(CENTER);
  fill(0, 255, 255);
  ellipse(p1x*scale, p1y*scale, 5, 5);
  fill(255, 255, 0);
  ellipse(p2x*scale, p2y*scale, 5, 5);

  chat.draw();
  //println(boxCollision(collisions.get(0),collisions.get(0)));
  if (chat.open) {
    pushMatrix();
    translate(0, 0, 99);
    rectMode(CORNER);
    fill(0, 120);
    rect(4, height-chat.textSize-16, 450, chat.textSize+8, 4);
    textAlign(LEFT, TOP);
    fill(255);
    text(chat.str + "_", 8, height-32);
    popMatrix();
  }

  for (Inventory i : inventory) {
    i.draw();
  }
  for (int c = 0; c < box.size(); c++) {
    box.get(c).draw();
  }
  popMatrix();
}

void infoAdd(String str) {
  informations += str + "\n";
}
