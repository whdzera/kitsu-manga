import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { timeout: Number };

  connect() {
    this.timeout = this.timeoutValue || 3000; 
    setTimeout(() => this.dismiss(), this.timeout);
  }

  dismiss() {
    this.element.classList.add("fade-out");
    setTimeout(() => this.element.remove(), 500); 
  }
}