// Entry point for the build script in your package.json

// Import your Stimulus controllers
import { Application } from "@hotwired/stimulus"
import { definitionsFromContext } from "@hotwired/stimulus-webpack-helpers"
import "./controllers"

// Import Bootstrap
import * as bootstrap from "bootstrap"

// Import channels (assuming you have ActionCable channels)
import "./channels"

// Initialize Stimulus
const application = Application.start()
const context = require.context("./controllers", true, /\.js$/)
application.load(definitionsFromContext(context))

// Additional JavaScript for flash messages
document.addEventListener('DOMContentLoaded', () => {
  const flashMessages = document.querySelectorAll('.flash-message');
  
  flashMessages.forEach(message => {
    setTimeout(() => {
      message.classList.add('fade-out');
    }, 5000); // Fade out after 5 seconds
  });

});
