//
class Sky implements Runnable {

  // The WispGenerator object
  WispGenerator wispGenerator;
  // The CloudManager object
  CloudManager cloudManager;
  // The limit at which the sky begins
  int skyLimit;

  // The constructor takes no parameters
  // All properties are instantiated here
  Sky() {
    // Instantiate the WispGenerator and the CloudManager
    wispGenerator = new WispGenerator();
    cloudManager = new CloudManager();
    // Set the sky limit
    skyLimit = 400;
  }

  // The method that runs the other methods
  void run() {
    // Call the methods to run the WispGenerator and the CloudManager
    wispGenerator.run();
    cloudManager.run();
    // If the current view is at mid view or greater,
    if (world.getView() >= world.getMidView()) 
      // Display the WispGenerator
      wispGenerator.display();
    // If the current view is at the high view,
    if (world.getView() == world.getHighView()) {
      // Display the CloudManager
      cloudManager.display();
    }
  }

  // --------- ACCESSORS & MUTATORS --------- //

  // Retrieve a list of Wisp objects that are in the sky
  ArrayList<Wisp> getWispsInSky() {
    ArrayList<Wisp> skyWisps = new ArrayList<Wisp>();
    for (Wisp wisp : getWisps()) {
      if (wisp.reachedSky() && wisp.hasNode == false)
        skyWisps.add(wisp);
    }
    return skyWisps;
  }

  // Retrieve a list of Wisp objects that are on the ground
  ArrayList<Wisp> getWispsOnGround() {
    ArrayList<Wisp> groundWisps = new ArrayList<Wisp>();
    for (Wisp wisp : getWisps()) {
      if (wisp.reachedGround())
        groundWisps.add(wisp);
    }
    return groundWisps;
  }

  // Retrieve a list of Wisp objects that have spawned
  ArrayList<Wisp> getSpawnedWisps() {
    ArrayList<Wisp> spawnedWisps = new ArrayList<Wisp>();
    for (Wisp wisp : getWisps()) {
      if (wisp.isSpawned)
        spawnedWisps.add(wisp);
    }
    return spawnedWisps;
  }

  // Retrieve the list of Wisp objects
  ArrayList<Wisp> getWisps() {
    return wispGenerator.getWisps();
  }

  // Retrieve the sky limit
  int getSkyLimit() {
    return skyLimit;
  }
}