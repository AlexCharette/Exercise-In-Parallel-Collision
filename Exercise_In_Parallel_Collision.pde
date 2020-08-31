
World world;

PVector mouse;
int borderBuffer;

void setup() {
  // Set the size for the canvas
  size(800, 600, P3D);
  // Set a color for the background
  background(255);
  // Call the constructors for the instantiated objects
  world = new World();
  // Set a buffer from the border
  borderBuffer = 50;
}

void draw() {
  // Redraw the background every frame
  background(255);

  mouse = new PVector(mouseX, mouseY);
  // Call the runScene function to run all the instantiated objects
  world.run();
}

void keyPressed() {
  world.keyPressed();
}

float getRandomGaussian(float pMean, float pDeviation) {
  return randomGaussian() * pDeviation + pMean;
}

// Retrieve a random location (as a PVector) within the space of the canvas
PVector getRandomLocation() {
  return new PVector(round(random(0 + borderBuffer, width - borderBuffer)), round(random(0 + borderBuffer, height - borderBuffer)));
}


/* ISSUES
 Finish Creature
 * Finish visuals
 * Finish behaviour
 Finish social dimension
 * Adjust agent opinion with jealousy
 */