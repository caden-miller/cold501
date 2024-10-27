import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "image"]

  connect() {
    console.log("Connected fullscreen modal")
  }

  open(event) {
    console.log("Opened fullscreen modal")
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
