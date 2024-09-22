// app/javascript/controllers/navbar_controller.js

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["list"]

  connect() {
    console.log("Navbar controller connected")
  }

  toggle() {
    console.log("Toggle method called")
    this.listTarget.classList.toggle("is-active")
  }
}
;
