boolean collidingUp(float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2) {
  if (x1+w1>x2 &&
    x1<x2+w2 &&
    y1+h1>=y2 &&
    y2>y1) {
    return true;
  }
  return false;
}
boolean collidingLeft(float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2) {
  if (y1+h1>y2 &&
    y1<y2+h2 &&
    x1+w1>=x2 &&
    x1<x2) {
    return true;
  }
  return false;
}
boolean collidingRight(float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2) {
  if (y1+h1>y2 &&
    y1<y2+h2 &&
    x1<=x2+w2 &&
    x1>x2) {
    return true;
  }
  return false;
}
boolean collidingDown(float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2) {
  if (x1+w1>x2 &&
    x1<x2+w2 &&
    y2+h2>=y1 &&
    y2<y1) {
    return true;
  }
  return false;
}

boolean boxCollision(float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2) {
  if (collidingUp(x1, y1, w1, h1, x2, y2, w2, h2) || collidingLeft(x1, y1, w1, h1, x2, y2, w2, h2) || collidingRight(x1, y1, w1, h1, x2, y2, w2, h2) || collidingDown(x1, y1, w1, h1, x2, y2, w2, h2)) {
    return true;
  } else {
    return false;
  }
}

void playerMove() {
  boolean collisionLeft = false;
  boolean collisionRight = false;
  boolean collisionUp = false;
  boolean collisionDown = false;

  for (int obj = 0; obj < objects.size(); obj++) {
    GameObject object =  objects.get(obj);
    for (int col = 0; col < object.collisions.size(); col++) {

      float x =object.collisions.get(col).x;
      float y =object.collisions.get(col).y;
      float w =object.collisions.get(col).w;
      float h = object.collisions.get(col).h;

      float px = player.cx*chunkSize+player.x-4;
      float py = player.cy*chunkSize+player.y;
      float pw = 8;
      float ph = 8;

      if (collidingUp(px, py+player.speed*deltaTime, pw, ph, x, y, w, h) && player.down == 1) {
        collisionUp = true;
        if (py < 0) {
          player.y = abs((y-ph)%chunkSize);
          player.y = 400-player.y;
        } else {
          player.y = abs((y-ph)%chunkSize);
        }
      }
      if (collidingDown(px, py-player.speed*deltaTime, pw, ph, x, y, w, h) && player.up == 1) {
        collisionDown = true;
        if (py < 0) {
          player.y = abs((y+h)%chunkSize);
          player.y = 400-player.y;
        } else {
          player.y = abs((y+h)%chunkSize);
        }
      }
      if (collidingLeft(px+player.speed*deltaTime, py, pw, ph, x, y, w, h) && player.right == 1) {
        collisionLeft = true;
        if (px < 0) {
          player.x = abs((x-pw+4)%chunkSize);
          player.x = 400-player.x;
        } else {
          player.x = abs((x-pw+4)%chunkSize);
        }
      }
      if (collidingRight(px-player.speed*deltaTime, py, pw, ph, x, y, w, h) && player.left == 1) {
        collisionRight = true;
        if (px < 0) {
          player.x = abs((x+w+4)%chunkSize);
          player.x = 400-player.x;
        } else {
          player.x = abs((x+w+4)%chunkSize);
        }
      }
    }
  }

  if (!collisionDown) {
    player.y -= player.up*player.speed*deltaTime;
  }
  if (!collisionUp) {
    player.y += player.down*player.speed*deltaTime;
  }
  if (!collisionRight) {
    player.x -= player.left*player.speed*deltaTime;
  }
  if (!collisionLeft) {
    player.x += player.right*player.speed*deltaTime;
  }
}