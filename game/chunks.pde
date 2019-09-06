int[][] chunkId = new int[9][9];

int getChunkId(int cx, int cy){
  int zeroCross = (chunkId.length-1)/2;
  return chunkId[cx+zeroCross][cy+zeroCross];
}

void checkChunks() {
  if (player.x > chunkSize) {
    saveObjects();
    player.cx++;
    reloadChunks();
    player.x -= chunkSize;
  }
  if (player.x < 0) {
    saveObjects();
    player.cx--;
    reloadChunks();
    player.x += chunkSize;
  }
  if (player.y > chunkSize) {
    saveObjects();
    player.cy++;
    reloadChunks();
    player.y -= chunkSize;
  }
  if (player.y < 0) {
    saveObjects();
    player.cy--;  
    reloadChunks();
    player.y += chunkSize;
  }
}

void reloadChunks() {
  for (int i = objects.size()-1; i >= 0; i--) {
    objects.remove(i);
  }
  loadObjects();
}
