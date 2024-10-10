// app/javascript/hamburger.js

function toggleMobileMenu(menu) {
  // Toggle the "open" class on the menu
  menu.classList.toggle("open");
}

// Attach the event listener to the hamburger icon
document.addEventListener("DOMContentLoaded", () => {
  const hamburgerIcon = document.querySelector(".navbar__hamburger");
  
  if (hamburgerIcon) {
    hamburgerIcon.addEventListener("click", function() {
      // Pass the hamburger element to the toggle function
      toggleMobileMenu(this);
    });
  }
});
