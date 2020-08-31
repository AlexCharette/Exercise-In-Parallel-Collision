/*
 * This class represents an object that moves in 2D space as a result of applying forces.
 * Methods of the class (except for Accessors and Mutators):
 * Community community = new Community();
 * community.run();
 * community.createAgent();
 * community.fillCommunity();
 * community.runAgents();
 */
class Community implements Runnable {

  // The list of all the Agent objects
  ArrayList<Agent> agents;
  // The limit for the Community's population
  final int INIT_MAX_POPULATION;
  // The Resource that the Agent objects should fear
  Resource fearedResource;
  // The overall fear of the Agent objects
  float overallFear;
  // The rate at which the fear increases
  float fearIncrease;
  // The rate at which the fear decreases
  float fearDecrease;
  // The lowest possible level of fear
  final float MIN_FEAR;

  // The Community's constructor that for now accepts no parameters
  // All properties are initialized in here
  Community() {
    // Initialize the list of Agent objects
    agents = new ArrayList<Agent>();
    // Set the population limit
    INIT_MAX_POPULATION = 12;
    // Fill the list of Agent objects
    fillCommunity();
    // Set the overall fear to zero
    overallFear = 0;
    // Set the fear increase value
    fearIncrease = 0.5;
    // Set the fear decrease value
    fearDecrease = 0.02;
    // Set the lowest possible level of fear
    MIN_FEAR = -0.5;
  }

  // The method that runs all of the Community's other methods
  void run() {
    // Set the Resource object to be feared as the world's most dangerous resource
    setFearedResource(world.getMostDangerousResource());
    // Call the method that updates the Agent objects
    updateCommunity();
    // Call the method that manages all of the Agent objects's methods
    manageAgents();
    // Call the method that controls the level of fear
    manageFear();
  }

  // The method that displays the Agent objects
  void display() {
    // Call the method that displays the Agent objects
    displayAgents();
    // If the world view is set to high,
    if (world.getView() == world.getHighView())
      // Call the method that zooms out
      zoomOut();
    // Otherwise,
    else
      // Call the method that zooms in
      zoomIn();
  }

  // Create a new Agent object
  Agent createAgent() {
    return new Agent();
  }

  // Create a new Agent object that has a parent
  Agent createAgent(Agent pParent) {
    return new Agent(pParent);
  }

  // The method that fills the list of Agent objects
  void fillCommunity() {
    // Until the iterator reaches the population limit
    for (int i = 0; i < INIT_MAX_POPULATION; i++)
      // For every iteration, add a new Agent object
      agents.add(createAgent());
  }

  // The method that updates the population of the Community
  void updateCommunity() {
    // A random timer that might cause a new Agent object to spawn
    float randomTimer = random(0, 40);
    // The threshold of that it has to cross
    int threshold = 38;
    // If the threshold is crossed and there are fewer Agent objects than the maximum,
    if (randomTimer > threshold && agents.size() < INIT_MAX_POPULATION)
      // Create a new one and add it to the list
      agents.add(createAgent());
    // Check every Agent
    for (int i = getNumAgents() - 1; i >= 0; i--) {
      // If it has a baby,
      if (agents.get(i).hasBaby) {
        // Flag it as no longer having one
        agents.get(i).setHasBaby(false);
        // Create a new Agent object and give it the current Agent as its parent
        agents.add(createAgent(agents.get(i)));
        // Assign the newest Agent to the current one as its child
        agents.get(i).setChild(getNewestAgent());
      }
    }
  }

  // The method that manages Agent objects
  void manageAgents() {
    // Set the overall fear of every Agent object
    for (Agent agent : agents)
      agent.setOverallFear(overallFear);
    // Check to see if any Agents have been killed or are inside the Creature
    for (int i = getNumAgents() - 1; i >= 0; i--) {
      // If an Agent is,
      if (agents.get(i).isInsideCreature(world.getUnderworld().getCreature()) || agents.get(i).wasKilled) {
        // Increase the overall fear
        increaseFear();
        // Remove the dead Agent
        agents.remove(agents.get(i));
        // If not,
      } else {
        // Call its run method
        agents.get(i).run();
      }
    }
  }

  // The method that calls the display methods of all the Agent objects
  void displayAgents() {
    for (Agent agent : agents) 
      agent.display();
  }

  // The method that manages the fear in the Community
  void manageFear() {
    // As long as the fear is greater than the minimum,
    if (overallFear > MIN_FEAR)
      // Decrease it gradually
      overallFear -= fearDecrease;
  }

  // The method that increases the fear of the Community
  void increaseFear() {
    // Increment the overall fear
    overallFear += fearIncrease;
  }

  // The method that compensates for a zoomed in view of the world
  void zoomIn() {
    // A new location and opacity for the Agents
    PVector newLocation;
    int newOpacity = 255;
    // For every Agent,
    for (Agent agent : agents) {
      // Assign the new location and set the Z position to zero
      newLocation = new PVector(agent.getLocation().x, agent.getLocation().y, 0);
      agent.setLocation(newLocation);
      // Assign the new opacity
      agent.setOpacity(newOpacity);
    }
  }

  // The method that compensates for a zoomed out view of the world
  void zoomOut() {
    // A new location and opacity for the Agents
    PVector newLocation;
    int newOpacity = 100;
    // For every Agent,
    for (Agent agent : agents) {
      // Assign the new location and set the Z position to a zoomed out position to compensate for the view change
      newLocation = new PVector(agent.getLocation().x, agent.getLocation().y, world.getZoomedOut());
      agent.setLocation(newLocation);
      // Assign the new opacity
      agent.setOpacity(newOpacity);
    }
  }

  // --------- ACCESSORS & MUTATORS --------- //

  // Retrieve the number of Agent objects
  int getNumAgents() {
    return agents.size();
  }

  // Set the feared Resource object
  void setFearedResource(Resource pNewResource) {
    fearedResource = pNewResource;
  }

  // Retrieve the Resource object that the Community fears
  Resource getFearedResource() {
    if (fearedResource != null)
      return fearedResource;
    else
      return null;
  }

  // Retrieve the newest Agent object in the list
  Agent getNewestAgent() {
    return agents.get(getNumAgents() - 1);
  }
}