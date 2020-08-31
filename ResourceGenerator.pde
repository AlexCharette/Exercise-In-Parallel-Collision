class ResourceGenerator {

  // The list of all the Resource objects
  ArrayList<Resource> resources;
  // The value of the Resource objects based on their scarcity
  float scarcityValue;
  // The limit for the size of the list of Resource objects
  final int MAX_SIZE;
  // The name of the Resource objects
  String name;
  // The value of the Resource objects
  float resourceValue;
  // The weight of the Resource objects
  int resourceWeight;
  // A variable to confine the creation of Resource objects to keep them away from the edges of the canvas
  int container;
  // The style of the Resource objects in the list
  PImage resourceStyle;

  // The ResourceGenerator's constructor that for now accepts no parameters
  // All variables are initialized in here
  ResourceGenerator() {
    // Set the maximum size of the list
    MAX_SIZE = 10;
    // Set a placehold name for the Resource objects, since the parent Resource class is never instantiated
    name = "";
    // Set the value of the container variable
    container = 25;
    // Initialize the list of Resource objects
    resources = new ArrayList<Resource>();
  }

  // The method that runs all of the ResourceGenerator's other methods that aren't called in the ResourceManager
  void run() {
    // Call the method that removes Resources
    removeResource();
  }

  // The method that removes Resource objects from the list of Resource objects
  void removeResource() {
    // Iterate through the list of Resource objects backwards, as we will be removing them
    for (int i = resources.size() - 1; i >= 0; i--) {
      // If a Resource object is flagged as dead,
      if (resources.get(i).isDead() == true) {
        // Remove it from the list
        resources.remove(i);
      }
    }
  }

  // The method that adds a new Resource object to the list
  // Takes a PVector (the location of the new Resource object) as a parameter
  void addResource(PVector pLocation) {
    resources.add(createResource(pLocation));
  }

  // The method that creates a new Resource object
  // Takes a PVector (the location of the new Resource object) as a parameter
  Resource createResource(PVector pLocation) {
    return new Resource(pLocation);
  }

  // The method that adds a Resource object to the list
  void addResource() {
    // Add the Resource object created in the createResource method
    resources.add(createResource());
  }

  // Create a new Resource object
  Resource createResource() {
    return new Resource();
  }

  // Call the methods that display the Resource objects
  void displayResource() {
    for (Resource res : resources)
      res.display();
  }

  // Retrieve an ArrayList of Resource object locations
  ArrayList<PVector> getLocations() {
    // Store the locations in an ArrayList
    ArrayList<PVector> locations = new ArrayList<PVector>();
    // Until the iterator reaches the size of the list of Resource objects
    for (int i = 0; i < getSize(); i++) {
      // Add the locations of the Resource objects
      locations.add(resources.get(i).getLocation());
    }
    // Return the ArrayList of locations
    return locations;
  }

  // --------- ACCESSORS & MUTATORS --------- //

  // Set the value of the Resource objects
  void setResourceValue() {
    resourceValue = 0;
  }

  // Retrieve the value of the Resource objects
  float getResourceValue() {
    return resourceValue;
  }

  // Set the weight of the Resource objects
  void setResourceWeight(int pNewWeight) {
    for (Resource res : resources) 
      res.setWeight(pNewWeight);
  }

  // Retrieve the weight of the Resource objects
  int getResourceWeight() {
    return resourceWeight;
  }

  // Retrieve the name of the Resource objects
  String getName() {
    return name;
  }

  // Retrieve the size of the list of Resource objects
  int getSize() {
    return resources.size();
  }

  // Retrieve the size limit of the list of Resource objects
  int getMaxSize() {
    return MAX_SIZE;
  }

  // Retrieve the newest Resource object in the list of Resource objects
  Resource getNewestResource() {
    return resources.get(getSize() - 1);
  }

  // Retrieve the list of Resource objects
  ArrayList<Resource> getResources() {
    return resources;
  }

  // Set the styles of the Resource objects
  void setResourceStyle() {
    for (Resource res : resources)
      res.setStyle(resourceStyle);
  }
}