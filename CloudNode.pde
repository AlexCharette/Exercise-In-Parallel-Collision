class CloudNode {

  // The location, acceleration and velocity vectors of the CloudNode
  PVector location, acceleration, velocity;
  // A buffer to keep the CloudNode from spawning too close to the borders
  int borderBuffer;
  // The color of the CloudNode
  color fillColor;
  // The opacity of the CloudNode
  int opacity;
  // The diameter of the CloudNode
  int diameter;
  // A smaller buffer for the stroke of the CloudNode
  int shapeBuffer;
  // The maximum number of Wisp objects in a CloudNode
  final int MAX_WISPS;
  // A list of Wisp objects
  ArrayList<Wisp> wisps;

  // The constructor takes a PVector (the location) as a parameter
  // All properties are instantiated here
  CloudNode(PVector location) {
    // Set the buffer 
    borderBuffer = 100;
    // Assign the given location to the location
    this.location = location;
    // Instantiate the velocity and acceleration vectors
    velocity = acceleration = new PVector(0, 0);
    // Set the maximum number of Wisp objects
    MAX_WISPS = 3;
    // Instantiate the list of Wisp objects
    wisps = new ArrayList<Wisp>();
  }

  // The method that calls the other methods
  void run() {
    // Call the method that fills the CloudNode
    fillNode();
    // Call the method that updats the CloudNode
    update();
  }

  // The method that allows the CloudNode to move
  void update() {
    // Change the velocity with acceleration
    velocity.add(acceleration);
    // Change the location with velocity
    location.add(velocity);
    // Prevent the acceleration from stacking 
    acceleration.mult(0);
  }

  // The method that draws the CloudNode
  void display() {
    // Set the diameter
    diameter = wisps.size() * 20;
    // Set the opacity
    opacity = wisps.size() * 15;
    // Set the value of the shape buffer
    shapeBuffer = diameter / 3;
    // Remove the stroke
    noStroke();
    // Allow the shape to be affected by movements in the Z axis
    pushMatrix();
    translate(0, 0, location.z);
    // Set the color of the inner ellipse
    fill(fillColor, opacity);
    // Draw the inner ellipse
    ellipse(location.x, location.y, diameter, diameter);
    // Set the color of the outer ellipse
    fill(fillColor, opacity / 2);
    // Draw the outer ellipse
    ellipse(location.x, location.y, diameter + shapeBuffer, diameter + shapeBuffer);
    popMatrix();
  }

  // The method that causes the CloudNode to rain
  void rain() {
    // For every Wisp object
    for (int i = getNumWisps() - 1; i >= 0; i--) {
      // Get a random value between 0 and 8
      float randomSelector = random(8);
      // Assign a Resource object type to the Wisp's source based on the random value received
      if (randomSelector >= 0 && randomSelector <= 1) {
        wisps.get(i).setSource(new Gold());
      } else if (randomSelector > 1 && randomSelector <= 4) {
        wisps.get(i).setSource(new Silver());
      } else if (randomSelector > 4 && randomSelector <= 8) {
        wisps.get(i).setSource(new Bronze());
      }
      // Set the current Wisp object to a drop
      wisps.get(i).setIsDrop(true);
      // Remove it from the CloudNode
      wisps.remove(wisps.get(i));
    }
  }

  // The method that fills the CloudNode with Wisp objects
  void fillNode() {
    // If the CloudNode isn't full and there are Wisp objects in the sky,
    if (isFull() == false && world.getSky().getWispsInSky().isEmpty() == false) {
      // Add every found Wisp object to the CloudNode
      for (Wisp wisp : world.getSky().getWispsInSky()) {
        addWisp(wisp);
      }
    }
  }

  // The method that adds a Wisp object to the CloudNode
  // Takes a Wisp object (the Wisp to be added) as a parameter
  void addWisp(Wisp pWisp) {
    // Add a Wisp object to the list
    wisps.add(pWisp);
    // Flag it as having a node
    pWisp.setHasNode(true);
    // Set the location of the wisp to a random one
    pWisp.setLocation(random(0 + borderBuffer, width - borderBuffer), 
      random(0 + borderBuffer, height - borderBuffer), world.getSky().getSkyLimit());
  }

  // The method that flags whether or not the CloudNode is full 
  boolean isFull() {
    // If the number of Wisp objects hasn't reached the maximum, return true
    if (wisps.size() >= MAX_WISPS) 
      return true;
    else
      return false;
  }

  // The method that prevents the CloudNode from leaving the canvas
  void checkEdges() {
    // Constrain the X and Y of the location to the edges of the canvas
    location.x = constrain(location.x, 0, width);
    location.y = constrain(location.y, 0, height);
    // If the CloudNode reaches an edge, turn it around
    if (location.x >= width || location.x <= 0) {
      velocity.x = velocity.x * -1;
    }
    if (location.y >= height || location.y <= 0) {
      velocity.y = velocity.y * -1;
    }
  }

  // --- ACCESSORS & MUTATORS --- //

  // Set the location of the CloudNode
  void setLocation(PVector pNewLocation) {
    location = pNewLocation.copy();
  }

  // Retrieve the location of the CloudNode
  PVector getLocation() {
    return location.copy();
  }

  // Set the color of the CloudNode
  void setColor(color pNewColor) {
    fillColor = pNewColor;
  }

  // Retrieve the color of the CloudNode
  color getColor() {
    return fillColor;
  }

  // Retrieve the diameter of the CloudNode
  int getDiameter() {
    return diameter;
  }

  // Retrieve the radius of the CloudNode
  int getRadius() {
    return diameter / 2;
  }

  // Retrieve the number of Wisp objects in the CloudNode
  int getNumWisps() {
    return wisps.size();
  }

  // Retrieve the list of Wisp objects from the CloudNode
  ArrayList<Wisp> getWisps() {
    return wisps;
  }
}