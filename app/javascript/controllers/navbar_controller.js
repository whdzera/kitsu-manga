import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["menu"];

  connect() {
    console.log("navbar controller connected")
  }

  toggle() {
    this.element.classList.toggle("is-active");
    this.menuTarget.classList.toggle("is-active");
  }
}