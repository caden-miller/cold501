import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["slide", "description"]
  static values = { descriptions: Array }

  initialize() {
    this.currentIndex = 0
  }

  connect() {
    this.showCurrentSlide()
  }

  next() {
    this.currentIndex = (this.currentIndex + 1) % this.slideTargets.length
    this.showCurrentSlide()
  }

  previous() {
    this.currentIndex = (this.currentIndex - 1 + this.slideTargets.length) % this.slideTargets.length
    this.showCurrentSlide()
  }

  showCurrentSlide() {
    // Update slides
    this.slideTargets.forEach((element, index) => {
      element.classList.toggle("hidden", index !== this.currentIndex)
    })

    // Update description
    this.descriptionTarget.textContent = this.descriptionsValue[this.currentIndex]
  }
}
