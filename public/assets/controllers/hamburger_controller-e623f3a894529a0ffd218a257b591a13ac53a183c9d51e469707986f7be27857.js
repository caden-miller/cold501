import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "bar1", "bar2", "bar3"]

  toggle() {
    // Toggle the 'open' class on the hamburger and the menu
    this.menuTarget.classList.toggle('open')

    // Toggle bar transformations for the hamburger icon
    this.bar1Target.classList.toggle('open')
    this.bar2Target.classList.toggle('open')
    this.bar3Target.classList.toggle('open')
  }
};
