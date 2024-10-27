import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "modal", "image" ]

  connect() {
    // Create the modal element if it doesn't exist
    if (!document.getElementById('fullscreen-modal')) {
      const modal = document.createElement('div')
      modal.id = 'fullscreen-modal'
      modal.setAttribute('data-controller', 'fullscreen')
      modal.setAttribute('data-fullscreen-target', 'modal')
      modal.innerHTML = `
        <div class="fullscreen-modal-content" data-fullscreen-target="content">
          <img src="" alt="Full Screen Photo" class="fullscreen-image" data-fullscreen-target="image">
          <button class="close-button" data-action="click->fullscreen#close">&times;</button>
        </div>
      `
      document.body.appendChild(modal)
    }
  }

  open(event) {
    event.preventDefault()
    const photoUrl = event.currentTarget.dataset.photoUrl
    const modal = document.getElementById('fullscreen-modal')
    const image = modal.querySelector('.fullscreen-image')
    image.src = photoUrl
    modal.classList.add('open')
  }

  close(event) {
    event.preventDefault()
    const modal = document.getElementById('fullscreen-modal')
    modal.classList.remove('open')
  }
};
