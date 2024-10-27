import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "image"]

  open(event) {
    event.preventDefault()
    const photoUrl = event.currentTarget.dataset.photoUrl
    this.imageTarget.src = photoUrl
    this.modalTarget.classList.add('open')
  }

  close(event) {
    event.preventDefault()
    this.modalTarget.classList.remove('open')
  }
};
