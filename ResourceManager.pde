/*
 * This class represents an object that moves in 2D space as a result of applying forces.
 * Methods of the class (except for Accessors and Mutators):
 * ResourceManager resourceManager = new ResourceManager(widht/2, height/2);
 * resourceManager.run();
 * resourceManager.fillManager();
 * resourceManager.fillGenerators();
 * resourceManager.runGenerators();
 * resourceManager.addResources();
 * resourceManager.displayResources();
 * resourceManager.setResourceValues();
 * resourceManager.runGenerators();
 * resourceManager.printResourceInformation();
 * resourceManager.printResourceValues();
 * resourceManager.printResourceQuantities();
 * resourceManager.printResourceLocations();
 */
class ResourceManager implements Runnable {

  // The list of all the ResourceGenerator objects
  ArrayList<ResourceGenerator> resourceGens;
  //The limit for the size of the list of ResourceGenerator objects
  final int MANAGER_SIZE;
  // The range of possible random numbers to be selected later
  int randomSeed;
  // The index of the GoldGenerator object in the list of ResourceGenerator objects
  int goldIndex;
  // The index of the SilverGenerator object in the list of ResourceGenerator objects
  int silverIndex;
  // The index of the BronzeGenerator object in the list of ResourceGenerator objects
  int bronzeIndex;

  // The ResourceManager's constructor that for now accepts no parameters
  // All variables are initialized in here
  ResourceManager() {
    // Initialize the list of ResourceGenerator objects
    resourceGens = new ArrayList<ResourceGenerator>();
    // set the size for the list
    MANAGER_SIZE = 3;
    // set the range of random numbers
    randomSeed = 8;
    // set the index of the GoldGenerator
    goldIndex = 0;
    // set the index of the SilverGenerator
    silverIndex = 1;
    // set the index of the BronzeGenerator
    bronzeIndex = 2;

    // Call the method that fills the list of ResourceGenerator objects
    fillManager();
    //Call the method that fills the Lists of Resource objects
    fillGenerators();
  }

  // The method that runs all of the ResourceManager's other methods
  void run() {
    // Call the methods that set the weights and values of the Resource objects
    setResourceValues();
    setResourceWeights();
    // Call the methods that run and update the ResourceGenerator objects
    runGenerators();
    updateGenerators();
  }

  // The method that displays the Resource objects
  void display() {
    // Call the method that sets the styles of the Resource objects
    setResourceStyles();
    // Call the method that displays all of the Resource objects
    displayResources();
    // If the world view is set to high,
    if (world.getView() == world.getHighView())
      // Call the method that zooms out
      zoomOut();
    // Otherwise,
    else
      // Call the method that zooms in
      zoomIn();
  }


  // The method that fills the list of ResourceGenerator objects
  void fillManager() {
    // Add a new GoldGenerator object
    resourceGens.add(new GoldGenerator());
    // Add a new SilverGenerator object
    resourceGens.add(new SilverGenerator());
    // Add a new BronzeGenerator object
    resourceGens.add(new BronzeGenerator());
  }

  // The method that fills the ResourceGenerator objects's lists of Resource Objects
  // The ResourceGenerator objects's lists are filled in a way that the less valuable resources will be more common
  void fillGenerators() {
    // While the size of the GoldGenerator object hasn't reached its maximum size
    while (resourceGens.get(goldIndex).getSize() < resourceGens.get(goldIndex).getMaxSize()) {
      // Store a new random float in this variable, taken from the randomSeed
      float randomSelector = random(randomSeed);
      // If that value is in between 0 and 1
      if (randomSelector >= 0 && randomSelector <= 1) {
        // Call the function that adds Resource objects to the ResourceGenerator objects's lists
        // Use the goldIndex variable to indicate that it should be added to the GoldGenerator object
        addResources(goldIndex);
        // Otherwise, if the random value is in between 1 and 4,
      } else if (randomSelector > 1 && randomSelector <= 4) {
        // Call the function that adds Resource objects to the ResourceGenerator objects's lists
        // Use the silverIndex variable to indicate that it should be added to the SilverGenerator object
        addResources(silverIndex);
        // Otherwise, if the random value is in between 4 and 8,
      } else if (randomSelector > 4 && randomSelector <= 8) {
        // Call the function that adds Resource objects to the ResourceGenerator objects's lists
        // Use the bronzeIndex variable to indicate that it should be added to the BronzeGenerator object
        addResources(bronzeIndex);
      }
    }
  }

  // The method that updates the ResourceGenerator objects
  void updateGenerators() {
    // For every Wisp object that is on the ground,
    for (Wisp wisp : world.getSky().getWispsOnGround()) {
      // Check its source type and add a Resource of that type to the appropriate ResourceGenerator
      // Then, attach that Resource to the newly added Resource of the same type
      if (wisp.getSource() instanceof Gold) {       
        addResources(goldIndex, wisp.getLocation());
        wisp.setSource(resourceGens.get(goldIndex).getNewestResource());
      } else if (wisp.getSource() instanceof Silver) {
        addResources(silverIndex, wisp.getLocation());
        wisp.setSource(resourceGens.get(silverIndex).getNewestResource());
      } else if (wisp.getSource() instanceof Bronze) {
        addResources(bronzeIndex, wisp.getLocation());
        wisp.setSource(resourceGens.get(bronzeIndex).getNewestResource());
      }
      // Flag the Wisp object as being not spawned
      wisp.setIsSpawned(false);
    }
  }

  // The method that runs all the ResourceGenerator objects's run methods
  void runGenerators() {
    // For each ResourceGenerator object in the list of ResourceGenerator objects
    for (ResourceGenerator gens : resourceGens)
      // Call its run method
      gens.run();
  }

  // The method that adds a Resource object to the indicated ResourceGenerator object's list
  // Takes an integer (the index of the ResourceGenerator object) and 
  //a PVector (the location to be assigned to the Resource object) as parameters
  void addResources(int pIndex, PVector pLocation) {
    // Call the addResource method of the indicated ResourceGenerator object and pass the location
    resourceGens.get(pIndex).addResource(pLocation);
  }

  // The method that adds a Resource object to the indicated ResourceGenerator object's list
  // Takes an integer (the index of the ResourceGenerator object) as a parameter
  void addResources(int pIndex) {
    // Call the addResource method of the indicated ResourceGenerator object
    resourceGens.get(pIndex).addResource();
  }

  // The method that calls the display methods for all of the Resource objects in the ResourceGenerator objects's lists
  void displayResources() {
    // Call the display functions for the indicated ResourceGenerator object using the appropriate index variable
    resourceGens.get(goldIndex).displayResource();
    resourceGens.get(silverIndex).displayResource();
    resourceGens.get(bronzeIndex).displayResource();
  }

  // The method that compensates for a zoomed in view of the world
  void zoomIn() {
    // A new location for the Resource objects
    PVector newLocation;
    // A new opacity for the Resource objects
    int newOpacity = 255;
    // For every Resource object,
    for (Resource res : getAllResources()) {
      // Change the location in the Z to be zero
      newLocation = new PVector(res.getLocation().x, res.getLocation().y, 0);
      // Set the new location and the new opacity
      res.setLocation(newLocation);
      res.setOpacity(newOpacity);
    }
  }

  // The method that compensates for a zoomed out view of the world
  void zoomOut() {
    // A new location for the Resource objects
    PVector newLocation;
    // A new opacity for the Resource objects
    int newOpacity = 100;
    // For every Resource object,
    for (Resource res : getAllResources()) {
      // Change the location of the Z to compensate for the zoomed out view
      newLocation = new PVector(res.getLocation().x, res.getLocation().y, world.getZoomedOut());
      // Set the new location and the new opacity
      res.setLocation(newLocation);
      res.setOpacity(newOpacity);
    }
  }

  // --------- ACCESSORS & MUTATORS --------- //

  // Set the values of all the Resource objects
  void setResourceValues() {
    for (ResourceGenerator gen : resourceGens)
      gen.setResourceValue();
  }

  // Set the weights of all the Resource objects
  void setResourceWeights() {
    for (ResourceGenerator gen : resourceGens)
      gen.setResourceWeight(gen.getResourceWeight());
  }

  // Set the styles of all the Resource objects
  void setResourceStyles() {
    for (ResourceGenerator gen : resourceGens)
      gen.setResourceStyle();
  }

  // Retrieve all of the Resource objects
  ArrayList<Resource> getAllResources() {
    ArrayList<Resource> allResources = new ArrayList<Resource>();
    for (ResourceGenerator gen : resourceGens) for (Resource res : gen.getResources())
      allResources.add(res);
    return allResources;
  }
}