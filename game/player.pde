Player player;

class Player {
  Inventory inventory; // inventář určený pro hráče
  Collision minningLeft, minningRight, minningUp, minningDown;

  float x, y, speed = 0.75; // souřadnice a rychlost
  int left, right, up, down; // pohyb hráče do stran
  int lastUp, lastDown, lastLeft, lastRight; // předešlý pohyb
  int cx, cy; // chunkX a chunkY

  String name = "George";

  boolean moving; // jestli se hráč hýba tak..
  boolean minning; // jestli se hráč těží tak..

  int animationIndex; // index obrázku, který se aktuálně zobrazuje v animaci
  int animationSpeed = 100; // zpoždění mezi snímky v animaci v ms
  int lastAnimationTime; // časovač na animaci
  int interval[]; // interval animace

  int facing; // -1 = left; 0 = down; 1 = right; 2 = up

  int invRows = 9; // počet sloupců v inventáři
  int invColumns = 6; // počet řádků

  Player() {
    x = chunkSize/2; // Vycentruje hráče na střed chunku
    y = chunkSize/2;
    inventory = new Inventory(width/2, height/2, invRows, invColumns); // Vytvoří hráči inventář
    lastAnimationTime = millis(); // nastavení animačního časovače na aktuální časovač

    minningLeft = new Collision(0, 0, 3, 3);
    minningRight = new Collision(0, 0, 3, 3);
    minningUp = new Collision(0, 0, 3, 3);
    minningDown = new Collision(0, 0, 3, 3);
  }

  void reloadCollisions() {
    minningLeft.x = x + cx*chunkSize;
    minningLeft.y = y + cy*chunkSize;
    minningRight.x = x + cx*chunkSize;
    minningRight.y = y + cy*chunkSize;
    minningUp.x = x + cx*chunkSize;
    minningUp.y = y + cy*chunkSize;
    minningDown.x = x + cx*chunkSize;
    minningDown.y = y + cy*chunkSize;
  }

  void draw() {
    playerMove(); // POHYB A KOLIZE HRÁČE !!! POTŘEBA PŘESUNOUT DO INTERNÍ TŘÍDY HRÁČE !!!

    reloadCollisions();

    int lastInterval[] = interval; // předešlý interval animace

    if (moving && !minning) { // když se hráč hýbe, ale netěží tak se jeho animace je taková, kde směřuje
      if (lastLeft == 1) {
        facing = -1;
      } else if (lastRight == 1) {
        facing = 1;
      } else if (lastDown == 1) {
        facing = 0;
      } else if (lastUp == 1) {
        facing = 2;
      }
    }
    if (minning && (moving || !mousePressed)) { // když hráč těží a začne se hýbat nebo uvolní tlačítko myši, tak těžba přestane
      minning = false;
    }

    if (left ==1 || right == 1 || down == 1|| up == 1) { // když hráč jde do jakéhokoli směru, hýbe se
      moving = true;
    } else {
      moving = false;
    }


    // VÝBĚR INTERVALŮ ANIMACE PODLE PODMÍNEK
    if (left == 1) {
      interval = anim.left;
    } else if (right == 1) {
      interval = anim.right;
    } else if (up == 1) {
      interval = anim.up;
    } else if (down == 1) {
      interval = anim.down;
    } else if (minning) {
      if (facing == 1) {
        interval = anim.minningRight;
      } else if (facing == -1) {
        interval = anim.minningLeft;
      }
    } else {
      if (facing == -1) {
        interval = anim.idleLeft;
      } else if (facing == 1) {
        interval = anim.idleRight;
      } else if (facing == 2) {
        interval = anim.idleUp;
      } else {
        interval = anim.idleDown;
      }
    }

    // jestli se animace změní dojde k restartování indexu animace, protože by nemusel být na začátku jiného intervalu
    if (lastInterval != interval) {
      animationIndex = interval[0];
    }

    // časovač, který posouvá snímek co snímek a tvoří animaci podle intervalu
    if (millis() - lastAnimationTime >= animationSpeed) {
      animationIndex++;
      if (animationIndex > interval[1]) {
        animationIndex = interval[0];
      }
      lastAnimationTime = millis();
    }

    image(anim.player[animationIndex], -10, -10); // konečné vykreslení hráče s indexem snímku animace
  }
  
  void stopMoving() {
    left = 0;
    right = 0;
    up = 0;
    down = 0;
  }
}
