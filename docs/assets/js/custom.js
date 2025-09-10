// Custom JavaScript for hf-general-ci-tools documentation

// Back to Top functionality - Optimized
document.addEventListener('DOMContentLoaded', function() {
  // Create back to top button
  const backToTopButton = document.createElement('button');
  backToTopButton.className = 'back-to-top';
  backToTopButton.innerHTML = '↑';
  backToTopButton.setAttribute('aria-label', 'Back to top');
  backToTopButton.setAttribute('title', 'Back to top');
  backToTopButton.setAttribute('type', 'button');
  
  // Add button to body
  document.body.appendChild(backToTopButton);
  
  // Throttled scroll handler for better performance
  let ticking = false;
  function toggleBackToTop() {
    if (!ticking) {
      requestAnimationFrame(function() {
        if (window.pageYOffset > 300) {
          backToTopButton.classList.add('show');
        } else {
          backToTopButton.classList.remove('show');
        }
        ticking = false;
      });
      ticking = true;
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
  window.addEventListener('scroll', toggleBackToTop, { passive: true });
  backToTopButton.addEventListener('click', scrollToTop);
  
  // Initial check
  toggleBackToTop();
});
