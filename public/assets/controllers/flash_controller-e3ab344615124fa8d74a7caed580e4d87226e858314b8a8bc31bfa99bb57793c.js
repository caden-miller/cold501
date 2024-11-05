import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // Set the timeout duration (in milliseconds)
    this.timeout = 1000; // 1 second

    // Hide the flash message after the timeout
    setTimeout(() => {
      this.dismiss();
    }, this.timeout);
  }

  dismiss() {
    this.element.classList.add("fade-out");
    this.element.addEventListener('transitionend', () => {
      this.element.remove();
    });
  }
};
