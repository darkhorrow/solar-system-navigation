Star star;
float ZOOM = 1;
float MX;
float MY;
float RX = -PI/6;
float RY = PI/3;
PImage bgImage;

PShape ship;
PVector direction = new PVector(0, 0, -1);
float PX, PY, PZ;
float speed = 0;

boolean FPS = true;

void setup() {
  size(1024, 768, P3D);
  noSmooth();
  bgImage = loadImage("data/bg.jpg");
  MX = width/2;
  MY = height/2;

  PX = MX;
  PY = MY;
  PZ = ZOOM + 200;

  star = new Star(100, 0.25, "data/sun.jpg");
  Planet pl2 = new Planet(200, 40, 0.5, 1, 100, "data/planet2.jpg");
  pl2.satellites.add(new Satellite(0, 5, 0.5, 3, 10, "data/satellite1.jpg"));
  star.planets.add(pl2);
  star.planets.add(new Planet(45, 30, 0.5, 0.5, 200, "data/planet4.jpg"));
  star.planets.add(new Planet(90, 20, 0.5, 1, 300, "data/planet3.jpg"));
  Planet pl1 = new Planet(0, 50, 0.5, 1, 400, "data/planet1.jpg");
  pl1.satellites.add(new Satellite(0, 5, 0.5, 3, 10, "data/satellite1.jpg"));
  pl1.satellites.add(new Satellite(60, 5, 0.5, 5, 30, "data/satellite1.jpg"));
  star.planets.add(pl1);
  star.planets.add(new Planet(10, 40, 0.5, 0.5, 500, "data/planet5.jpg"));

  ship = loadShape("ARC170.obj");
  ship.rotateX(radians(180));
  ship.rotateY(radians(180));
  ship.scale(0.1);
}

void draw() {
  text("Planetary system", width/2, 0);
  background(bgImage.get(constrain(int(MX*0.1), 0, width/4), constrain(int(MY*0.1), 0, height/2), width, height));

  pushMatrix();
  lights();
  noStroke();
  translate(MX, MY, ZOOM);
  rotateX(RX);
  rotateY(RY);
  star.display();
  popMatrix();

  pushMatrix();

  PX = PX + speed * direction.x;
  PY = PY + speed * direction.y;
  PZ = PZ + speed * direction.z;


  translate(PX, PY, PZ);
  shape(ship);

  if (FPS) {
    fill(255);
    textMode(SHAPE);
    textSize(5);
    textAlign(LEFT, CENTER);
    text("> Press 'F' key to change to the system view", 30, 90);
    text("> Mouse wheel to zoom in/out", 30, 100);
  }

  popMatrix();

  if (FPS) {
    camera(PX, PY, PZ + 200, PX, PY, PZ, 0, 1, 0);
  } else {
    camera();
    fill(255);
    textMode(SHAPE);
    textSize(20);
    textAlign(LEFT, CENTER);
    text("> Left click drag to move the whole system", 10, 15);
    text("> Right click drag to rotate the whole system", 10, 40);
    text("> Mouse wheel to zoom in/out", 10, 65);
    text("> Press 'R' key to restore to default the system", 10, 90);
    text("> Press 'F' key to change to the ship view", 10, 115);
  }
}

void keyPressed() {
  if (keyCode == 'R') {
    ZOOM = 1;
    RX = -PI/6;
    RY = PI/3;
    MX = width/2;
    MY = height/2;
  }
  if (keyCode == 'F') {
    if (FPS) {
      FPS = false;
    } else {
      FPS = true;
    }
  }
  if (keyCode == 'W') speed = 5;
  if (keyCode == 'S') speed = -5;
  if (keyCode == UP) direction.y -= 0.5;
  if (keyCode == DOWN) direction.y += 0.5;
  if (keyCode == LEFT) direction.x -= 0.5;
  if (keyCode == RIGHT) direction.x += 0.5;
}

void keyReleased() {
  if (keyCode == 'W') speed = 0;
  if (keyCode == 'S') speed = 0;
  if (keyCode == UP) direction.y = 0;
  if (keyCode == DOWN) direction.y = 0;
  if (keyCode == LEFT) direction.x = 0;
  if (keyCode == RIGHT) direction.x = 0;
}

void mouseWheel(MouseEvent event) {
  ZOOM += event.getCount() * 100;
}

void mouseDragged() {
  if (mouseButton == LEFT) {
    MX = mouseX;
    MY = mouseY;
  } else if (mouseButton == RIGHT) {
    RY += radians(mouseX - pmouseX);
  }
}
