// app/javascript/controllers/hamburger_controller.js

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "bar1", "bar2", "bar3"]

  connect() {
    console.log("Hamburger controller connected") // Log when controller is initialized
  }

  toggle() {
    console.log("Hamburger clicked!") // Log when the toggle method is called

    // Toggle the 'open' class on the menu and bars
    this.menuTarget.classList.toggle('open')
    this.bar1Target.classList.toggle('open')
    this.bar2Target.classList.toggle('open')
    this.bar3Target.classList.toggle('open')
  }
};
