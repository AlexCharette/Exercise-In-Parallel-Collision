class Wisp {

  // The location and velocity of the wisp
  PVector location, velocity;
  // The color of the wisp
  color fillColor;
  // The opacity of the wisp
  int opacity;
  // The opacity for when the wisp is visible
  int visibleOpacity;
  // The diameter of the wisp
  int diameter;
  // The thickness of the stroke
  int strokeWeight;
  // The wisp's Resource object from which it is born
  Resource source;
  // Flag whether or not the wisp has spawned
  boolean isSpawned;
  // Flag whether or not the wisp is in a node
  boolean hasNode;
  // Flag whether or not the wisp is a drop
  boolean isDrop;

  // The Wisp constructor accepts only a Resource object as a parameter
  // All properties are instantiated in here
  Wisp(Resource pResource) {
    // Attribute the location of the Resource to the wisp
    location = new PVector(pResource.getLocation().x, pResource.getLocation().y, 0);
    // Initialize the velocity to zero
    velocity = new PVector(0, 0, 0);
    // Set the initial opacity to zero
    opacity = 0;
    // Set the required visible opacity
    visibleOpacity = 50;
    // Set the diameter
    diameter = 20;
    // Set the thickness of the stroke
    strokeWeight = diameter / 4;
    // Assign the parameter Resource as the source
    source = pResource;
    // Flag all booleans as false
    isSpawned = hasNode = isDrop = false;
  }

  // The method that runs the wisp's other methods
  void run() {
    // Call the method to spawn it
    spawn();
    // Call the method to make it fall
    fall();
    // Call the method to update it
    update();
  }

  // The method that changes the location based on the velocity
  void update() {
    location.add(velocity);
  }

  // The method that displays the wisp
  void display() {
    // If it hasn't reached the sky or doesn't have a node,
    if (reachedSky() == false || hasNode == false) {
      // Set the fillColor to the source's color
      fillColor = source.getColor();
      // Set the thickness of the stroke
      strokeWeight(strokeWeight);
      // Set the color of the stroke
      stroke(fillColor, opacity / 2);
      // Set the color of the wisp
      fill(fillColor, opacity);
      // Allow the wisp's shape to move in the Z axis
      pushMatrix();
      translate(0, 0, location.z);
      // If it isn't a drop,
      if (!isDrop)
        // Draw an ellipse with full diameter
        ellipse(location.x, location.y, diameter, diameter);
      // Otherwise,
      else
        // Draw a smaller ellipse
        ellipse(location.x, location.y, diameter / 3, diameter / 3);
      popMatrix();
    }
  }

  // The method that spawns the wisp
  void spawn() {
    // If the wisp's source is flagged as dead,
    if (source.isDead()) {
      // Set the opacity to be visible
      setOpacity(visibleOpacity);
      // Set the velocity to a random value, increasing in the Z
      setVelocity(getRandomGaussian(0, 0.2), getRandomGaussian(0, 0.2), 2);
      // Flag it as being spawned
      isSpawned = true;
    }
  }

  // The method that causes the wisp to fall
  void fall() {
    // If it is a drop and hasn't reached the ground,
    if (isDrop && reachedGround() == false) {
      // Set the opacity to be visible
      setOpacity(visibleOpacity);
      // Set the velocity to a random value, decreasing in the Z
      setVelocity(random(-0.3, 0.3), random(-0.3, 0.3), -3);
    }
  }

  // The method that flags true if the wisp has reached the sky
  boolean reachedSky() {
    // If the location's Z axis is greater or equal to the target,
    if (location.z >= world.getSky().getSkyLimit()) {
      // Set the opacity to be invisible
      setOpacity(0);
      // Set the velocity to make it stop moving
      setVelocity(velocity.x, velocity.y, 0);
      return true;
    } else {
      return false;
    }
  }

  // The method that flags true if the wisp has reached the ground
  boolean reachedGround() {
    // If the location's Z axis is lesser or equal to the initial Z point and is a drop
    if (location.z <= 0 && isDrop) {
      // Set the location's Z point to zero
      location.z = 0;
      // Set the opacity to zero
      setOpacity(0);
      // Set the velocity to zero
      setVelocity(0, 0, 0);
      // Flag that it is not spawned, is not a drop and doesn't have a node
      isDrop = isSpawned = hasNode = false;
      return true;
    } else {
      return false;
    }
  }

  // --------- ACCESSORS & MUTATORS --------- //

  // Set the Wisp's location
  void setLocation(PVector pNewLocation) {
    location = pNewLocation.copy();
  }

  // Set the Wisp's location using floats
  void setLocation(float pNewX, float pNewY, float pNewZ) {
    location.set(pNewX, pNewY, pNewZ);
  }

  // Retrieve the Wisp's location
  PVector getLocation() {
    return location.copy();
  }

  // Set the Wisp's velocity
  void setVelocity(PVector pNewVelocity) {
    velocity = pNewVelocity.copy();
  }

  // Set the Wisp's velocity using floats
  void setVelocity(float pNewX, float pNewY, float pNewZ) {
    velocity.set(pNewX, pNewY, pNewZ);
  }

  // Set the Wisp's color
  void setFillColor(color pNewColor) {
    fillColor = pNewColor;
  }

  // Set the Wisp's opacity
  void setOpacity(int pNewOpacity) {
    opacity = pNewOpacity;
  }

  // Retrieve the Wisp's opacity
  int getOpacity() {
    return opacity;
  }

  // Set the isSpawned state of the Wisp
  void setIsSpawned(boolean pNewState) {
    isSpawned = pNewState;
  }

  // Retrieve the isSpawned state of the Wisp
  boolean getIsSpawned() {
    return isSpawned;
  }

  // Set the hasNode state of the Wisp
  void setHasNode(boolean pNewState) {
    hasNode = pNewState;
  }

  // Retrieve the hasNode state of the Wisp
  boolean getHasNode() {
    return hasNode;
  }

  // Set the isDrop state of the Wisp  
  void setIsDrop(boolean pNewState) {
    isDrop = pNewState;
  }

  // Retrieve the isDrop state of the Wisp
  boolean getIsDrop() {
    return isDrop;
  }

  // Set the source of the Wisp
  void setSource(Resource pNewSource) {
    source = pNewSource;
  }

  // Retrieve the source of the Wisp
  Resource getSource() {
    return source;
  }
}