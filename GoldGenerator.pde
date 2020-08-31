/*
 * A subclass of the ResourceGenerator object that holds only Gold objects
 * Methods of the class (except for Accessors and Mutators):
 * GoldGenerator goldGenerator = new GoldGenerator();
 * goldGenerator.run();
 * goldGenerator.createResource();
 * goldGenerator.setResourceValue();
 */
class GoldGenerator extends ResourceGenerator {

  // The limits for the value of the Resources in this class's list of Resource objects
  final int MAX_VALUE;
  final int MIN_VALUE;

  // The GoldGenerator's constructor that for now accepts no parameters
  // All properties are initialized in here
  GoldGenerator() {
    // Call the methods of the ResourceGenerator parent class
    super();
    // Set the name of the Resource objects in this class's list of Resource objects
    name = "Gold";
    // Set the limits for the value of the Resource in this class's list of Resource objects
    MAX_VALUE = 50;
    MIN_VALUE = 0;
    // Set the weight value of the Resource objects in this class's list of Resource objects
    resourceWeight = 5;
    // Set the style of the Resource objects in this class's list of Resource objects
    resourceStyle = loadImage("Gold Ore.png");
  }

  // The method that runs all of the GoldGenerator's other methods that aren't called in the ResourceManager
  void run() {
    // Call the ResourceGenerator parent class's methods
    super.run();
  }

  // The method that creates a new Gold object
  // Takes a PVector (the location) as a parameter
  Resource createResource(PVector pLocation) {
    return new Gold(pLocation);
  }

  // The method that creates a new Gold object
  Resource createResource() {
    return new Gold();
  }

  // The method that sets the value of the Gold objects in this class's list of Resource objects
  void setResourceValue() {
    if (resources.size() == 0) {
      super.setResourceValue();
    } else {
      // Set the scarcityValue to the size of this class's list of Resource objects
      scarcityValue = (MAX_VALUE - 5) * -1;
      // Map the size of this class's list of Resource objects to the value of this class's list of Resource objects
      scarcityValue = map(scarcityValue, 0, resources.size(), MAX_VALUE, MIN_VALUE);
      // Set the value of this class's list of Resource objects to the scarcityValue
      resourceValue = scarcityValue;
    }
    // Iterate through this class's list of Resource objects
    for (int i = 0; i < resources.size(); i++)
      // Set the value of each Resource object to the resourceValue
      resources.get(i).setValue(resourceValue);
  }
}