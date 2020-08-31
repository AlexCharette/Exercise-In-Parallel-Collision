class Resource {

  // The location of the Resource
  PVector location;
  // The name of the Resource
  String name;
  // The style of the Resource
  PImage style;
  // The value of the Resource
  float value;
  // A buffer to keep resources from being close to the edges of the canvas
  int borderBuffer;
  // An offset for the position of the Resource
  int offset;
  // Flag whether or not the Resource has been found
  boolean resourceFound;
  // The color of the Resource
  color fillColor;
  // The opacity of the Resource
  int opacity;
  // The weight of the Resource
  int weight;

  // The constructor takes no parameters
  // All properties are instantiated here
  Resource() {
    // Set the location to a random point
    location = new PVector(random(0 + borderBuffer, width - borderBuffer), 
      random(0 + borderBuffer, height - borderBuffer), 0);
    // Set a placeholder name
    name = " ";
    // Set a value of zero
    value = 0;
    // Set the buffer
    borderBuffer = 50;
    // Set the offset
    offset = 15;
    // Flag the Resource as not being found
    resourceFound = false;
    // Set the opacity
    opacity = 255;
  }

  // The second constructor 
  // Takes a PVector (the location) as a parameter
  Resource(PVector pLocation) {
    // Assign the given location to the Resource's location
    this.location = pLocation.copy();
    // Set a placeholder name
    name = " ";
    // Set a value of zero
    value = 0;
    // Set the buffer
    borderBuffer = 50;
    // Set the offset
    offset = 15;
    // Flag the Resource as not being found
    resourceFound = false;
    // Set the opacity
    opacity = 255;
  }

  // The method that displays the Resource
  void display() {
    // Remove the stroke
    noStroke();
    // Set the color
    fill(fillColor, opacity);
    // Allow the shape to be drawn according to its Z location
    pushMatrix();
    translate(0, 0, location.z);
    // Draw a triangle
    //triangle(location.x, location.y, location.x + (offset / 2), location.y + offset, 
    //  location.x - (offset / 2), location.y + offset);
    imageMode(CENTER);
    image(style, location.x, location.y);
    style.resize(offset * 2, offset * 2);
    popMatrix();
  }

  // The method that flags whether or not the Resource is dead
  boolean isDead() {
    // Return true if the Resource is found
    if (resourceFound)
      return true;
    else 
    return false;
  }

  // --------- ACCESSORS & MUTATORS --------- //

  // Set the Resource's location
  void setLocation(PVector pNewLocation) {
    location = pNewLocation.copy();
  }

  // Retrieve the Resource's location
  PVector getLocation() {
    return location;
  }

  // Retrieve the name of the Resource
  String getName() {
    return name;
  }

  // Set the value of the Resource
  void setValue(float pNewValue) {
    value = pNewValue;
  }

  // Retrieve the value of the Resource
  float getValue() {
    return value;
  }

  // Set the resourceFound state of the Resource
  void setResourceFound(boolean pNewState) {
    resourceFound = pNewState;
  }

  // Retrieve the resourceFound state of the Resource
  boolean getResourceFound() {
    return resourceFound;
  }

  // Retrieve the color of the Resource
  color getColor() {
    return fillColor;
  }

  // Set the opacity of the Resource
  void setOpacity(int pNewOpacity) {
    opacity = pNewOpacity;
  }

  // Retrieve the opacity of the Resource
  int getOpacity() {
    return opacity;
  }

  // Set the weight of the Resource
  void setWeight(int pNewWeight) {
    weight = pNewWeight;
  }

  // Retrieve the weight of the Resource
  int getWeight() {
    return weight;
  }

  // Set the style of the Resource
  void setStyle(PImage pNewStyle) {
    style = pNewStyle;
  }

  // Retrieve the style of the Resource
  PImage getStyle() {
    return style;
  }
}