// app/javascript/controllers/navbar_controller.js

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["list"]

  toggle() {
    this.listTarget.classList.toggle("is-active")
  }
}

