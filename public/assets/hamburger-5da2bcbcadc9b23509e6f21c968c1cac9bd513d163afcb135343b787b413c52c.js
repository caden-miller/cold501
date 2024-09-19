function toggleMobileMenu(menu) {
  console.log('Hamburger clicked!'); // Test if this function is being called
  menu.classList.toggle('open');
}

document.addEventListener('DOMContentLoaded', function() {
  const hamburger = document.querySelector('.navbar__hamburger');
  if (hamburger) {
    console.log('Hamburger menu found!'); // Check if the hamburger element exists
    hamburger.addEventListener('click', function() {
      console.log('Click event triggered!'); // Check if the click event is triggered
      toggleMobileMenu(this);
    });
  } else {
    console.log('Hamburger menu not found!'); // Handle the case where the element doesn't exist
  }
});
