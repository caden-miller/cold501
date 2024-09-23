// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import { Application } from "@hotwired/stimulus"
import "@hotwired/turbo-rails"
import "./controllers"


// Create a Stimulus application
const application = Application.start();

// Register your controller
application.register("navbar", NavbarController);
