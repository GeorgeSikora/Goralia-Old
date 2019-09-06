ArrayList<GameObject> objects = new ArrayList<GameObject>();

abstract class GameObject {
  ArrayList<Collision> collisions;
  float x, y;
  int w, h; 
  int cx, cy;
  int layer;
  int id;
  boolean remove;

  GameObject(int cx, int cy, int id, float x, float y, int layer) {
    collisions = new ArrayList<Collision>();
    this.cx = cx;
    this.cy = cy;
    this.id = id;
    this.x = x;
    this.y = y;
    this.layer = layer;
  }
  abstract void draw();
}

boolean collision(Collision c1, Collision c2) {
  if (boxCollision(c1.x, c1.y, c1.w, c1.h, c2.x, c2.y, c2.w, c2.h)) {
    return true;
  } else {
    return false;
  }
}

ArrayList<Box> box = new ArrayList<Box>();

abstract class Box {
  float x, y, w, h;
  Box(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  void draw() {
    pushMatrix();
    stroke(255, 0, 0);
    translate(0, 0, 100);
    fill(255, 0, 0, 100);
    rect(x, y, w, h);
    popMatrix();
  }
}

class Collision extends Box {
  Collision(float x, float y, float w, float h) {
    super(x, y, w, h);
  }
}

class Tree extends GameObject {  
  float hp = 100;
  int lastAnimationTime = millis();
  int animationSpeed = 120;
  int animationIndex = 0;

  Collision minningArea;

  Tree(int chunkX, int chunkY, int id, float x, float y, int layer) {
    super( chunkX, chunkY, id, x, y, layer);
    minningArea = new Collision(chunkX*chunkSize+x, chunkY*chunkSize+y, 30, 30);
  }
  void draw() {
    if (collision(minningArea, player.minningLeft)) {
      println("Minning !!!!" + random(1000));
      if (mousePressed) {
        hp-=deltaTime;
        player.minning = true;
        if (player.cx*chunkSize+player.x < cx*chunkSize+x+10) {
          player.facing = 1;
        } else {
          player.facing = -1;
        }
      }
    }
    // if (boxCollision((cx)*chunkSize+x+9, (cy)*chunkSize+y+25, 3, 10, player.cx*chunkSize+player.x+5, player.cy*chunkSize+player.y+0, 3, 3) ||
    // boxCollision((cx)*chunkSize+x+9, (cy)*chunkSize+y+25, 3, 10, player.cx*chunkSize+player.x-5-3, player.cy*chunkSize+player.y+0, 3, 3)) {
    //}

    if (hp <= 0) {
      player.minning = false;
      if (millis() - lastAnimationTime >= animationSpeed) {
        if (animationIndex < anim.tree.length-1) {
          animationIndex++;
        } else {
          remove = true;
          objects.add(new Log(cx, cy, 2, x+10, y+20, 0));
          objects.add(new Strain(cx, cy, 3, x+7, y+33, 0));
        }
        lastAnimationTime = millis();
      }
    }

    pushMatrix();
    translate((cx-player.cx)*chunkSize, (cy-player.cy)*chunkSize);
    image(anim.tree[animationIndex], x, y);
    popMatrix();
  }
}

class Log extends GameObject {  
  float hp = 100;
  Collision minningArea;
  Log(int chunkX, int chunkY, int id, float x, float y, int layer) {
    super( chunkX, chunkY, id, x, y, layer);
    minningArea = new Collision(x+3, y+6, 30, 7);
  }
  void draw() {
    if (boxCollision(cx*chunkSize+minningArea.x, cy*chunkSize+y+minningArea.y, minningArea.w, minningArea.h, player.cx*chunkSize+player.x+5, player.cy*chunkSize+player.y+0, 3, 3) || 
      boxCollision(cx*chunkSize+minningArea.x, cy*chunkSize+minningArea.y, minningArea.w, minningArea.h, player.cx*chunkSize+player.x-5-3, player.cy*chunkSize+player.y+0, 3, 3)) {
      if (mousePressed) {
        hp-=deltaTime;
        player.minning = true;
      }
    }

    pushMatrix();
    translate((cx-player.cx)*chunkSize, (cy-player.cy)*chunkSize);
    image(img.log, x, y);
    popMatrix();
  }
}

class Strain extends GameObject {  
  Strain(int chunkX, int chunkY, int id, float x, float y, int layer) {
    super( chunkX, chunkY, id, x, y, layer);
  }
  void draw() {
    pushMatrix();
    translate((cx-player.cx)*chunkSize, (cy-player.cy)*chunkSize);
    image(img.strain, x, y);
    popMatrix();
  }
}



class Bush extends GameObject {  
  Bush(int chunkX, int chunkY, int id, float x, float y, int layer) {
    super( chunkX, chunkY, id, x, y, layer);
  }
  void draw() {
    pushMatrix();
    translate((cx-player.cx)*chunkSize, (cy-player.cy)*chunkSize);
    image(img.bush, x, y);
    popMatrix();
  }
}
