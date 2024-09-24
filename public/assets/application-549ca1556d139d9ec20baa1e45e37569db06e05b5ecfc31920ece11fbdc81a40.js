// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import { Application } from "stimulus"


// Create a Stimulus application
const application = Application.start();

// Register your controller
application.register("navbar", ,/controllers/navbar_controller);
