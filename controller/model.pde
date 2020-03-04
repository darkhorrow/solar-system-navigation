abstract class CelestialBody {
  private float diameter;
  private float rotationAngle = 0;
  private float translationAngle = 0;
  private float rotationFrequency;
  private float translationFrequency;
  private PImage texture;

  // Non-translatable celestial bodies
  public CelestialBody(float diameter, float rotationFrequency, String texture) {
    this.diameter = diameter;
    this.rotationFrequency = rotationFrequency;
    this.texture = (texture != null && texture != "") ? loadImage(texture) : null;
  }

  // Translatable celest bodies
  public CelestialBody(float initialAngle, float diameter, float rotationFrequency, float translationFrequency, String texture) {
    translationAngle = initialAngle % 360;
    this.diameter = diameter;
    this.rotationFrequency = rotationFrequency;
    this.translationFrequency = translationFrequency;
    this.texture = (texture != null && texture != "") ? loadImage(texture) : null;
  }
}

class Star extends CelestialBody {
  ArrayList<Planet> planets = new ArrayList<Planet>();

  public Star(float diameter, float rotationFrequency, String texture) {
    super(diameter, rotationFrequency, texture);
  }

  void display() {
    // Display the star
    pushMatrix();
    beginShape();
    PShape star = createShape(SPHERE, super.diameter);
    endShape();
    rotateY(radians(super.rotationAngle));
    super.rotationAngle = (super.rotationAngle + super.rotationFrequency) % 360;
    star.setTexture(super.texture);
    shape(star);
    popMatrix();
    
    // Display the star´s planets
    for (Planet planet : planets) {
      planet.display(this);
    }
    
    
    // Text
    pushMatrix();
    fill(255);
    rotateY(-PI/2 - 100);
    textSize(50);
    textAlign(CENTER, CENTER);
    text("Star", 0, -super.diameter - 50);
    popMatrix();
  }

  float getDiameter() {
    return super.diameter;
  }
}

class Planet extends CelestialBody {
  ArrayList<Satellite> satellites = new ArrayList<Satellite>();
  float distanceToStar;

  public Planet(float initialAngle, float diameter, float rotationFrequency, float translationFrequency, float distanceToStar, String texture) {
    super(initialAngle, diameter, rotationFrequency, translationFrequency, texture);
    this.distanceToStar = distanceToStar;
  }

  void display(Star parent) {
    pushMatrix();
    beginShape();
    PShape planet = createShape(SPHERE, super.diameter);
    endShape();
    float distance = distanceToStar + parent.getDiameter() + super.diameter/2;
    translate(distance * cos(radians(super.translationAngle)), 0, distance * sin(radians(super.translationAngle)));
    rotateY(radians(super.rotationAngle));
    super.rotationAngle = (super.rotationAngle + super.rotationFrequency) % 360;
    super.translationAngle = (super.translationAngle + super.translationFrequency) % 360;
    planet.setTexture(super.texture);
    shape(planet);   

    // Display the planet´s satellites
    for (Satellite satellite : satellites) {
      satellite.display(this);
    }

    fill(255);
    textSize(20);
    textAlign(CENTER, CENTER);
    rotateY(-radians(super.rotationAngle) - PI/2 - 100);
    text("Planet", 0, -super.diameter - 50);
    
    popMatrix();
  }

  float getDiameter() {
    return super.diameter;
  }
}

class Satellite extends CelestialBody {
  float distanceToPlanet;

  public Satellite(float initialAngle, float diameter, float rotationFrequency, float translationFrequency, float distanceToPlanet, String texture) {
    super(initialAngle, diameter, rotationFrequency, translationFrequency, texture);
    this.distanceToPlanet = distanceToPlanet;
  }

  void display(Planet parent) {
    pushMatrix();
    beginShape();
    PShape satellite = createShape(SPHERE, super.diameter);
    endShape();
    float distance = distanceToPlanet + parent.getDiameter() + super.diameter/2;
    translate(distance * cos(radians(super.translationAngle)), 0, distance * sin(radians(super.translationAngle)));
    rotateY(radians(super.rotationAngle));
    super.rotationAngle = (super.rotationAngle + super.rotationFrequency) % 360;
    super.translationAngle = (super.translationAngle + super.translationFrequency) % 360;
    satellite.setTexture(super.texture);
    shape(satellite);

    pushMatrix();
    fill(255);
    rotateY(- 2 * radians(super.rotationAngle) - PI/2 - 100);
    textSize(10);
    textAlign(CENTER, CENTER);
    text("Satellite", 0, -super.diameter - 20);
    popMatrix();

    popMatrix();
  }
}
