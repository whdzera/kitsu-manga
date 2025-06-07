import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['image'];

  connect() {
    const link = this.element;
    const image = this.imageTarget;

    image.style.transition = 'transform 0.3s ease, filter 0.3s ease';

    link.addEventListener('mouseenter', () => {
      image.style.transform = 'scale(0.95)';
      image.style.filter = 'brightness(35%)';
    });

    link.addEventListener('mouseleave', () => {
      image.style.transform = 'scale(1.0)';
      image.style.filter = 'brightness(100%)';
    });
  }
}
