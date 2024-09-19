// app/javascript/controllers/navbar_controller.js

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["list"]

  toggle() {
    console.log("toggle entered")
    this.listTarget.classList.toggle("is-active")
  }
};
