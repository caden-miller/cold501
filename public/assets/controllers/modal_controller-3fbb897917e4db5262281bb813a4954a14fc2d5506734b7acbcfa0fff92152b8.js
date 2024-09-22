// app/javascript/controllers/modal_controller.js

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content"]

  connect() {
    console.log("Modal controller connected")
    this.element.setAttribute("aria-hidden", "true")
  }

  open() {
    console.log("Open method called")
    this.element.classList.add("modal--visible")
    this.element.setAttribute("aria-hidden", "false")
  }

  close() {
    this.element.classList.remove("modal--visible")
    this.element.setAttribute("aria-hidden", "true")
  }
};
