// Basic
int chunkSize = 160;
PGraphics background;
float deltaTime;
int scale = 7;

// Inventory
int itemSize=64, maxItems=64;
int takenItem, takenCount;

// informace o promennych
String informations;

// pro zobrazení hranic chunku
boolean showInfo;

void setup() {
  size(800, 450, P3D);
  //fullScreen(P3D);
  frameRate(60);
  hint(ENABLE_DEPTH_SORT);
  textAlign(LEFT, TOP);
  textSize(20);
  ((PGraphicsOpenGL)g).textureSampling(3);

  cam = new Camera();
  img = new Images();
  anim = new Animations();
  chat = new Chat();

  player = new Player();

  generateBackground();

  noiseSeed(0);
  tiles = cut("tiles.png", 16, 16);
  tile = new Tile(10, 10);

  loadObjects();

  for (int i = 0; i < 54; i++) {
    player.inventory.addItem(int(random(7)), int(random(maxItems)));
  }
}

void draw() {
  deltaTime = 60/frameRate;
  cam.refresh();

  drawGame();

  checkChunks();
}

void generateBackground() {
  background = createGraphics(chunkSize, chunkSize);
  background.beginDraw();
  for (int x = 0; x < chunkSize/img.background.width; x++) {
    for (int y = 0; y < chunkSize/img.background.height; y++) {
      background.image(img.background, x*img.background.width, y*img.background.height);
    }
  }
  background.endDraw();
}
