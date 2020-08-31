//
class Cloud {
  // The location of the Cloud
  PVector location;
  // A buffer to keep the cloud from spawning too close to the border
  int bufferSpace;
  // The maximum number of nodes in the Cloud
  final int MAX_NODES;
  // A list of CloudNode objects
  ArrayList<CloudNode> nodes;
  // The color of the Cloud
  color nodeColor;
  // Flag whether or not the Cloud has any CloudNodes
  boolean noNodes; 

  // The constructor takes no parameters
  // All variables are instantiated in here
  Cloud() {
    // Set the buffer space
    bufferSpace = 50;
    // Set a random location
    location = new PVector(random(0 + bufferSpace, width - bufferSpace), 
      random(0 + bufferSpace, height - bufferSpace), random(0, bufferSpace));
    // Set the maximum number of CloudNodes
    MAX_NODES = 4;
    // Instantiate the list of CloudNodes
    nodes = new ArrayList<CloudNode>();
    // Set the color of the Cloud
    nodeColor = #9BD3F0;
    // Flag as not having any nodes
    noNodes = true;
  }

  // The method that runs the Cloud's other methods
  void run() {
    // Call the method that creates the first CloudNode
    createFirstNode();
    // Call the method that fills the Cloud with CloudNodes
    fillCloud();
    // Call the method that runs the methods of the CloudNodes
    runNodes();
    // If there are no CloudNodes,
    if (nodes.isEmpty())
      // Flag appropriately
      noNodes = true;
  }

  // The method that creates the first CloudNode 
  void createFirstNode() {
    // If there are no nodes,
    if (noNodes)
      // Add one
      addNode();
    // Flag as having nodes
    noNodes = false;
  }

  // The method that fills the Cloud with CloudNodes
  void fillCloud() {
    // If the Cloud is not full,
    if (isFull() == false) {
      // And if there are zero nodes or the previous one is full,
      if (nodes.size() == 0 || nodes.get(nodes.size() - 1).isFull())
        // Add a new node
        addNode();
    }
  }

  // The method that handles anything relating to visuals
  void display() {
    // Call the method that sets the color of the Cloud
    setNodeColor();
    // Call the method that displays the CloudNodes
    displayNodes();
  }

  // The method that runs the CloudNodes
  void runNodes() {
    // For every node in the Cloud
    for (CloudNode node : nodes)
      // Run it
      node.run();
  }

  // The method that displays the CloudNodes
  void displayNodes() {
    // For every node in the Cloud
    for (CloudNode node : nodes)
      // Display it
      node.display();
  }

  // The method that adds a CloudNode to the Cloud
  void addNode() {
    // Create a new random location for the new node
    PVector randomLocation = new PVector(random(location.x - bufferSpace, location.x + bufferSpace), 
      random(location.y - bufferSpace, location.y + bufferSpace), location.z);
    // Add a node to the list and give it the random location
    nodes.add(createNode(randomLocation));
  }

  // The method that returns a new CloudNode
  // Takes a PVector (the location) as a parameter
  CloudNode createNode(PVector pLocation) {
    return new CloudNode(pLocation);
  }

  // The method that flags whether or not the Cloud is full
  boolean isFull() {
    // Return true if the maximum number of nodes hasn't been reached
    if (nodes.size() >= MAX_NODES)
      return true;
    else 
    return false;
  }

  // --------- ACCESSORS & MUTATORS --------- // 

  // Set the colors of the CloudNode objects
  void setNodeColor() {
    for (CloudNode node : nodes)
      node.setColor(nodeColor);
  }

  // Retrieve the number of CloudNode objects
  int getNumNodes() {
    return nodes.size();
  }

  // Retrieve the number of Wisp objects within this cloud
  int getTotalWisps() {
    ArrayList<Wisp> allWisps = new ArrayList<Wisp>();
    for (CloudNode node : nodes) for (Wisp wisp : node.getWisps())
      allWisps.add(wisp);
    return allWisps.size();
  }

  // Retrieve the list of CloudNodes
  ArrayList<CloudNode> getNodes() {
    return nodes;
  }
}