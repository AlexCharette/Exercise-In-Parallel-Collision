//
class WispGenerator {

  // The list of Wisp objects
  ArrayList<Wisp> wisps;
  // Flag whether or not the Wisp objects have been created
  boolean noWisps;

  // The constructor takes no parameters
  // All properties are initialized here
  WispGenerator() {
    // Instantiate the list of Wisp objects
    wisps = new ArrayList<Wisp>();
    // Flag that there are no Wisp objects
    noWisps = true;
  }

  // The method that calls the other methods
  void run() {
    // If there are no Wisp objects
    if (noWisps) 
      // Call the method that fills the list
      fillGenerator();
    // Call every Wisp object's run method
    for (Wisp wisp : wisps)
      wisp.run();
    // Flag that there are now Wisp objects
    noWisps = false;
  }

  // The method that takes care of visuals
  void display() {
    // Call the method that displays all of the Wisp objects
    displayWisps();
  }

  // The method that fills the list of Wisp objects
  void fillGenerator() {
    // Copy the list of all the Resource objects
    ArrayList<Resource> resources = world.getResources();
    // Add a Wisp for every Resource object
    for (Resource res : resources)
      wisps.add(createWisp(res));
  }

  // The method that creates a new Wisp object
  // Takes a Resource object (the Wisp's source) as a parameter
  Wisp createWisp(Resource pResource) {
    return new Wisp(pResource);
  }

  // The method that calls all of the Wisp objects' display methods
  void displayWisps() {
    for (Wisp wisp : wisps) 
      wisp.display();
  }

  // --------- ACCESSORS & MUTATORS --------- //

  // Retrieve the list of Wisp objects
  ArrayList<Wisp> getWisps() {
    return wisps;
  }
}