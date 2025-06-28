import '@hotwired/turbo-rails';
import 'controllers';

document.addEventListener('turbo:visit', () => {
  setTimeout(() => Turbo.navigator.delegate.adapter.progressBar.show(), 10);
});

document.addEventListener('turbo:load', () => {
  setTimeout(() => Turbo.navigator.delegate.adapter.progressBar.hide(), 1300);
});
