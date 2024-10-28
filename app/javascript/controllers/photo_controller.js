import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  closeForm(event) {
    event.preventDefault();
    this.element.closest("turbo-frame").remove();
  }
}
