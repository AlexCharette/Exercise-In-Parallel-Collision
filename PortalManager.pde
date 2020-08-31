//
class PortalManager {

  // The list of Portal objects
  ArrayList<Portal> portals;

  // The constructor takes no parameters
  // All properties are initialized here
  PortalManager() {
    // Instantiated the list of Portal objects
    portals = new ArrayList<Portal>();
  }

  // The method that runs the other methods
  void run() {
    // Call the method that manages the Portal objects
    managePortals();
  }

  // The method that controls the drawing methods
  void display() {
    // Call the method that displays the Portal objects
    displayPortals();
  }

  // The method that adds Portal objects to the list
  // Takes a Resource object (the source) as a parameter
  void addPortal(Resource pResource) {
    portals.add(createPortal(pResource));
  }

  // The method that creates a new Portal object
  // Takes a Resource object (the source) as a parameter
  Portal createPortal(Resource pResource) {
    return new Portal(pResource);
  }

  // The method that calls the Portal objects' display methods
  void displayPortals() {
    for (Portal portal : portals)
      portal.display();
  }

  // The method that manages the Portal objects
  void managePortals() {
    // Check to see if any Portal objects are dead
    for (int i = getSize() - 1; i >= 0; i--) {
      // If one is,
      if (portals.get(i).isDead())
        // Remove it
        portals.remove(portals.get(i));
      // If not,
      else
        // Run it
        portals.get(i).run();
    }
  }

  // --------- ACCESSORS & MUTATORS --------- //

  // Retrieve the number of Portal objects
  int getSize() {
    return portals.size();
  }

  // Retrieve the list of Portal objects
  ArrayList<Portal> getPortals() {
    return portals;
  }
}