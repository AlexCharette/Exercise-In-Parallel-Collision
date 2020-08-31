//
class Portal {

  // The location of the Portal
  PVector location;
  // The maximum size of the Portal
  final int MAX_SIZE;
  // The size of the Portal
  int size;
  // The radius of the Portal
  float radius;
  // The fill and stroke colors of the Portal
  color fillColor, strokeColor;
  // The opacity of the Portal
  int opacity;
  // The lifespan of the Portal
  int lifespan;
  // The source of the Portal
  Resource source;

  // The constructor takes a Resource object (the source) as a parameter
  // All properties are initiliazed here
  Portal(Resource pResource) {
    // Set the location to location of the given Resource object
    location = pResource.getLocation().copy();
    // Set the maximum size
    MAX_SIZE = 50;
    // Set the size
    size = 5;
    // Set the radius
    radius = 0;
    // Set the fillColor
    fillColor = #F79328;
    // Set the opacity
    opacity = 70;
    // Set the lifespan
    lifespan = 20;
    // Assign the given Resource object as the source
    source = pResource;
  }

  // The method that runs the other methods
  void run() {
    // Decrease the lifespan
    lifespan--;
    // Call the method that updates the position
    update();
  }

  // The method that updates the position
  void update() {
    // The new radius of the Portal
    float newRadius;
    // Set the radius according to the lifespan
    newRadius = lifespan + (lifespan * 1.5) / 2;
    setRadius(newRadius);
  }

  // The method that draws the Portal
  void display() {
    // Remove the stroke
    noStroke();
    // Set the color
    fill(fillColor, opacity);
    // Draw a smaller ellipse
    ellipse(location.x, location.y, size * lifespan, size * lifespan);
    // Set a new opacity
    fill(fillColor, opacity / 2);
    // Draw a larger ellipse
    ellipse(location.x, location.y, (size * 2) * lifespan, (size * 2) * lifespan);
  }

  // The method that flags whether or not the Portal is dead
  boolean isDead() {
    // Return true if the lifespan is greater than zero
    if (lifespan <= 0) 
      return true;
    else
      return false;
  }

  // --------- ACCESSORS & MUTATORS --------- //

  // Set the radius of the Portal
  void setRadius(float pNewRadius) {
    radius = pNewRadius;
  }

  // Retrieve the radius of the Portal
  float getRadius() {
    return radius;
  }

  // Retrieve the location of the Portal
  PVector getLocation() {
    return location;
  }

  // Retrieve the source of the Portal
  Resource getSource() {
    return source;
  }
}