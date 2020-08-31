/*
 * A subclass of the ResourceGenerator object that holds only Silver objects
 * Methods of the class (except for Accessors and Mutators):
 * SilverGenerator silverGenerator = new SilverGenerator();
 * silverGenerator.run();
 * silverGenerator.createResource();
 * silverGenerator.setResourceValue();
 */
class SilverGenerator extends ResourceGenerator {

  // The limits for the value of the Resources in this class's list of Resource objects
  final int MAX_VALUE;
  final int MIN_VALUE;

  // The SilverGenerator's constructor that for now accepts no parameters
  // All variables are initialized in here
  SilverGenerator() {
    // Call the methods of the ResourceGenerator parent class
    super();
    // Set the name of the Resource objects in this class's list of Resource objects
    name = "Silver";
    // Set the limits for the value of the Resource in this class's list of Resource objects
    MAX_VALUE = 30;
    MIN_VALUE = 0;
    // Set the weight value of the Resource objects in this class's list of Resource objects
    resourceWeight = 3;
    // Set the style of the Resource objects in this class's list of Resource objects
    resourceStyle = loadImage("Silver Ore.png");
  }

  // The method that runs all of the SilverGenerator's other methods that aren't called in the ResourceManager
  void run() {
    // Call the ResourceGenerator parent class's methods
    super.run();
  }

  // The method that creates a new Silver object
  // Takes a PVector (the location) as a parameter
  Resource createResource(PVector pLocation) {
    return new Silver(pLocation);
  }

  // The method that creates a new Silver object
  Resource createResource() {
    return new Silver();
  }

  // The method that sets the value of the Gold objects in this class's list of Resource objects
  void setResourceValue() {
    // If there are no Resource objects,
    if (resources.size() == 0) {
      // Use the default value
      super.setResourceValue();
      // Otherwise,
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