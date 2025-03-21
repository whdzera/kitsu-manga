import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["password", "icon"];

  toggle() {
    if (this.passwordTarget.type === "password") {
      this.passwordTarget.type = "text";
      this.iconTarget.classList.remove("fa-eye");
      this.iconTarget.classList.add("fa-eye-slash");
    } else {
      this.passwordTarget.type = "password";
      this.iconTarget.classList.remove("fa-eye-slash");
      this.iconTarget.classList.add("fa-eye");
    }
  }
}
