import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['input', 'message'];

  checkUsername() {
    const username = this.inputTarget.value.trim();

    if (username.length < 6) {
      this.messageTarget.textContent =
        'Username must be at least 6 characters.';
      this.messageTarget.classList.add('has-text-danger');
      return;
    }

    fetch(`/users/check_username?username=${username}`)
      .then((response) => response.json())
      .then((data) => {
        if (data.taken) {
          this.messageTarget.textContent = 'Username has been taken';
          this.messageTarget.classList.add('has-text-danger');
        } else {
          this.messageTarget.textContent = 'Username is available';
          this.messageTarget.classList.remove('has-text-danger');
          this.messageTarget.classList.add('has-text-success');
        }
      });
  }
}
