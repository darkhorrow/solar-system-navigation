Star star;
float ZOOM = 1;
float MX;
float MY;
float RX = -PI/6;
float RY = PI/3;
PImage bgImage;

void setup() {
  size(1024, 768, P3D);
  smooth(4);
  bgImage = loadImage("data/bg.jpg");
  MX = width/2;
  MY = height/2;
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

  fill(255);
  textMode(SHAPE);
  textSize(20);
  textAlign(LEFT, CENTER);
  text("> Left click drag to move the whole system", 10, 15);
  text("> Right click drag to rotate the whole system", 10, 40);
  text("> Mouse wheel to zoom in/out", 10, 65);
  text("> Press 'R' key to restore to default the system", 10, 90);
}

void keyPressed() {
  if (keyCode == 'R') {
    ZOOM = 1;
    RX = -PI/6;
    RY = PI/3;
    MX = width/2;
    MY = height/2;
  }
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
