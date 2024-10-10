document.addEventListener('DOMContentLoaded', function() {
    const elements = document.querySelectorAll('.utc-time');
    elements.forEach(function(element) {
      const utcTime = element.getAttribute('data-utc-time');
      const localTime = new Date(utcTime).toLocaleString(); // Converts to the user's local time zone
      element.textContent = localTime; // Replace the content with local time
    });
  });
  
