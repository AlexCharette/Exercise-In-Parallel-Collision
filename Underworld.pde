//
class Underworld {

  // The Creature object
  Creature creature;
  // The PortalManager object
  PortalManager portalManager;
  // The list of dangerous Resource objects
  ArrayList<Resource> dangerousResources;
  // The most dangerous Resource objects
  Resource mostDangerousResource;
  // The number of dangerous Gold, Silver, and Bronze objects
  int dangerousGold;
  int dangerousSilver;
  int dangerousBronze;

  // The constructor takes no parameters
  // All properties are initialized here
  Underworld() {
    // Instantiate the Creature object
    creature = new Creature();
    // Instantiate the PortalManager object
    portalManager = new PortalManager();
    // Instantiate the list of dangerous Resource objects
    dangerousResources = new ArrayList<Resource>();
    // Set all the dangerous resource counters to zero
    dangerousGold = dangerousSilver = dangerousBronze = 0;
  }

  // The method that runs all the other methods
  void run() {
    // Call the run methods of both the PortalManager and the Creature
    portalManager.run();
    creature.run();
    // If the current view is the low view,
    if (world.getView() == world.getLowView()) {
      // Display both the PortalManager and the Creature 
      portalManager.display();
      creature.display();
    }
    // If the Creature has escaped,
    if (creature.getHasEscaped()) {
      // Display it
      creature.display();
    }
    // Call the method that checks to spawn Portal objects
    checkForPortalSpawning();
    // Call the method that allows the Creature to escape
    warpCreature();
    // Call the method that tracks dangerous Resource objects
    checkDangerousResources();
    // Call the method that computes the most dangerous Resource object
    computeMostDangerousResource();
  }

  // The method that spawns Portal objects
  void checkForPortalSpawning() {
    // A random timer to spawn Portal objects randomly
    float randomTimer = random(0, 30);
    // A threshold above which a Portal object can spawn
    float threshold = 27;
    // If the timer is above the threshold and there are Resource objects,
    if (randomTimer >= threshold && world.getResources().isEmpty() == false) {
      // Get a Resource object at a random index and use it to create a Portal object
      int randomIndex = int(random(0, world.getResources().size()));
      portalManager.addPortal(world.getResources().get(randomIndex));
      portalManager.addPortal(new Resource());
    }
    // The test to see if a Resource object spawns a Portal object
    float randomCutOff;
    // Check to see if any Resources are dead,
    for (Resource res : world.getResources()) {
      // If one is,
      if (res.isDead()) {
        // Check the random cutoff
        randomCutOff = random(-2, 1);
        // If it's above zero,
        if (randomCutOff > 0)
          // Create a new Portal object
          portalManager.addPortal(res);
      }
    }
  }

  // The method that allows the Creature to escape from the underworld
  void warpCreature() {
    // Check to see if the Creature is inside a Portal object
    for (Portal portal : portalManager.getPortals()) {
      // If it is and has not escaped, 
      if (creature.isInsidePortal(portal) && creature.getHasEscaped() == false) {
        // Tag the origin of that Portal object as dangerous
        dangerousResources.add(portal.getSource());
        // Flag that the Creature has escaped
        creature.setHasEscaped(true);
      }
    }
  }

  // The method that checks to add dangerous Resource objects
  void checkDangerousResources() {
    // Set the counters to zero 
    dangerousGold = dangerousSilver = dangerousBronze = 0;
    // Check through all the dangerous Resource objects
    // and increase the appropriate counter 
    for (Resource res : dangerousResources) {
      if (res instanceof Gold) 
        dangerousGold++;
      else if (res instanceof Silver)
        dangerousSilver++;
      else if (res instanceof Bronze)
        dangerousBronze++;
    }
  }

  // The method that computes the most dangerous Resource object
  void computeMostDangerousResource() {
    // Return the Resource type that has the highest counter
    if (dangerousGold > dangerousSilver && dangerousGold > dangerousBronze)
      setMostDangerousResource(new Gold());
    else if (dangerousSilver > dangerousGold && dangerousSilver > dangerousBronze)
      setMostDangerousResource(new Silver());
    else if (dangerousBronze > dangerousSilver && dangerousBronze > dangerousGold)
      setMostDangerousResource(new Bronze());
    world.setMostDangerousResource(mostDangerousResource);
  }

  // --------- ACCESSORS & MUTATORS --------- //

  // Retrieve the Creature object
  Creature getCreature() {
    return creature;
  }

  // Retrieve the PortalManager object
  PortalManager getPortalManager() {
    return portalManager;
  }

  // Set the most dangerous Resource object
  void setMostDangerousResource(Resource pNewResource) {
    mostDangerousResource = pNewResource;
  }

  // Retrieve the most dangerous Resource object
  Resource getMostDangerousResource() {
    return mostDangerousResource;
  }
}