//
class World {

  // The Underworld object
  Underworld underworld;
  // The ResourceManager object
  ResourceManager resourceManager;
  // The Community object
  Community community;
  // The Sky object
  Sky sky;

  // The values for the different views
  int lowView, midView, highView;
  // The current view
  int currentView;
  // The value for zooming out on visuals
  int zoomedOut;
  // The most dangerous Resource object
  Resource mostDangerousResource;

  // The constructor takes no parameters
  // All properties are initialized here
  World() {
    // Instantiate the Underworld object
    underworld = new Underworld();
    // Instantiate the ResourceManager object
    resourceManager = new ResourceManager();
    // Instantiate the Community object
    community = new Community();
    // Instantiate the Sky object
    sky = new Sky();

    // Set the values for the different views
    lowView = 1;
    midView = 2;
    highView = 3;
    // Set the current view to a default 
    currentView = 2;
    // Set the value for zooming out on visuals
    zoomedOut = -200;
  }

  // The method that runs the other methods
  void run() {
    // Call the run methods for the Underworld object, the ResourceManager object, and the Community object
    underworld.run();
    resourceManager.run();
    community.run();
    // If the view is greater or equal to the mid view
    if (getView() >= getMidView()) {
      // Display both the ResourceManager and the Community
      resourceManager.display();
      community.display();
    }
    // Call the run method for the Sky object
    sky.run();
  }

  // The method that gets called when a key is pressed
  void keyPressed() {
    // If the key is one, 
    if (key == '1') 
      // Switch to low view
      currentView = lowView;
    // If the key is two,
    else if (key == '2')
      // Switch to mid view
      currentView = midView;
    // If the key is three, 
    else if (key == '3')
      // Switch to high view
      currentView = highView;
    // Otherwise,
    else
      // Don't switch the view
      currentView = currentView;
  }

  // --------- ACCESSORS & MUTATORS --------- //

  // Retrieve the Community of the World
  Community getCommunity() {
    return community;
  }

  // Retrieve all the Agents in the Community
  ArrayList<Agent> getAgents() {
    return community.agents;
  }

  // Retrieve all the Resources in the ResourceManager
  ArrayList<Resource> getResources() {
    return resourceManager.getAllResources();
  }

  // Retrieve the Underworld of the World
  Underworld getUnderworld() {
    return underworld;
  }

  // Retrieve the Sky of the World
  Sky getSky() {
    return sky;
  }

  // Retrieve the current view
  int getView() {
    if (currentView == lowView)
      return lowView;
    else if (currentView == midView)
      return midView;
    else if (currentView == highView)
      return highView;
    else
      return 0;
  }

  // Retrieve the low view
  int getLowView() {
    return lowView;
  }

  // Retrieve the mid view
  int getMidView() {
    return midView;
  }

  // Retrieve the high view
  int getHighView() {
    return highView;
  }

  // Retrieve value tied to zooming out
  int getZoomedOut() {
    return zoomedOut;
  }

  // Set the World's most dangerous Resource object
  void setMostDangerousResource(Resource pNewResource) {
    mostDangerousResource = pNewResource;
  }

  // Retrieve the World's most dangerous Resource object
  Resource getMostDangerousResource() {
    return mostDangerousResource;
  }
}