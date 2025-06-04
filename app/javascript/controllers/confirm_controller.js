import { Controller } from "@hotwired/stimulus";
import Swal from "sweetalert2";

export default class extends Controller {
  static values = {
    message: String,
    title: String,
    icon: String,
    confirmText: String
  }

  confirm(event) {
    event.preventDefault();

    Swal.fire({
      title: this.titleValue || "Are you sure?",
      text: this.messageValue || "This action cannot be undone.",
      iconHtml: '<i class="fas fa-info-circle fa-2x" style="color: white;"></i>',
      background: "rgba(0, 0, 0, 0.36)",       
      color: "#ffffff",     
      showCancelButton: true,
      confirmButtonColor: "#e3342f",
      cancelButtonColor: "#6c757d",
      confirmButtonText: this.confirmTextValue || "Yes, continue!",
      cancelButtonText: "Cancel"
    }).then((result) => {
      if (result.isConfirmed) {
        this.element.closest("form").submit();
      }
    });
  }
}
