// Custom JavaScript for hf-general-ci-tools documentation

// Back to Top functionality
document.addEventListener('DOMContentLoaded', function() {
  // Create back to top button
  const backToTopButton = document.createElement('button');
  backToTopButton.className = 'back-to-top';
  backToTopButton.innerHTML = '↑';
  backToTopButton.setAttribute('aria-label', 'Back to top');
  backToTopButton.setAttribute('title', 'Back to top');
  
  // Add button to body
  document.body.appendChild(backToTopButton);
  
  // Show/hide button based on scroll position
  function toggleBackToTop() {
    if (window.pageYOffset > 300) {
      backToTopButton.classList.add('show');
    } else {
      backToTopButton.classList.remove('show');
    }
  }
  
  // Scroll to top function
  function scrollToTop() {
    window.scrollTo({
      top: 0,
      behavior: 'smooth'
    });
  }
  
  // Event listeners
  window.addEventListener('scroll', toggleBackToTop);
  backToTopButton.addEventListener('click', scrollToTop);
  
  // Initial check
  toggleBackToTop();
});
