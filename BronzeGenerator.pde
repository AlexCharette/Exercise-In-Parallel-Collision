/*
 * A subclass of the ResourceGenerator object that holds only Bronze objects
 * Methods of the class (except for Accessors and Mutators):
 * BronzeGenerator bronzeGenerator = new BronzeGenerator();
 * bronzeGenerator.run();
 * bronzeGenerator.createResource();
 * bronzeGenerator.setResourceValue();
 */
class BronzeGenerator extends ResourceGenerator {

  // The limits for the value of the Resources in this class's list of Resource objects
  final int MAX_VALUE;
  final int MIN_VALUE;

  // The BronzeGenerator's constructor that for now accepts no parameters
  // All variables are initialized in here
  BronzeGenerator() {
    // Call the methods of the ResourceGenerator parent class
    super();
    // Set the name of the Resource objects in this class's list of Resource objects
    name = "Bronze";
    // Set the limits for the value of the Resource in this class's list of Resource objects
    MAX_VALUE = 20;
    MIN_VALUE = 0;
    // Set the weight value of the Resource objects in this class's list of Resource objects
    resourceWeight = 1;
    // Set the style of the Resource objects in this class's list of Resource objects
    resourceStyle = loadImage("Bronze Ore.png");
  }

  // The method that runs all of the BronzeGenerator's other methods that aren't called in the ResourceManager
  void run() {
    // Call the ResourceGenerator parent class's methods
    super.run();
  }

  // The method that creates a new Bronze object
  // Takes a PVector (the location of the new Bronze object) as a parameter
  Resource createResource(PVector pLocation) {
    return new Bronze(pLocation);
  }

  // The method that creates a new Bronze object
  Resource createResource() {
    return new Bronze();
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