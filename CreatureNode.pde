class CreatureNode {

  // The location, acceleration, and velocity of the CreatureNode
  PVector location, acceleration, velocity;
  // The previous location of the CreatureNode
  PVector previousLocation;
  // The fill and stroke color of the CreatureNode
  color fillColor, strokeColor;
  // The diameter of the CreatureNode
  int diameter;

  // The constructor takes a PVector (the location) and an integer (the diameter) as parameters
  CreatureNode(PVector location, int diameter) {
    // Set the location of the CreatureNode to the given one
    this.location = location.copy();
    // Instantiate the velocity and acceleration to zero
    velocity = acceleration = new PVector(0, 0, 0);
    // Instantiate the previous location to zero
    previousLocation = new PVector(0, 0);
    // Set the fill and stroke colors
    fillColor = #445055;
    strokeColor = #E48B21;
    // Set the diameter of the CreatureNode to the given one
    this.diameter = diameter;
  }

  // The method that runs the other methods
  void run() {
    // Call the method to update the position
    update();
  }

  // The method that updates the CreatureNode's position
  void update() {
    // Change the velocity with the acceleration
    velocity.add(acceleration);
    // Change the location with the velocity
    location.add(velocity);
    // Prevent the acceleration from stacking
    acceleration.mult(0);
  }

  // The method that draws the CreatureNode
  void display() {
    // The value that will serve to rotate the CreatureNode
    float theta = getDirection().heading() + radians(90);
    // An offset to change the position of the CreatureNode
    float offset = 60;
    // Use the colors
    stroke(strokeColor);
    fill(fillColor);
    // Allow the CreatureNode to be drawn relative to its Z location
    pushMatrix();
    translate(location.x, location.y, location.z);
    // Rotate the CreatureNode so that it follows the target
    rotate(theta);
    // Drawn an ellipse
    ellipse(0, 0 - offset, diameter, diameter);
    popMatrix();
  }

  // The method that applies a force to the acceleration
  // Takes a PVector (the force) as a parameter
  void applyForce(PVector pNewForce) {
    // Change the acceleration with the force
    acceleration.add(pNewForce);
  }

  // The method that retrieves the direction that the CreatureNode is moving in
  PVector getDirection() {
    // Subtract the location from the mouse position
    PVector direction = PVector.sub(mouse, location);
    // Invert the direction
    direction.mult(-1);
    return direction;
  }

  // --------- ACCESSORS & MUTATORS --------- //

  // Set the location of the CreatureNode using floats
  void setLocation(float pNewX, float pNewY, float pNewZ) {
    location.set(pNewX, pNewY, pNewZ);
  }

  // Set the location of the CreatureNode
  void setLocation(PVector pNewLocation) {
    location = pNewLocation.copy();
  }

  // Retrieve the location of the CreatureNode
  PVector getLocation() {
    return location;
  }

  // Set the previous location of the CreatureNode
  void setPreviousLocation(PVector pNewLocation) {
    previousLocation = pNewLocation.copy();
  }

  // Retrieve the previous location of the CreatureNode
  PVector getPreviousLocation() {
    return previousLocation;
  }

  // Set the fill color of the CreatureNode
  void setFillColor(color pNewColor) {
    fillColor = pNewColor;
  }

  // Set the stroke color of the CreatureNode
  void setStrokeColor(color pNewColor) {
    strokeColor = pNewColor;
  }

  // Set the diameter of the CreatureNode
  void setDiameter(int pNewDiameter) {
    diameter = pNewDiameter;
  }

  // Retrieve the diameter of the CreatureNode
  int getDiameter() {
    return diameter;
  }

  // Retrieve the radius of the CreatureNode
  int getRadius() {
    return diameter / 2;
  }
}