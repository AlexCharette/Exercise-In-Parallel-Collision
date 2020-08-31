// //<>//
class Agent { 

  // Control location, acceleration, and velocity
  PVector location, acceleration, velocity;
  // The limit for the Agent's speed
  float maxSpeed;
  // A minimum speed
  final float MIN_SPEED;
  // A maximum force 
  final float MAX_FORCE;

  // The color of the Agent
  color fillColor;
  // The opacity of the Agent
  int opacity;

  // The size of the Agent
  int size;
  // The radius within which Resources are gathered
  float gatherRadius;
  // The radius within which Resources are sought
  float seekRadius;
  // A default direction for the Agent
  PVector defaultDirection;
  // A target location for the Agent
  PVector targetLocation;
  // A target Resource for the Agent
  Resource targetResource;
  // The last collected Resource of the Agent
  Resource lastCollectedResource;

  // The other Agents in the Community
  ArrayList<Agent> otherAgents;
  // A target Agent for the Agent
  Agent targetAgent;
  // Flag whether or not the Agent has been killed
  boolean wasKilled;
  // A lover Agent for the Agent
  Agent loverAgent;
  // Flag whether or not the Agent has a baby or is a parent
  boolean hasBaby, isParent;
  // A parent Agent for the Agent
  Agent parent;
  // A child Agent for the Agent
  Agent child;
  // The overall fear of the Agent
  float overallFear;

  // The variable that tracks the Agent's wealth
  float wealth;
  // The variable that tracks the Agent's weight
  float weight;

  // The weights to evaluate the importance of the different factors when choosing a Resource
  float proximityWeight;
  float valueWeight;
  float competitionWeight;
  float fearWeight;
  float weightWeight;
  float targetWeight;

  // The weights to evaluate the importance of the different factors when forming an opinion of another Agent object
  float empathyWeight;
  float jealousyWeight;
  float envyWeight;

  // The Agent's constructor accepts no parameters
  // All variables are initialized in here
  Agent() {
    // Set a random location for the Agent
    location = new PVector(round(random(0, width)), round(random(0, height)), 0);
    // Initialize the velocity and acceleration vectors to 0
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    // Set the speed limit
    maxSpeed = 2.7;
    // Set the minimum speed
    MIN_SPEED = 0.9;
    // Set the maximum force  
    MAX_FORCE = 0.05;

    // Set the opacity
    opacity = 255;

    // Set the Agent's size
    size = 15;
    // Set the size of the gathering radius
    gatherRadius = size;
    // Set the size of the seeking radius
    seekRadius = size * 15;
    // Set a random, default direction for the Agent
    defaultDirection = getRandomLocation().copy();

    // Instantiate the list of other Agent objects
    otherAgents = new ArrayList<Agent>();
    // Set the target and lover Agent objects to null
    targetAgent = loverAgent = null;
    // Flag that the Agent was not killed, does not have a baby and is not a parent
    wasKilled = hasBaby = isParent = false;
    // Set the parent and child Agent objects to null
    parent = child = null;
    // Set the overall fear
    overallFear = 2;

    // Set the weights of the parameters
    proximityWeight = random(0, 1);
    valueWeight = random(0, 1);
    competitionWeight = random(0, 1);
    fearWeight = random(0, 2);
    weightWeight = random(0, 1);
    targetWeight = round(random(2, 5));
    empathyWeight = random(0, 1);
    jealousyWeight = random(0.4, 1);
    envyWeight = random(0, 0.7);
  }

  // The Agent's second constructor
  // Takes an Agent object (the parent Agent) as a parameter
  // All variables are initialized in here
  Agent(Agent pParent) {
    // Set a random location for the Agent
    location = new PVector(round(random(0, width)), round(random(0, height)), 0);
    // Initialize the velocity and acceleration vectors to 0
    velocity = acceleration = new PVector(0, 0);
    // Set the speed limit
    maxSpeed = 2.7;
    // Set the minimum speed
    MIN_SPEED = 0.9;
    // Set the maximum force  
    MAX_FORCE = 0.05;

    // Set the opacity
    opacity = 255;

    // Set the Agent's size
    size = 15;
    // Set the size of the gathering radius
    gatherRadius = size;
    // Set the size of the seeking radius
    seekRadius = size * 15;
    // Set a random, default direction for the Agent
    defaultDirection = getRandomLocation().copy();

    // Instantiate the list of other Agent objects
    otherAgents = new ArrayList<Agent>();
    // Set the target and lover Agent objects to null
    targetAgent = loverAgent = null;
    // Flag that the Agent was not killed, does not have a baby and is not a parent
    wasKilled = hasBaby = isParent = false;
    // Set the parent Agent object to the given one
    parent = pParent;
    // Set the child Agent object to null
    child = null;
    // Set the overall fear
    overallFear = 2;

    // Set the weights of the parameters
    proximityWeight = random(0, 1);
    valueWeight = random(0, 1);
    competitionWeight = random(0, 1);
    fearWeight = random(0, 2);
    weightWeight = random(0, 1);
    targetWeight = round(random(2, 5));
    empathyWeight = random(0, 1);
    jealousyWeight = random(0.4, 1);
    envyWeight = random(0, 0.7);
  }

  // --------- RUN METHODS --------- //

  // The method that runs all of the Agent's other methods
  void run() {
    // Call the method that retrieves a list of other Agent objects
    otherAgents = getOtherAgents(world.getAgents());
    // Call the method that runs the miscellaneous methods
    runMiscMethods();
    // Call the method that causes the Agent to avoid other Agent objects
    avoidOthers(otherAgents);
    // Call the method that checks the competition between Agent objects
    checkCompetition(otherAgents);
    // If the Agent has a target Agent,
    if (hasTargetAgent()) {
      // Allow it to be sought and killed
      seekTargetAgent();
      killTargetAgent();
    }
    // If the Agent has a lover Agent,
    if (hasLoverAgent()) {
      // Allow it to be sought and reproduced with
      seekLoverAgent();
      reproduce();
    }
    // If the Agent does not have a target Agent or a lover Agent,
    if (hasTargetAgent() == false && hasLoverAgent() == false) 
      // Call the method that moves the Agent to Resource objects
      moveToResource(world.getResources());
    // Call the method that manages the Agent's weight
    manageWeight();
  }

  // The method that runs the miscellaneous methods
  void runMiscMethods() {
    // Call the method that prevents the Agent from leaving the canvas
    checkEdges();
    // Call the method that moves the Agent
    update();
  }

  // --------- MISCELLANEOUS METHODS --------- //

  // The method that draws the Agent
  void display() {
    // Set colors for the different states
    color normalColor = #2DA3E0;
    color huntingColor = #CB2525;
    color lovingColor = #F761EE;
    // Remove the stroke
    noStroke();
    // If the Agent has a target Agent,
    if (hasTargetAgent())
      // Change the color appropriately,
      fillColor = huntingColor;
    // If the Agent has a lover Agent,
    else if (hasLoverAgent())
      // Change the color appropriately,
      fillColor = lovingColor;
    // Otherwise,
    else 
    // Keep the default color 
    fillColor = normalColor;
    // Set the Agent's color to its color variable
    fill(fillColor, opacity);
    // Allow the Agent to be drawn relative to its Z position
    pushMatrix();
    translate(0, 0, location.z);
    // Draw an ellipse at the location vector using the Agent's size variable
    ellipse(location.x, location.y, getSize(), getSize());
    popMatrix();
  }

  // The method that moves the Agent
  void update() {
    // Increase the velocity with the acceleration
    velocity.add(acceleration);
    // Limit the velocity with the maxSpeed variable
    velocity.limit(maxSpeed);
    // Change the location with the velocity
    location.add(velocity);
  }

  // The method that applies a force to the Agent in order to move it
  // Takes a PVector (the force) as a parameter
  void applyForce(PVector pForce) {
    // Modify the acceleration with the force parameter
    acceleration.add(pForce);
  }

  // The method that makes the Agent move towards a target
  // Takes a PVector (the target) as a parameter
  void seek(PVector pNewTarget) {
    // Set a direction for the Agent by getting the distance between the target and the Agent's location
    PVector targetPath = PVector.sub(pNewTarget, location);
    // Get the unit vector of that distance
    targetPath.normalize();
    // Multiply it by the speed limit variable
    targetPath.mult(maxSpeed);
    // Decrease the distance between the Agent and its target
    PVector steer = PVector.sub(targetPath, velocity);
    // Apply the steer variable as a force
    applyForce(steer);
  }

  // The method that prevents the Agent from leaving the canvas
  void checkEdges() {
    // Constrain the X and Y of the location to the edges of the canvas
    location.x = constrain(location.x, 0, width);
    location.y = constrain(location.y, 0, height);
    // If the Agent reaches an edge, turn it around
    if (location.x >= width || location.x <= 0) {
      velocity.x = velocity.x * -1;
    }
    if (location.y >= height || location.y <= 0) {
      velocity.y = velocity.y * -1;
    }
  }

  // The method that allows the Agent to wander
  void wander() {
    // Set a random target to wander to
    PVector wanderTarget = getRandomLocation().copy();
    // Get the distance between the Agent and the target
    PVector distance = PVector.sub(wanderTarget, location);
    // Set the proximity limit
    int limit = 5;
    // If the distance is less than or equal to the limit
    if (distance.mag() >= limit) {
      // Set a new random target to wander to
      wanderTarget = getRandomLocation().copy();
    }
    // Set the wander target as the target location
    setTargetLocation(wanderTarget);
  }

  // The method that sorts a given value from lowest to highest
  // Takes an ArrayList of floats (the value to be sorted) as a parameter
  ArrayList<Float> sortLowestToHighest(ArrayList<Float> pValues) {
    // Create a new temporary list
    ArrayList<Float> tempValues = new ArrayList<Float>();
    // Add all of the values in the original list to the new list
    for (int i = 0; i < pValues.size(); i++) {
      tempValues.add(pValues.get(i));
    }
    // Flag whether or not a swap has occured
    boolean didSwap = true;
    // While a swap has occured,
    while (didSwap) {
      // Flag it as being false at default (it must loop at least once anyway)
      didSwap = false;
      // Iterate through the list
      for (int i = 0; i < tempValues.size(); i++) {
        // As long as the iterator has not reached the last value
        if (i != tempValues.size() - 1) {
          // Set a neighbour that comes after the current value
          float upNeighbour = tempValues.get(i +1);
          // If the neighbour value is less than the current one,
          if (upNeighbour < tempValues.get(i)) {
            // Move the current value up
            tempValues.set(i + 1, tempValues.get(i));
            // Move the neighbour down
            tempValues.set(i, upNeighbour);
            // Flag that a swap took place
            didSwap = true;
          }
        }
      }
    }
    return tempValues;
  }

  // The method that flags whether or not the Agent is inside the Creature
  boolean isInsideCreature(Creature pCreature) {
    // Store the answer
    boolean isInside = false;
    // For every node in the Creature,
    for (CreatureNode node : pCreature.getNodes()) {
      // If the distance between the Agent and the outer limits of that node is less than the radius of the node
      // and the Z location of the Agent is 100 points farther than the Z location of the Creature,
      if (dist(location.x, location.y, node.getLocation().x, node.getLocation().y) < node.getRadius() 
        && location.z - node.getLocation().z <= 100)
        // Flag as being inside
        isInside = true;
    }
    return isInside;
  }

  // --------- SOCIAL METHODS --------- //

  // Flag whether or not the Agent has a target Agent object 
  boolean hasTargetAgent() {
    return (targetAgent != null);
  }

  // Flag whether or not the Agent has a lover Agent object
  boolean hasLoverAgent() {
    return (loverAgent != null);
  }

  // Flag whether or not the Agent has a parent Agent object
  boolean hasParent() {
    return (parent != null);
  }

  // The method that seeks the Agent's target Agent object
  void seekTargetAgent() {
    // Store the location of the target Agent object
    PVector targetLocation = targetAgent.getLocation().copy();
    // Seek that location
    seek(targetLocation);
  }

  // The method that seeks the Agent's lover Agent object
  void seekLoverAgent() {
    // Store the location of the lover Agent object
    PVector loverLocation = loverAgent.getLocation().copy();
    // Seek that location
    seek(loverLocation);
  }

  //// The method that sets a new target for the Agent
  //// Takes a PVector (the new target) as a parameter
  //void setNewTargetAgent(Agent pNewTarget) {
  //  // Create a copy of the new target
  //  PVector targetLocation = pNewTarget.getLocation().copy(); 
  //  //
  //  setTargetAgent(pNewTarget); 
  //  // Update the target in the seek method
  //  seek(targetLocation);
  //}

  //// The method that sets a new lover for the Agent
  //// Takes a PVector (the new lover) as a parameter
  //void setNewLoverAgent(Agent pNewLover) {
  //  // Create a copy of the new target
  //  PVector targetLocation = pNewLover.getLocation().copy(); 
  //  //
  //  setLoverAgent(pNewLover); 
  //  // Update the target in the seek method
  //  seek(targetLocation);
  //}

  // The method that retrieves the opinion that the Agent has of another Agent object
  // Takes an Agent (the given Agent) as a parameter
  float getOpinionOf(Agent pAgent) {
    // The fear level that corresponds to the overall fear in the Community
    float fearLevel = map(overallFear, 0, 5, 0, 1);
    // The baseline for the opinion
    float baseline;
    // If the given Agent object is the Agent's parent or child,
    if (parent == pAgent || child == pAgent)
      // Increase the baseline
      baseline = 1 + fearLevel;
    // Otherwise, don't
    else
      baseline = 0.5 + fearLevel;
    // Set the default opinion to zero
    float opinion = 0;
    // Set a threshold for hate
    float hateLimit = -0.3;
    // Set a threshold for love
    float loveLimit = 1.5;

    // Empathy is derived from the overall fear in the Community
    float empathy = map(overallFear, 0, 10, 0, 1);
    // Base jealousy is set to the jealousy towards the given Agent object
    float baseJealousy = getJealousy(pAgent);
    // Map the base jealousy value to be within a new field
    baseJealousy = map(baseJealousy, -5, 5, -1.5, 1.5);
    // Constrain the base jealousy and store it in a new variable
    float jealousy = constrain(baseJealousy, -1.5, 1.5);
    // Envy is set to the envy towards the given Agent object
    float envy = getEnvy(pAgent);

    // The opinion is calculated from the baseline, the emotions and their weights
    opinion += baseline + (empathy * empathyWeight) + (jealousy * jealousyWeight) + (envy * envyWeight);
    // If the opinion is below the hate threshold and the Agent does not have a target
    if (opinion <= hateLimit && hasTargetAgent() == false) 
      // Set the target agent to the given Agent object
      setTargetAgent(pAgent);
    // If the opinion is above the love threshold, the Agent does not have a lover, the given Agent is not the Agent's child nor its parent
    // and the Agent is not already a parent,
    else if (opinion >= loveLimit && hasLoverAgent() == false && child != pAgent && parent != pAgent && pAgent.getIsParent() == false)
      // Set the lover agent to the given Agent object
      setLoverAgent(pAgent);
    return opinion;
  }

  // The method that computes the Agent's jealousy towards a given Agent
  // Takes an Agent (the given Agent) as a parameter
  float getJealousy(Agent pAgent) {
    // Store the jealousy of the Agent
    float jealousy;
    // Map the jealousy value based on the wealth difference between the two Agents
    jealousy = map(getWealthDifference(pAgent), -1000, 1000, -2, 2);
    return jealousy;
  }

  // The method that computes the envy of the Agent towards the given Agent object
  // Takes an Agent (the given Agent) as a parameter
  float getEnvy(Agent pAgent) {
    // Set the value of envy
    float envy = 0.7;
    // If the given Agent has collected the Agent's target Resource object
    if (pAgent.getLastCollectedResource() == targetResource)
      // Change envy to be a negative value
      envy = envy * -1;
    return envy;
  }

  // The method that computes the wealth difference between the Agent and the given Agent object
  // Takes an Agent (the given Agent) as a parameter
  float getWealthDifference(Agent pAgent) {
    // The wealth difference is the remainder of the Agent's wealth and that of the given Agent object
    float wealthDifference = wealth - pAgent.getWealth();
    return wealthDifference;
  }

  // The method that checks the competition between agents
  // Takes an ArrayList of Agent objects (the competing agents) as a parameter
  ArrayList<Agent> checkCompetition(ArrayList<Agent> pAgents) {
    return checkCompetition(pAgents, targetResource);
  }

  // The method that actually computes the competition between agents for a Resource object
  // Takes an ArrayList of Agent objects (the competing agents) and a Resource object (the given Resource) as parameters
  ArrayList<Agent> checkCompetition(ArrayList<Agent> pAgents, Resource pResource) {
    // Create a list of potential competition
    ArrayList<Agent> potentialCompetition = new ArrayList<Agent>(); 
    // Create a list of actual competition
    ArrayList<Agent> actualCompetition = new ArrayList<Agent>(); 
    // Flag as not having a competitor by default
    boolean competitorFound = false; 
    // For every Agent object that has a target Resource object,
    for (Agent agent : pAgents) {
      if (agent.hasTargetResource())
        // Add it to the list of potential competition
        potentialCompetition.add(agent);
    }
    // For every Agent object that is potential competition
    for (Agent agent : potentialCompetition) {
      // If the current Agent object's target Resource object is the same as the given Resource object,
      if (agent.targetResource == pResource) {
        // Flag as having a competitor
        competitorFound = true; 
        // Add it to the list of actual competition
        actualCompetition.add(agent);
      }
    }
    // If the Agent has a competitor
    if (competitorFound) {
      // Return the actual competition,
      return actualCompetition;
      // Otherwise,
    } else {
      // Return an empty list
      return new ArrayList<Agent>();
    }
  }

  // Return an ArrayList of the distances between the Agent and all the other Agent objects on the field
  // Takes an ArrayList of Agent objects (the other Agents in the community) as a parameter
  ArrayList<Float> getDistanceFromOthers(ArrayList<Agent> pAgents) {
    // Store the Agent locations in an ArrayList
    ArrayList<PVector> tempLocations = new ArrayList<PVector>(); 
    // Store the distances in an ArrayList
    ArrayList<Float> tempDistances = new ArrayList<Float>(); 
    // A variable that increments with every loop
    int index = 0; 
    // For every Agent object in the given list
    for (int i = 0; i < pAgents.size(); i++) {
      // Store the locations in the list of locations
      tempLocations.add(pAgents.get(i).getLocation()); 
      // Add the distance between that location and the Agent's location 
      tempDistances.add(dist(tempLocations.get(index).x, tempLocations.get(index).y, location.x, location.y)); 
      // Increment the index with every loop so that it is equivalent to the total number of Agent objects on the field
      index++;
    }
    // Return the ArrayList of distances
    return tempDistances;
  }

  // The method that causes the Agent to avoids other agents
  // Takes an ArrayList of Agent objects (the other agents) as a parameter
  void avoidOthers(ArrayList<Agent> pAgents) {
    // The minimum distance to be maintained
    final int MIN_DISTANCE = 50;
    // An index to serve as an iterator
    int index = 0; 
    // For every value in the list of distances between agents,
    for (Float distance : getDistanceFromOthers(pAgents)) {
      // Get the Agent's opinion of the Agent object at the current index and multiply it 
      float opinion = getOpinionOf(pAgents.get(index)) * 10;
      // If the result is greater than the minimum distance,
      if (opinion >= MIN_DISTANCE)
        // Constrain the distance to be between the minimum and the opinion
        distance = constrain(distance, MIN_DISTANCE, opinion);
      // Otherwise,
      else
        // Constrain the distance to be between the minimum and the inverted opinion
        distance = constrain(distance, MIN_DISTANCE, opinion * -1);
      // Seperate the Agent from the current Agent in the list, 
      // and pass the appropriate distance to be used as the desired distance
      PVector sep = separate(pAgents.get(index), distance); 
      // Increase the seperation
      sep.mult(1.5); 
      // Apply it as a force
      applyForce(sep); 
      // Increase the index
      index++;
    }
  }

  // This block of code by Daniel Shiffman, http://natureofcode.com
  // The method that seperates the Agent another
  // Takes an Agent object (the given Agent) and a float (the desired distance) as parameters
  PVector separate (Agent pAgent, float pDistance) {
    // Store the desired seperation
    float desiredSeparation;
    // If the given agent is neither a target or a lover,
    if (targetAgent != pAgent && loverAgent != pAgent)
      // Set the desired seperation to the given value
      desiredSeparation = pDistance; 
    // Otherwise,
    else
      // Set the desired seperation to a low value
      desiredSeparation = 2;
    // Instantiate the steering vector
    PVector steer = new PVector(0, 0); 
    // Instantiate the count
    int count = 0; 
    // Store the distance between the Agent and the given Agent's location
    float distance = PVector.dist(location, pAgent.location); 
    // If the distance is greater than 0 and less than the desired separation,
    if ((distance > 0) && (distance < desiredSeparation)) {
      // Calculate vector pointing away from neighbor
      PVector difference = PVector.sub(location, pAgent.location); 
      // Weight the difference according to the distance
      difference.normalize(); 
      difference.div(distance); 
      // Increase the steer with the difference
      steer.add(difference); 
      // Increase the count
      count++;
    }
    // If the count is greater than zero,
    if (count > 0) {
      // Divide the steer by it
      steer.div((float)count);
    }
    // If the steer is greater than zero,
    if (steer.mag() > 0) {
      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize(); 
      steer.mult(maxSpeed); 
      steer.sub(velocity); 
      // Limit the steer using the maximum force 
      steer.limit(MAX_FORCE);
    }
    return steer;
  }

  // END OF SHIFFMAN CODE // 

  // The method that allows the Agent to kill its target Agent object
  void killTargetAgent() {
    // Set the radius for killing
    float killRadius = gatherRadius * 2;
    // If the distance between the two Agent objects is less than the kill radius,
    if (dist(targetAgent.getLocation().x, targetAgent.getLocation().y, location.x, location.y) < killRadius) {
      // Flag the target as being killed,
      targetAgent.setWasKilled(true);
      // Take on the wealth and weight of the dead target
      addWealth(targetAgent.getWealth());
      addWeight(targetAgent.getWeight());
      // Set the target Agent object to null
      targetAgent = null;
    }
  }

  // The method that allows the Agent to reproduce with its lover Agent object
  void reproduce() {
    // Set the radius for mating
    float mateRadius = gatherRadius * 2;
    // If the distance between the two Agent objects is less than the mating radius and the lover is not a parent,
    if (dist(loverAgent.getLocation().x, loverAgent.getLocation().y, location.x, location.y) < mateRadius 
      && loverAgent.getHasBaby() == false && loverAgent.getIsParent() == false) {
      // Set the lover as having a baby and being a parent,
      loverAgent.setHasBaby(true);
      loverAgent.setIsParent(true);
      // Set the Agent as being a parent
      setIsParent(true);
      // Set the lover Agent object to null
      loverAgent = null;
    }
  }

  // --------- RESOURCE METHODS --------- //

  // The method that sets a new target for the Agent
  // Takes a PVector (the new target) as a parameter
  void setNewTargetResource(Resource pNewTarget) {
    // Create a copy of the new target
    PVector targetLocation = pNewTarget.getLocation().copy(); 
    // Set the target Resource object to the given one
    setTargetResource(pNewTarget); 
    // Update the target in the seek method
    seek(targetLocation);
  }

  // The method that flags whether or not the Agent has a target Resource object
  boolean hasTargetResource() {
    return (targetResource != null);
  }

  // The method that makes the Agent interact with Resource objects
  // Takes a ResourceManager object (the one holding the Resource information) as a parameter
  void moveToResource(ArrayList<Resource> pResources) {
    // Store all of the Resources in an ArrayList
    ArrayList<Resource> tempResources = new ArrayList<Resource>(); 
    // Store all of the seekable Resouces in an ArrayList
    ArrayList<Resource> seekableResources = new ArrayList<Resource>(); 
    // Iterate through the ResourceManager object's ArrayList of Resource objects
    for (int i = 0; i < pResources.size(); i++)
      // Copy them to the copy list
      tempResources.add(pResources.get(i)); 
    // Iterate through the ArrayList of distances, backwards as we will be removing elements from it
    for (int i = getDistanceFromResources(tempResources).size() - 1; i >= 0; i--) { 
      // If the distance between the Agent and a Resource object is less than or equal to the seekRadius,
      if (getDistanceFromResources(tempResources).get(i) <= seekRadius) {
        // Consider the Resource to be seekable
        seekableResources.add(tempResources.get(i));
      }
    }  
    // If there are seekable Resources,
    if (seekableResources.size() > 0) {
      // Evaluate which one is ideal and seek it
      setNewTargetResource(getIdealResource(seekableResources));
      // If there aren't any seekable Resources,
    } else if (seekableResources.size() <= 0) {
      // Let the Agent wander
      wander();
    }
    // Clear the list of seekable Resources so that it doesn't stack
    seekableResources.clear(); 
    for (int i = getDistanceFromResources(tempResources).size() - 1; i >= 0; i--) { 
      // If the distance between the Agent and a Resource object is less than or equal to the gatherRadius,
      if (getDistanceFromResources(tempResources).get(i) <= gatherRadius) {
        // Flag that Resource object as being found
        tempResources.get(i).setResourceFound(true); 
        // Call the method that collects that Resource object for the Agent
        collectResource(tempResources.get(i));
      }
    }
  }

  // The method that retrieves the Agent's ideal Resource object
  // Takes an ArrayList of Resource objects (the considered resources) as a parameter
  Resource getIdealResource(ArrayList<Resource> pResources) {
    // Set the highest potential to an unreachable value
    float maxPotential = -100000;
    // Set the ideal Resource object to null to start
    Resource ideal = null;
    // Iterate through the given list
    for (Resource res : pResources) {
      // Compute and store the potential of the current Resource object
      float potential = computeResourcePotential(res);
      // If the potential is greater than the maximum potential,
      if (potential > maxPotential) {
        // Change the maximum potential to reflect that
        maxPotential = potential;
        // Set the current Resource object as the ideal one
        ideal = res;
      }
    }
    return ideal;
  }

  // The method that computes the ideal Resource object
  // Takes a Resource object (the given Resource) as a parameter
  float computeResourcePotential(Resource pResource) {
    // Proximity is the distance from the Resource converted to a point between 0 and 1
    float proximity = 1.0 - (dist(location.x, location.x, pResource.getLocation().x, pResource.getLocation().y) / width);
    // Value is mapped according to the value of the Resource to a value between 0 and 1
    float value = map(pResource.getValue(), 0, 400, 0, 1);
    // The number of competitors is derived from the actual competition for the given Resource object
    int numCompetitors = checkCompetition(otherAgents, pResource).size();
    // Store the number of competitors
    float fewCompetitors;
    // If there are more than zero competitors,
    if (numCompetitors > 0)
      // Map the number of competitors to a value between 0 and 1
      fewCompetitors = map(numCompetitors, 0, otherAgents.size(), 1.0, 0.0);
    // Otherwise,
    else
      // Set the value to zero
      fewCompetitors = 0;
    // Instantiate fear to zero
    float fear = 0;
    // If there is a Resource object that the Community fears,
    if (world.getCommunity().getFearedResource() != null) {
      // And if that Resource's type is the same as the given Resource object,
      if (pResource.getClass().getName().equals(world.getCommunity().getFearedResource().getClass().getName()))
        // Set fear to one
        fear = 1;
      // If not, 
      else
        // Set it to zero
        fear = 0;
    }
    // Retrieve and store the weight of the given Resource object
    float weight = pResource.getWeight();
    // Indicate whether or not the Agent already has a target Resource object
    float hasTarget;
    // If the given Resource object is the target Resource object,
    if (pResource == targetResource) {
      // Set the value to one,
      hasTarget = 1;
      // If not,
    } else {
      // Set it to zero
      hasTarget = 0;
    }
    // Compute the score based on all the above parameters modified by their weights
    float score = (proximity * proximityWeight) + (value * valueWeight) + (fear * fearWeight) + (weight * weightWeight) 
      + (fewCompetitors * competitionWeight) + (hasTarget * targetWeight);
    return score;
  }

  // The method that retrieves the highest value Resource object
  // Takes an ArrayList of Resource objects (the given resources) as a parameter
  Resource getHighestValue(ArrayList<Resource> pResources) {
    // Store the Resource objects in a copy list
    ArrayList<Resource> resourcesCopy = new ArrayList<Resource>();
    // Copy every Resource in the given list to the copy list
    for (int i = 0; i < pResources.size(); i++) {     
      resourcesCopy.add(pResources.get(i));
    }
    // Flag whether or not a swap occured
    boolean didSwap = true; 
    // While a swap has occured
    while (didSwap) {
      // Flag that one has not to start (it has to loop once anyway)
      didSwap = false; 
      // For every Resource object in the copy list
      for (int i = 0; i < resourcesCopy.size(); i++) {
        // As long as the current Resource object is not the last in the list,
        if (i != resourcesCopy.size() - 1) {
          // Store the neighbour that comes after the current Resource object
          Resource upNeighbour = resourcesCopy.get(i + 1); 
          // If the value of the neighbour is less than the value of the current Resource object,
          if (upNeighbour.getValue() < resourcesCopy.get(i).getValue()) {
            // Move the neighbour down
            resourcesCopy.set(i + 1, resourcesCopy.get(i)); 
            // Move the current Resource object up
            resourcesCopy.set(i, upNeighbour); 
            // Flag that a swap took place
            didSwap = true;
          }
        }
      }
    }
    // Return the Resource object at the top of the list (the one with the highest value)
    return resourcesCopy.get(resourcesCopy.size() - 1);
  }

  // The method that sorts distances from lowest to highest
  // Takes an ArrayList of floats (the distance to sort) as a parameter
  ArrayList<Float> sortDistances(ArrayList<Float> pDistances) {
    // Store all of the distances in a copy
    ArrayList<Float> distancesCopy = new ArrayList<Float>();
    for (int i = 0; i < pDistances.size(); i++) {
      distancesCopy.add(pDistances.get(i));
    }
    // Return the sorted list
    return sortLowestToHighest(distancesCopy);
  }

  // Return an ArrayList of the distances between the Agent and all the Resource objects on the field
  // Takes an ArrayList of Resource objects (the resources on the field) as a parameter
  ArrayList<Float> getDistanceFromResources(ArrayList<Resource> pResources) {
    // Store the Resource locations in an ArrayList
    ArrayList<PVector> tempLocations = new ArrayList<PVector>(); 
    // Store the distances in an ArrayList
    ArrayList<Float> tempDistances = new ArrayList<Float>(); 
    // A variable that increments with every loop
    int index = 0; 
    // For every Resource object,
    for (int i = 0; i < pResources.size(); i++) {
      // Add the location of the current Resource object to the list of locations
      tempLocations.add(pResources.get(i).getLocation()); 
      // Add the distance between the current Resource's location and the Agent's location to the list of distances
      tempDistances.add(dist(tempLocations.get(index).x, tempLocations.get(index).y, location.x, location.y)); 
      // Increment the index with every loop so that it is equivalent to the total number of Resouce objects on the field
      index++;
    }
    // Return the ArrayList of distances
    return tempDistances;
  }

  // The method that collects Resource objects
  // Takes a Resource object (the collected Resource) as a parameter
  void collectResource(Resource pCollectedResource) {
    // Add the value of that Resource to the Agent's overall wealth
    addWealth(pCollectedResource.getValue()); 
    // Add the weight of that Resource to the Agent's overall weight
    addWeight(pCollectedResource.getWeight());
    // Replace the Agent's last collected Resource
    setLastCollectedResource(pCollectedResource);
  }

  // The method that increases the Agent's wealth
  // Takes a float (the increase to the Agent's wealth) as a parameter
  void addWealth(float pWealthIncrease) {
    // If the increase to the Agent's wealth is less than or equal to 0,
    if (pWealthIncrease > 0) {
      // Add the new amount to the Agent's wealth
      wealth += pWealthIncrease;
    }
  }

  // The method that increases the Agent's weight
  // Takes a float (the increase to the Agent's weight) as a parameter
  void addWeight(float pWeightIncrease) {
    // Map the increase in weight to a value between 0 and 1
    pWeightIncrease = map(pWeightIncrease, 0, 5, 0, 1);
    // Increment the weight with the increase
    weight += pWeightIncrease;
    // If the maximum speed minus the weight is greated or equal to the minimum speed,
    if (maxSpeed - weight >= MIN_SPEED) 
      // Reduce the speed
      maxSpeed -= weight;
  }

  // The method that manages the Agent's weight
  void manageWeight() {
    // The value to decrease weight
    float weightDecrease = 0.2;
    // If weight is greater than zero,
    if (weight > 0)
      // Decrease it
      weight -= weightDecrease;
  }

  // --------- ACCESSORS & MUTATORS --------- //

  // Retrieve the size of the Agent
  int getSize() {
    return size;
  }

  // Set the Agent's location
  void setLocation(PVector pNewLocation) {
    location = pNewLocation;
  }

  // Retrieve the location of the Agent
  PVector getLocation() {
    return location;
  }

  // Set the Agent's target location
  void setTargetLocation(PVector pTarget) {
    targetLocation = pTarget;
  }

  // Retrieve the Agent's target location
  PVector getTargetLocation() {
    return targetLocation;
  }

  // Set the Agent's target Agent object
  void setTargetAgent(Agent pTarget) {
    targetAgent = pTarget;
  }

  // Retrieve the Agent's target Agent object
  Agent getTargetAgent() {
    return targetAgent;
  }

  // Set the Agent's new wasKilled state
  void setWasKilled(boolean pNewState) {
    wasKilled = pNewState;
  }

  // Retrieve the wasKilled state of the Agent
  boolean getWasKilled() {
    return wasKilled;
  }

  // Set the Agent's target Agent object
  void setLoverAgent(Agent pLover) {
    loverAgent = pLover;
  }

  // Retrieve the Agent's target Agent object
  Agent getLoverAgent() {
    return loverAgent;
  }

  // Set the Agent's hasBaby state
  void setHasBaby(boolean pNewState) {
    hasBaby = pNewState;
  }

  // Retrieve the Agent's hasBaby state
  boolean getHasBaby() {
    return hasBaby;
  }

  // Set the Agent's isParent state
  void setIsParent(boolean pNewState) {
    isParent = pNewState;
  }

  // Retrieve the Agent's isParent state
  boolean getIsParent() {
    return isParent;
  }

  // Set the Agent's child Agent object
  void setChild(Agent pChild) {
    child = pChild;
  }

  // Retrieve the Agents' child Agent object
  Agent getChild() {
    return child;
  }

  // Set the overall fear of the Agent
  void setOverallFear(float pNewFear) {
    overallFear = pNewFear;
  }

  // Retrieve the overall fear of the Agent
  float getOverallFear() {
    return overallFear;
  }

  // Set the opacity of the Agent
  void setOpacity(int pNewOpacity) {
    opacity = pNewOpacity;
  }

  // Retrieve the opacity of the Agent
  int getOpacity() {
    return opacity;
  }

  // Retrieve the Agent's wealth
  float getWealth() {
    return wealth;
  }

  // Retrieve the Agent's weight
  float getWeight() {
    return weight;
  }

  // Set the Agent's target Resource object
  void setTargetResource(Resource pTarget) {
    targetResource = pTarget;
  }

  // Retrieve the Agent's target Resource object
  Resource getTargetResource() {
    return targetResource;
  }

  // Set the Agent's last collected Resource
  void setLastCollectedResource(Resource pResource) {
    lastCollectedResource = pResource;
  }

  // Retrieve the Agent's last collected Resource
  Resource getLastCollectedResource() {
    return lastCollectedResource;
  }

  // Retrieve the list Agent objects other than this one
  ArrayList getOtherAgents(ArrayList<Agent> pAgents) {
    ArrayList<Agent> others = new ArrayList<Agent>();
    for (Agent agent : pAgents) {
      // If the current Agent object is not this one, 
      if (agent != this)
        // Add it to the list
        others.add(agent);
    }
    return others;
  }
}