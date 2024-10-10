function toggleMobileMenu(menu) {
  menu.classList.toggle('open');
}

document.addEventListener('DOMContentLoaded', function() {
  const hamburger = document.querySelector('.navbar__hamburger');
  if (hamburger) {
    hamburger.addEventListener('click', function() {
      toggleMobileMenu(this);
    });
  }
});
