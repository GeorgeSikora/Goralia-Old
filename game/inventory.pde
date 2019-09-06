ArrayList<Inventory> inventory = new ArrayList<Inventory>();

class Slot {
  int x, y, itemId, count;
  public Slot(int x, int y) {  
    this.x = x;
    this.y = y;
  } 
  void draw() {
    pushMatrix();
    fill(50);
    stroke(0);
    strokeWeight(1);
    image(img.itemBackground, x, y, itemSize, itemSize);
    textAlign(RIGHT, TOP);
    if (count>0) {
      fill(255);
      translate(0, 0, 1);
      image(img.item[itemId], x, y, itemSize, itemSize);
      textSize(itemSize/2);
      translate(0, 0, 2);
      text(count, x+itemSize, y+itemSize/2);
    }
    popMatrix();
  }
}

class Inventory {
  ArrayList<Slot> slots;
  int row, column;

  Inventory(int x, int y, int row, int column) {
    slots = new ArrayList<Slot>();
    this.row = row;
    this.column = column;
    for (int c = 0; c < column; c++) {
      for (int r = 0; r < row; r++) {
        slots.add( new Slot(r*itemSize+x-row*itemSize/2, c*itemSize+y-column*itemSize/2));
      }
    }
  }
  void draw() {
    for (int i = 0; i < slots.size(); i++) {
      Slot slot = slots.get(i);
      slot.draw();
    }
    if (takenCount>0) {    
      pushMatrix();
      translate(0, 0, 3);
      image(img.item[takenItem], mouseX-itemSize/2, mouseY-itemSize/2, itemSize, itemSize);
      fill(255);
      textAlign(RIGHT, TOP);
      textSize(itemSize/2);
      translate(0, 0, 4); 
      text(takenCount, mouseX+itemSize/2, mouseY);
      popMatrix();
    }
  }
  void mouseReleased() {
    for (int i = 0; i < slots.size(); i++) {
      Slot slot = slots.get(i);
      if (slot.x < mouseX && slot.y < mouseY && slot.x+itemSize >= mouseX && slot.y+itemSize >= mouseY) {
        if (mouseButton == LEFT) {
          if (slot.count == 0) {
            slot.itemId = takenItem;
            slot.count = takenCount;
            takenItem = 0;
            takenCount = 0;
          } else {
            if (takenCount==0) {
              takenItem = slot.itemId;
              takenCount = slot.count;
              slot.count = 0;
              slot.itemId = 0;
            } else {
              if (slot.itemId==takenItem) {
                if (slot.count+takenCount <= maxItems) {
                  slot.count+=takenCount;
                  takenItem = 0;
                  takenCount = 0;
                } else {
                  takenCount = takenCount + slot.count - maxItems;
                  slot.count = 64;
                }
              } else {
                int slotCount = slot.count;
                int slotItem = slot.itemId;
                slot.count = takenCount;
                slot.itemId = takenItem;
                takenItem = slotItem;
                takenCount = slotCount;
              }
            }
          }
        }
        if (mouseButton == RIGHT) {
          if (slot.count > 1 && takenCount == 0) {
            takenItem = slot.itemId;
            if (slot.count % 2 == 0) {
              takenCount = slot.count/2;
            } else {
              takenCount = slot.count/2+1;
            }
            slot.count = slot.count/2;
          }
        }
      }
      if (slot.y<0 || slot.x<0 || mouseY>column*itemSize || mouseX>row*itemSize) {
        if (takenCount>0) {
          if (mousePressed) {
            println(mouseX + " < " + column*itemSize);
            takenCount=0;
          }
        }
      }
    }
  }

  boolean addItem(int item, int count) {
    for (int i = 0; i < slots.size(); i++) {
      Slot slot = slots.get(i);
      if (slot.itemId == item) {
        if (slot.count + count <= maxItems) {
          slot.count += count;
          count = 0;
        } else {
          count = count + slot.count - maxItems;
          slot.count = 64;
        }
      }
      if (slot.count == 0) {
        slot.count = count;
        slot.itemId = item;
        count = 0;
      }
    }
    if (count==0) {
      return true;
    } else {
      return false;
    }
  }
}