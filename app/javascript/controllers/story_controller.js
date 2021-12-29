import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="story"
export default class extends Controller {
  static targets = [ "card" ]

  connect() {
    this.highlightSelectedParagraph()
  }

  highlightSelectedParagraph() {
    let selected = this.getSelectedParagraph()
    if (selected != null) {
      selected.classList.add("selected")
    }
  }

  unhighlightSelectedParagraph(event) {
    let selected = this.getSelectedParagraph()
    if (selected != null) {
      selected.classList.remove("selected")
    }
  }

  getSelectedParagraph() {
    let selected_id = window.location.hash.substring(2)
    // this alternative approach gets the selected wrapper based on the query string.
    // let match = window.location.search.match(/branch=.*?(\d+)$/)
    // if (match != null) {
    //   selected_id = match.slice(-1)[0]
    // }
    if (selected_id != "") {
      return document.getElementById(`p${selected_id}`).firstElementChild
    }
  }
}
