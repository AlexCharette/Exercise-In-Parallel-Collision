/*
 * A subclass of the Resource class that represents the most common Resource.
 * Methods of the class (except for Accessors and Mutators):
 * Bronze bronze = new Bronze();
 * Bronze bronze = new Bronze(location);
 */
class Bronze extends Resource {
  
  // The constructor takes no parameters
  // All properties are instantiated here
  Bronze() {
    super();
    // Set the color of the Bronze
    fillColor = #F7870F;
    // Set the name of the Bronze
    name = "Bronze";
  }
  
  // The second constructor
  // Takes a PVector (the location) as a parameter
  Bronze(PVector pLocation) {
    super(pLocation);
    // Set the color of the Bronze
    fillColor =  #F7870F;
    // Set the name of the Bronze
    name = "Bronze";
  }
}