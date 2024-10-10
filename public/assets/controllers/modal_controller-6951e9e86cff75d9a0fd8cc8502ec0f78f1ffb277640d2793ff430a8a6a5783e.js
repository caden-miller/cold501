import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  hide(event) {
    if (event && event.detail.success) {
      this.element.innerHTML = ""
    }
  }
};
