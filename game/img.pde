Images img;

class Images {
  PImage background;
  PImage bush, log, strain;

  PImage itemBackground;
  PImage[] item;

  Images() {
    background = loadImage("graphics/texture.png");

    itemBackground = loadImage("graphics/item.png");
    item = cut("graphics/items.png", 16, 16);

    bush = loadImage("graphics/bush.png");
    log = loadImage("graphics/log.png");
    strain = loadImage("graphics/strain.png");
  }
}