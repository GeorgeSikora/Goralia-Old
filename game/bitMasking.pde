
void bitMask(int tX, int tY) {
  byte texture = -1;
  // P - písek V - voda S - solid X - anythink

  //  P P P
  //  P P P
  //  P P P

  // OBKLOPENÝ TILE

  if (tilesComparator(tX, tY, "222222222")) {
    texture = 0;
  }

  //  x V x
  //  V P V
  //  x V x

  // JEDNOTNÝ TILE

  if (tilesComparator(tX, tY, "x1x121x1x")) {
    texture = 1;
  }

  //  x V x
  //  V P P
  //  x V x

  // PŘIPOJENÝ TILE Z JEDNOHO BOKU

  if (tilesComparator(tX, tY, "x1x122x1x")) {
    texture = 2;
  }
  if (tilesComparator(tX, tY, rotateTile("x1x122x1x", 90))) {
    texture = 3;
  }
  if (tilesComparator(tX, tY, rotateTile("x1x122x1x", 180))) {
    texture = 4;
  }
  if (tilesComparator(tX, tY, rotateTile("x1x122x1x", 270))) {
    texture = 5;
  }

  //  X V X
  //  P P P
  //  X V X

  // PŘEMOSŤOVACÍ TILE Z DVOU PROTĚJŠÍCH BOKŮ

  if (tilesComparator(tX, tY, "x1x222x1x")) {
    texture = 6;
  }
  if (tilesComparator(tX, tY, rotateTile("x1x222x1x", 90))) {
    texture = 7;
  }

  //  S P X     X P S     X V X     S S S
  //  S P V  |  V P S  |  P P P  |  P P P
  //  S P X     X P S     S S S     X V X

  // VODOROVNÉ A SVISLÉ VYHLAZENÉ ROVINY

  if (tilesComparator(tX, tY, "s2xs21s2x")) {
    texture = 8;
  }
  if (tilesComparator(tX, tY, "sss222x1x")) { // sss222x1x
    texture = 9;
  }
  if (tilesComparator(tX, tY, "x2s12sx2s")) { // x2s12sx2s
    texture = 10;
  }
  if (tilesComparator(tX, tY, "x1x222sss")) { // x1x222sss
    texture = 11;
  }

  // VYHLAZENÉ OKRAJE

  //  X V X     S P X     X P S     X V X
  //  P P V  |  P P V  |  V P P  |  V P P
  //  S P X     X V X     X V X     X P S

  if (tilesComparator(tX, tY, "x1x221s2x")) {
    texture = 12;
  }
  if (tilesComparator(tX, tY, rotateTile("x1x221s2x", 90))) {
    texture = 13;
  }
  if (tilesComparator(tX, tY, rotateTile("x1x221s2x", 180))) {
    texture = 14;
  }
  if (tilesComparator(tX, tY, rotateTile("x1x221s2x", 270))) {
    texture = 15;
  }

  // ROHY

  //  X P V     S S X
  //  S P P  |  S P P
  //  S S X     X P Vtr

  if (tilesComparator(tX, tY, "s21s22sss")) {
    texture = 16;
  }
  if (tilesComparator(tX, tY, rotateTile("s21s22sss", 90))) {
    texture = 17;
  }
  if (tilesComparator(tX, tY, rotateTile("s21s22sss", 180))) {
    texture = 18;
  }
  if (tilesComparator(tX, tY, rotateTile("s21s22sss", 270))) {
    texture = 19;
  }

  // DVOJITE ROHY

  //  S P V
  //  S P P
  //  S P V

  if (tilesComparator(tX, tY, "s21s22s21")) {
    texture = 20;
  }
  if (tilesComparator(tX, tY, rotateTile("s21s22s21", 90))) {
    texture = 21;
  }
  if (tilesComparator(tX, tY, rotateTile("s21s22s21", 180))) {
    texture = 22;
  }
  if (tilesComparator(tX, tY, rotateTile("s21s22s21", 270))) {
    texture = 23;
  }

  // ROHY S SVISLÁ-LICHÁ VYHLAZENÉ ROVINY

  //  X P V
  //  V P P
  //  X P P

  if (tilesComparator(tX, tY, "x21122x22")) {
    texture = 24;
  }
  if (tilesComparator(tX, tY, rotateTile("x21122x22", 90))) {
    texture = 25;
  }
  if (tilesComparator(tX, tY, rotateTile("x21122x22", 180))) {
    texture = 26;
  }
  if (tilesComparator(tX, tY, rotateTile("x21122x22", 270))) {
    texture = 27;
  }


  // ROHY S VODOROVNÉ-LICHÁ VYHLAZENÉ ROVINY

  //  P P V
  //  P P P
  //  X V X


  if (tilesComparator(tX, tY, "221222x1x")) {
    texture = 28;
  }
  if (tilesComparator(tX, tY, rotateTile("221222x1x", 90))) {
    texture = 29;
  }
  if (tilesComparator(tX, tY, rotateTile("221222x1x", 180))) {
    texture = 30;
  }
  if (tilesComparator(tX, tY, rotateTile("221222x1x", 270))) {
    texture = 31;
  }


  // ROHY S VNITŘKEM A VYHLAZENÝM OKRAJEM

  //  X V X
  //  P P V
  //  V P X

  if (tilesComparator(tX, tY, "x1x22112x")) {
    texture = 32;
  }
  if (tilesComparator(tX, tY, rotateTile("x1x22112x", 90))) {
    texture = 33;
  }
  if (tilesComparator(tX, tY, rotateTile("x1x22112x", 180))) {
    texture = 34;
  }
  if (tilesComparator(tX, tY, rotateTile("x1x22112x", 270))) {
    texture = 35;
  }

  tile.texture[tX][tY] = texture;
}

String rotateTile(String in, int degree) {
  char[] c = in.toCharArray();
  switch(degree) {
  case 90:
    return str(c[6])+str(c[3])+str(c[0])+str(c[7])+str(c[4])+str(c[1])+str(c[8])+str(c[5])+str(c[2]);
  case 180:
    return str(c[8])+str(c[7])+str(c[6])+str(c[5])+str(c[4])+str(c[3])+str(c[2])+str(c[1])+str(c[0]);
  case 270:
    return str(c[2])+str(c[5])+str(c[8])+str(c[1])+str(c[4])+str(c[7])+str(c[0])+str(c[3])+str(c[6]);
  case 360:
    return str(c[0])+str(c[1])+str(c[2])+str(c[3])+str(c[4])+str(c[5])+str(c[6])+str(c[7])+str(c[8]);
  }
  return "";
}

boolean tilesComparator(int x, int y, String neighbors1) {
  String neighbors2 = getNeighbors(x, y);

  for (int i = 0; i < 9; i++) {
    if (neighbors1.charAt(i) != 'x') {
      if (neighbors1.charAt(i) != neighbors2.charAt(i)) {
        boolean searched = false;
        if (neighbors1.charAt(i) == 's') {
          for (int s = 0; s < solidTiles.length; s++) {
            if (int(str(neighbors2.charAt(i))) == solidTiles[s]) {
              searched = true;
            }
          }
        }
        //println("iksde", i, searched);
        if (!searched) {
          return false;
        }
      }
    }
  }
  return true;
}

String getNeighbors(int x, int y) {
  String output = "";
  for ( int yy = -1; yy <= 1; yy++) {
    for ( int xx = -1; xx <= 1; xx++) {
      int outX = x+xx, outY = y+yy;
      if (outX < 0 || outX >= tile.w) {
        outX = x;
      }
      if (outY < 0 || outY >= tile.h) {
        outY = y;
      }
      output += tile.id[outX][outY];
    }
  }
  return output;
}
