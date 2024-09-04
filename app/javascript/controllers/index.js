// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)
import AgeCalculatorController from "./age_calculator_controller";

const application = Application.start();
application.register("age-calculator", AgeCalculatorController);
