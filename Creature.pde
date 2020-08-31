class Creature {

  // The location, velocity, and acceleration of the Creature
  PVector location, velocity, acceleration;
  // The previous location of the Creature
  PVector previousLocation;
  // The target location of the Creature
  PVector targetLocation;
  // The list of CreatureNodes for the Creature
  ArrayList<CreatureNode> nodes;
  // A maximum for the nodes
  final int MAX_NODES;
  // An offset to place between the nodes
  PVector nodeOffset;
  // The image for the head of the Creature
  PImage creatureHead;
  // The fill and stroke colors of the Creature
  color fillColor, strokeColor;
  // The opacity of the Creature
  int opacity;
  // The maximum speed of the Creature
  int maxSpeed;
  // The maximum force of the Creature
  float maxForce;
  // The angle of the Creature
  float angle;
  // The velocity for the angle
  float angleVelocity;
  // The amplitude for the oscillation
  float amplitude;
  // The size for drawing the Creature
  int size;
  // Flag whether or not the Creature has escaped
  boolean hasEscaped;

  // The constructor takes no parameters
  // All properties are instantiated here
  Creature() {
    // Set the location, velocity, and acceleration
    location = new PVector(width / 2, height / 2, -10);
    velocity = acceleration = new PVector(0.2, 0.2, 0);
    // Instantiate the list of CreatureNodes
    nodes = new ArrayList<CreatureNode>();
    // Set the offset for the nodes
    nodeOffset = new PVector(0, 50);
    // Set the limit for the nodes
    MAX_NODES = 15;
    // Set the image for the head of the Creature
    creatureHead = loadImage("Creature Head.png");
    // Set the opacity
    opacity = 70;
    // Set the maximum speed
    maxSpeed = 12;
    // Set the maximum force
    maxForce = 3;
    // Set the starting angle to zero
    angle = 0;
    // Set the velocity of the angle
    angleVelocity = 0.2;
    // Set the amplitude
    amplitude = 50;
    // Set the size
    size = 10;
    // Flag that the Creature has not escaped
    hasEscaped = false;
    // Call the method that fills the list of CreatureNodes
    fillNodes();
  }

  // The method that runs the other methods
  void run() {
    // If the player is in the low view or the Creature has escaped,
    if (world.getView() == world.getLowView() || hasEscaped)
      // Follow the mouse
      followPlayer();
    // If not,
    else
      // Seek portals
      moveToPortal();
    if (hasEscaped) //-----------------------------------------------------------------
      fly();
    // Call the method that updates the position of the Creature
    update();
    // Call the method that runs the CreatureNodes' methods
    runNodes();
  }

  // The method that updates the position of the Creature
  void update() { 
    // Seek the Creature's target location
    seek(targetLocation);
    // Store the previous location
    previousLocation = location.copy();
    // Change the velocity with the acceleration
    velocity.add(acceleration);
    // Limit the velocity with the maximum speed
    velocity.limit(maxSpeed);
    // Change the location with the velocity
    location.add(velocity);
    // Prevent the acceleration from stacking
    acceleration.mult(0);
    // An index to serve as an iterator
    int index = 0;
    // For every CreatureNode in the list,
    for (CreatureNode node : nodes) {
      // If it's the first node,
      if (index == 0) {
        // Set the previous location of the node to its current location
        node.setPreviousLocation(node.getLocation());
        // Set the location of the node to the Creature's current location
        node.setLocation(previousLocation);
        // Otherwise,
      } else if (index > 0) {
        // Store the previous node's previous location
        PVector tempLocation = nodes.get(index - 1).getPreviousLocation().copy();
        // Set the previous location of the current node to its current location
        node.setPreviousLocation(node.getLocation());
        // Set its current location to the previous node's previous location
        node.setLocation(tempLocation);
      }
      // Increment the iterator
      index++;
    }
  }

  // The method that causes the Creature to fly
  void fly() {
    float zIncrease = 10;
    int target = 300;
    setVelocity(velocity.x, velocity.y, zIncrease);
    if (location.z > target)
      velocity.z = velocity.z * -1;
  }

  // The method that fills the list of CreatureNodes
  void fillNodes() {  
    // The diameter of the nodes
    int nodeDiameter;
    // Until the limit has been reached,
    for (int i = MAX_NODES; i > 0; i--) {
      // Set the diameter
      nodeDiameter = size + MAX_NODES * 2;
      // Set a new location 
      PVector nodeLocation = PVector.sub(location, nodeOffset);
      // Create a new CreatureNode and add both variables as parameters
      nodes.add(createNode(nodeLocation, nodeDiameter));
    }
  }

  // The method that calls the run method of the CreatureNodes
  void runNodes() {
    for (CreatureNode node : nodes)
      node.run();
  }

  // The method that displays everything
  void display() {
    // Call the method that draws the CreatureNodes
    drawNodes();
    // Call the method that draws the head
    drawHead();
  }

  // The method that draws the head
  void drawHead() {
    // Get a rotation based on the direction
    float theta = getDirection().heading() + radians(90);
    // Allow the head to be rotated and drawn in the Z axis
    pushMatrix();
    translate(location.x, location.y, location.z);
    // Rotate the head
    rotate(theta);
    // Draw an image from the center
    imageMode(CENTER);
    // Draw an image using the one provided
    image(creatureHead, 0, 0); 
    // Set a size for it and resize it
    size = 120;
    creatureHead.resize(size, size);
    popMatrix();
  }

  // The method that draws the nodes
  void drawNodes() {
    // For every node,
    for (CreatureNode node : nodes) {
      // Get a new location that is subjected to oscillation
      float newNodeZ = location.z + amplitude * sin(angle);
      // Set the location with the new Z position
      node.setLocation(node.getLocation().x, node.getLocation().y, newNodeZ);
      // Draw the node
      node.display();
      // Increase the angle
      angle += angleVelocity;
    }
  }

  // The method that creates a new CreatureNode
  // Takes a PVector (the location) and an integer (the diameter) as parameters
  CreatureNode createNode(PVector pLocation, int pDiameter) {
    return new CreatureNode(pLocation, pDiameter);
  }

  // Retrieve the direction of the Creature
  PVector getDirection() {
    // Subtract the locations
    PVector direction = PVector.sub(targetLocation, location);
    // Invert the result
    direction.mult(-1);
    return direction;
  }

  // The method that applies a force to the Creature
  // Takes a PVector (the force) as a parameter
  void applyForce(PVector pNewForce) {
    // Add the force to the acceleration
    acceleration.add(pNewForce);
  }

  // This block of code by Daniel Shiffman, http://natureofcode.com
  // The method that causes the Creature to seek something
  // Takes a PVector (the target location) as a parameter
  void seek(PVector target) {
    // The desired location
    PVector desired = PVector.sub(target, location);
    // The point at which the Creature should slow down
    float slowRadius = desired.mag();
    // Get the direction of the Creature
    desired.normalize();
    // If the Creature is closer than 100 pixels,
    if (slowRadius < 100) {
      // Set and use a multiplier to slow the Creature
      float multiplier = map(slowRadius, 0, 100, 0, maxSpeed);
      desired.mult(multiplier);
      // Otherwise,
    } else {
      // Proceed at maximum speed.
      desired.mult(maxSpeed);
    }
    // Get the force to be applied
    PVector steer = PVector.sub(desired, velocity);
    // Limit it
    steer.limit(maxForce);
    // Apply it
    applyForce(steer);
  }

  // END OF SHIFFMAN CODE // 

  // The method that prevents the Creature from leaving the canvas
  void checkEdges() {
    // Constrain the X and Y of the location to the edges of the canvas
    location.x = constrain(location.x, 0, width);
    location.y = constrain(location.y, 0, height);
    // If the Creature reaches an edge, turn it around
    if (location.x >= width || location.x <= 0) {
      velocity.x = velocity.x * -1;
    }
    if (location.y >= height || location.y <= 0) {
      velocity.y = velocity.y * -1;
    }
  }

  // The method that causes the creature to follow the mouse
  void followPlayer() {
    // Set the target location to the mouse position
    setTargetLocation(mouse);
  }

  // The method that causes the creature to move to a portal
  void moveToPortal() {
    // If there are Portal objects,
    if (world.underworld.getPortalManager().getPortals().isEmpty() == false) {
      // Find one that isn't dead
      for (Portal portal : world.underworld.getPortalManager().getPortals()) {
        if (portal.isDead() == false) {
          // Set it as the target
          setTargetLocation(portal.getLocation());
        }
      }
      // If there are no Portal objects,
    } else {
      // Let the Creature wander
      wander();
    }
  }

  // The method that allows the Creature to wander
  void wander() {
    // Set the wander target to a random location
    PVector wanderTarget = getRandomLocation().copy();
    // Store the distance between the creature and the target
    PVector distance = PVector.sub(wanderTarget, location);
    // The limit for proximity
    int limit = 5;
    // If the distance is less than the limit
    if (distance.mag() >= limit) {
      // Get a new random target
      wanderTarget = getRandomLocation().copy();
    }
    // Set the target location as the wander target
    setTargetLocation(wanderTarget);
  }

  // The method that flags whether or not the Creature is within a CloudNode object
  boolean isInsideNode(CloudNode pNode) {
    // Store the answer
    boolean isInside = false;
    // Return true if the Creature's location is inside the CloudNode's radius
    if (location.x <= pNode.getLocation().x + (pNode.getRadius()) && location.x >= pNode.getLocation().x - (pNode.getRadius())
      && location.y <= pNode.getLocation().y + (pNode.getRadius()) && location.y >= pNode.getLocation().y - (pNode.getRadius()))
      isInside = true;
    else
      isInside = false;
    return isInside;
  }

  // The method that flags whether or not the Creature is within a Portal object
  boolean isInsidePortal(Portal pPortal) {
    // Store the answer
    boolean isInside = false;
    // Return true if the Creature's location is inside the Portal's radius
    if (location.x <= pPortal.getLocation().x + (pPortal.getRadius()) && location.x >= pPortal.getLocation().x - (pPortal.getRadius())
      && location.y <= pPortal.getLocation().y + (pPortal.getRadius()) && location.y >= pPortal.getLocation().y - (pPortal.getRadius()))
      isInside = true;
    else
      isInside = false;
    return isInside;
  }

  // --------- ACCESSORS & MUTATORS --------- //

  // Set the location of the Creature
  void setLocation(PVector pNewLocation) {
    location = pNewLocation.copy();
  }

  // Set the velocity of the Creature using floats
  void setVelocity(float pNewX, float pNewY, float pNewZ) {
    velocity.set(pNewX, pNewY, pNewZ);
  }

  // Set the Creature's target location
  void setTargetLocation(PVector pTarget) {
    targetLocation = pTarget;
  }

  // Retrieve the Creature's target location
  PVector getTargetLocation() {
    return targetLocation;
  }

  // Retrieve the Creature's list of CreatureNodes
  ArrayList<CreatureNode> getNodes() {
    return nodes;
  }

  // Retrieve the locations of the Creature's CreatureNodes
  ArrayList<PVector> getNodeLocations() {
    ArrayList<PVector> tempLocations = new ArrayList<PVector>();
    for (CreatureNode node : nodes)
      tempLocations.add(node.getLocation().copy());
    return tempLocations;
  }

  // Set the hasEscaped state of the Creature
  void setHasEscaped(boolean pNewState) {
    hasEscaped = pNewState;
  }

  // Retrieve the hasEscaped state of the Creature
  boolean getHasEscaped() {
    return hasEscaped;
  }
}