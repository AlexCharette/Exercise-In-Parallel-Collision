//
class CloudManager {
  // The list of Cloud objects
  ArrayList<Cloud> clouds;
  // Flag whether or not there are Cloud objects
  boolean noClouds;

  // The constructor takes no parameters
  // All properties are instantiated here
  CloudManager() {
    // Instantiate the list of Cloud objects
    clouds = new ArrayList<Cloud>();
    // Flag that there are no Cloud objects
    noClouds = true;
  }

  // The method that runs the other methods
  void run() {
    // Call the method that creates the first Cloud object
    createFirstCloud();
    // Call the method that manages the Cloud objects
    manageClouds();
    // If the Cloud is empty, 
    if (clouds.isEmpty())
      // Flag that there are no Cloud objects
      noClouds = true;
  }

  // The method that displays everything in the manager
  void display() {
    // Call the method that displays Cloud objects
    displayClouds();
  }

  // The method that manages the Cloud objects
  void manageClouds() {
    // Call the method that fills the list of Cloud objects with Cloud objects
    fillClouds();
    // Call the run method of every Cloud object
    for (Cloud cloud : clouds)
      cloud.run();
    // Iterate through all the Cloud objects and their CloudNode objects
    for (int i = clouds.size() - 1; i >= 0; i--) {
      for (int j = clouds.get(i).getNumNodes() - 1; j >= 0; j--) {
        // If the Creature is inside a CloudNode and has escaped,
        if (world.getUnderworld().getCreature().isInsideNode(clouds.get(i).getNodes().get(j)) 
          && world.getUnderworld().getCreature().hasEscaped) {
          // Call the rain method of that CloudNode and remove it
          clouds.get(i).getNodes().get(j).rain();
          clouds.get(i).getNodes().remove(j);
        }
      }
    }
  }

  // The method that calls the display methods of the Cloud objects
  void displayClouds() {
    for (Cloud cloud : clouds)
      cloud.display();
  }

  // The method that creates the first Cloud object
  void createFirstCloud() {
    // If there are no Cloud objects,
    if (noClouds)
      // Add one to the list
      clouds.add(createCloud());
    // Flag that there are Cloud objects
    noClouds = false;
  }

  // The method that fills the list of Cloud objects
  void fillClouds() {
    // If the newest Cloud object is full, 
    if (clouds.get(getNumClouds() - 1).isFull()) 
      // Create a new one
      clouds.add(createCloud());
  }

  // The method that creates a new Cloud object
  Cloud createCloud() {
    return new Cloud();
  }

  // --------- ACCESSORS & MUTATORS --------- //

  // Retrieve the number of Cloud objects
  int getNumClouds() {
    return clouds.size();
  }

  // Retrieve the list of Cloud objects
  ArrayList<Cloud> getClouds() {
    return clouds;
  }
}