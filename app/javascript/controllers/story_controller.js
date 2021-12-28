import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="story"
export default class extends Controller {
  static targets = [ "card" ]

  connect() {
    this.focusSelectedParagraph()
  }

  focusSelectedParagraph() {
    let focused_id = window.location.hash.substring(1)
    let focused_paragraph = document.getElementById(`p${focused_id}`)
    if (!focused_paragraph == null) {
      // focused_paragraph.scrollIntoView({ behavior: 'instant', block: 'center' }) // doesn't work
      focused_paragraph.focus()
    }
  }

  unfocusSelectedParagraph(event) {
    let paragraph = event.currentTarget
    paragraph.classList.remove("selected")
  }
}
