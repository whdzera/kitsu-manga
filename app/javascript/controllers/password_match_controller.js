import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['password', 'passwordConfirmation', 'message'];

  check() {
    const password = this.passwordTarget.value;
    const passwordConfirmation = this.passwordConfirmationTarget.value;

    if (password && passwordConfirmation && password !== passwordConfirmation) {
      this.messageTarget.textContent = 'Passwords do not match!';
      this.messageTarget.classList.remove('is-hidden');
    } else {
      this.messageTarget.textContent = '';
      this.messageTarget.classList.add('is-hidden');
    }
  }
}
