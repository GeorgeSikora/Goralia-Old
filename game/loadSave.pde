int chunksReload = 800;

void loadObjects() {

  loadMap(player.cx*chunkSize/grid, player.cy*chunkSize/grid);


  for (int y = 0; y < tile.h; y++) {
    for (int x = 0; x < tile.w; x++) {
      bitMask(x, y);
    }
  }

  for (int y = -1; y <= 1; y++) {
    for (int x = -1; x <= 1; x++) {
      loadChunk(player.cx  + x, player.cy + y);
    }
  }
}

void saveObjects() {  
  for (int y = -1; y <= 1; y++) {
    for (int x = -1; x <= 1; x++) {
      saveChunk(player.cx + x, player.cy + y);
    }
  }
}

void loadChunk(int cx, int cy) {
  if (fileExists("maps/"+cx + "x" + cy + ".json")) {
    JSONObject load = loadJSONObject("data/maps/"+cx + "x" + cy + ".json");
    JSONArray values = load.getJSONArray("objects");
    for (int i = 0; i < values.size(); i++) {
      JSONObject object = values.getJSONObject(i);

      int id = object.getInt("id");
      int x = object.getInt("x"); 
      int y =object.getInt("y");
      int lay =object.getInt("layer");

      switch(object.getInt("id")) {
      case 0:
        objects.add(new Tree(cx, cy, id, x, y, lay));
        break;
      case 1:
        objects.add(new Bush(cx, cy, id, x, y, lay));
        break;
      case 2:
        objects.add(new Log(cx, cy, id, x, y, lay));
        break;
      case 3:
        objects.add(new Strain(cx, cy, id, x, y, lay));
        break;
      }
    }
  } else {
    for (int i = 0; i < 10; i++) {
      //objects.add(new Tree(cx, cy, 0, random(chunkSize), random(chunkSize), 0));
    }

    for (int i = 0; i < 5; i++) {
      //objects.add(new Bush(cx, cy, 1, random(chunkSize), random(chunkSize), 0));
    }
    saveChunk(cx, cy);
  }
}

void saveChunk(int cx, int cy) {
  JSONArray values = new JSONArray();
  int ArrayIndex = 0;
  for (int i = objects.size()-1; i >= 0; i--) {
    GameObject obj = objects.get(i);
    if (obj.cx == cx && obj.cy == cy) {
      JSONObject object = new JSONObject();
      object.setInt("id", obj.id);
      object.setInt("x", int(obj.x));
      object.setInt("y", int(obj.y));
      object.setInt("layer", obj.layer);

      values.setJSONObject(ArrayIndex, object);
      ArrayIndex++;
    }
  }
  JSONObject save = new JSONObject();
  save.setJSONArray("objects", values);
  saveJSONObject(save, "data/maps/" + cx + "x" + cy + ".json");
}

boolean fileExists(String filename) {
  File file=new File(dataPath(filename));
  boolean exists = file.exists();
  if (exists) {
    return true;
  } else {
    return false;
  }
}
