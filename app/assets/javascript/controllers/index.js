// Import the application from the main Stimulus application file
import { application } from "./application"

// Import individual controllers
import AgeCalculatorController from "./age_calculator_controller";

// Register each controller with the Stimulus application
application.register("age-calculator", AgeCalculatorController);


// Optionally, you can eagerly load all controllers located in a certain directory if structured that way,
// which seems to be your initial intent but was mixed in with explicit imports and registrations.
// This function would replace manual import and register calls if all controllers follow a standard naming and location pattern.
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading";
eagerLoadControllersFrom("controllers", application);
