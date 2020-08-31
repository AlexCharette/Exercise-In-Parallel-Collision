/*
 * A subclass of the Resource class that represents the second most common Resource
 * Methods of the class (except for Accessors and Mutators):
 * Silver silver = new Silver();
 * Silver silver = new Silver(location);
 */
class Silver extends Resource {

  // The constructor takes no parameters
  // All properties are initialized here
  Silver() {
    super();
    // Set the color of the Silver
    fillColor = #1FBFB3;
    // Set the name of the Silver
    name = "Silver";
  }

  // The second constructor
  // Takes a PVector (the location) as a parameter
  Silver(PVector pLocation) {
    super(pLocation);
    // Set the color of the Silver
    fillColor = #1FBFB3;
    // Set the name of the Silver
    name = "Silver";
  }
}