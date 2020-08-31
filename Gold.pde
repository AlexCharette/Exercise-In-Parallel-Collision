/*
 * A subclass of the Resource class that represents the rarest Resource.
 * Methods of the class (except for Accessors and Mutators):
 * Gold gold = new Gold();
 * Gold gold = new Gold(location);
 */
class Gold extends Resource {
  
    // The constructor takes no parameters
  // All properties are initialized here
  Gold() {
    super();
    // Set the color of the Gold
    fillColor = #F0CF16;
    // Set the name of the Gold
    name = "Gold";
  }
  
  // The second constructor
  // Takes a PVector (the location) as a parameter
  Gold(PVector pLocation) {
    super(pLocation);
    // Set the color of the Gold
    fillColor =  #F0CF16;
    // Set the name of the Gold
    name = "Gold";
  }
}