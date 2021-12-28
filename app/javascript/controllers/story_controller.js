import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="story"
export default class extends Controller {
  static targets = [ "card" ]

  unhighlightSelectedParagraph(event) {
    let selected = this.getSelectedParagraph()
    if (selected != null) {
      console.log("removing " + selected.id)
      selected.classList.remove("selected")
    }
  }

  getSelectedParagraph() {
    let selected_id = window.location.hash.substring(2)
    // alternative method, without anchor
    // let selected_id = window.location.search.match(/branch=.+?(\d+)$/).slice(-1)[0]
    return document.getElementById(`p${selected_id}`)
  }
}
