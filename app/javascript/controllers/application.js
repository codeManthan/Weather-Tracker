import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

// Register your controller here

import WeatherReportsController from "./weather_reports_controller";
application.register("weather-reports", WeatherReportsController);
