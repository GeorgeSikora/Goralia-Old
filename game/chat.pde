Chat chat;

class Chat {

  boolean open;
  String str = "";
  int textSize = 20;
  void keyPressed() {
    if (open) {
      if ((key >= 'A' && key <= 'Z')||(key >= 'a' && key <= 'z')||((key >= '0' && key <= '9'))||key=='/'||key==' '||key=='-') {
        str=str+key;
      }
      if (keyCode == BACKSPACE) {
        if (str.length() - 1 >= 0) {
          str = str.substring(0, str.length() - 1);
        }
      }
    }
    if (keyCode == ENTER) {
      if (open) {
        if (str.length()>0) {
          if (str.charAt(0)=='/') {
            String command = str.toLowerCase();
            String[] commands = split(command, ' ');
            switch(commands[0]) {
            case "/hello":
              add("Ahoj " + player.name);
              break;
            case "/speed":
              add(commands.length+"");
              if (commands.length>1) {
                player.speed = int(commands[1]);
              }
              break;
            case "/help":
              add("Příkazy:");
              add("/hello - pozdraví tě");
              add("/speed <číslo> -  nastavení rychlost pohybu hráče");
              break;
            default:
              add("Příkaz neexistuje!");
              break;
            }
          } else {
            add(player.name + " > " + str);
          }
        }
        open = false;
        str = "";
      } else {
        open = true;
        player.stopMoving();
      }
    }
  }
  String[] chatLine = new String[6];
  void draw() {
    textAlign(BOTTOM);

    for (int i = chatLine.length-1; i > -1; i--) {
      if (chatLine[i]!=null) {
        fill(0);
        if (open) {
          text(chatLine[i], 8, height-(i*29)-textSize - 20 - 8, 100);
        } else {
          text(chatLine[i], 8, height-(i*29) - 8, 100);
        }
      }
    }
  }
  void add(String str) {
    for (int i = chatLine.length-1; i > -1; i--) {
      if (i!=0) {
        chatLine[i]=chatLine[i-1];
      }
    }
    chatLine[0] = str;
  }
}
