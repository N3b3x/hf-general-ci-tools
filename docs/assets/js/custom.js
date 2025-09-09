// Custom JavaScript for hf-general-ci-tools documentation

(function() {
  'use strict';

  // Enhanced mobile navigation
  function initMobileNav() {
    const navToggle = document.createElement('button');
    navToggle.className = 'nav-toggle';
    navToggle.innerHTML = '☰';
    navToggle.setAttribute('aria-label', 'Toggle navigation');
    
    const siteNav = document.querySelector('.site-nav');
    if (siteNav) {
      document.body.appendChild(navToggle);
      
      navToggle.addEventListener('click', function() {
        siteNav.classList.toggle('open');
        navToggle.classList.toggle('active');
        document.body.classList.toggle('nav-open');
      });
      
      // Close nav when clicking outside
      document.addEventListener('click', function(e) {
        if (!siteNav.contains(e.target) && !navToggle.contains(e.target)) {
          siteNav.classList.remove('open');
          navToggle.classList.remove('active');
          document.body.classList.remove('nav-open');
        }
      });
    }
  }

  // Enhanced search functionality
  function initEnhancedSearch() {
    const searchInput = document.querySelector('.search-input');
    if (searchInput) {
      // Add search suggestions
      searchInput.addEventListener('input', function() {
        const query = this.value.toLowerCase();
        if (query.length > 2) {
          // Could implement search suggestions here
          console.log('Search query:', query);
        }
      });
      
      // Add keyboard shortcuts
      document.addEventListener('keydown', function(e) {
        if ((e.ctrlKey || e.metaKey) && e.key === 'k') {
          e.preventDefault();
          searchInput.focus();
        }
      });
    }
  }

  // Enhanced table of contents
  function initEnhancedTOC() {
    const toc = document.querySelector('.toc');
    if (toc) {
      // Add smooth scrolling to TOC links
      const tocLinks = toc.querySelectorAll('a[href^="#"]');
      tocLinks.forEach(link => {
        link.addEventListener('click', function(e) {
          e.preventDefault();
          const targetId = this.getAttribute('href').substring(1);
          const targetElement = document.getElementById(targetId);
          if (targetElement) {
            targetElement.scrollIntoView({
              behavior: 'smooth',
              block: 'start'
            });
          }
        });
      });
    }
  }

  // Enhanced code blocks
  function initEnhancedCodeBlocks() {
    const codeBlocks = document.querySelectorAll('pre code');
    codeBlocks.forEach(block => {
      // Add copy button
      const copyButton = document.createElement('button');
      copyButton.className = 'copy-button';
      copyButton.innerHTML = '📋';
      copyButton.setAttribute('aria-label', 'Copy code');
      copyButton.title = 'Copy code to clipboard';
      
      const pre = block.parentElement;
      pre.style.position = 'relative';
      pre.appendChild(copyButton);
      
      copyButton.addEventListener('click', function() {
        navigator.clipboard.writeText(block.textContent).then(() => {
          copyButton.innerHTML = '✅';
          setTimeout(() => {
            copyButton.innerHTML = '📋';
          }, 2000);
        });
      });
    });
  }

  // Enhanced callouts
  function initEnhancedCallouts() {
    const callouts = document.querySelectorAll('.callout');
    callouts.forEach(callout => {
      // Add expand/collapse functionality for long callouts
      const content = callout.querySelector('.callout-content');
      if (content && content.textContent.length > 500) {
        const toggleButton = document.createElement('button');
        toggleButton.className = 'callout-toggle';
        toggleButton.innerHTML = 'Show more';
        toggleButton.setAttribute('aria-label', 'Toggle callout content');
        
        content.style.maxHeight = '200px';
        content.style.overflow = 'hidden';
        content.style.transition = 'max-height 0.3s ease';
        
        callout.appendChild(toggleButton);
        
        toggleButton.addEventListener('click', function() {
          if (content.style.maxHeight === '200px') {
            content.style.maxHeight = 'none';
            toggleButton.innerHTML = 'Show less';
          } else {
            content.style.maxHeight = '200px';
            toggleButton.innerHTML = 'Show more';
          }
        });
      }
    });
  }

  // Enhanced print functionality
  function initPrintEnhancements() {
    // Add print button
    const printButton = document.createElement('button');
    printButton.className = 'print-button';
    printButton.innerHTML = '🖨️ Print';
    printButton.setAttribute('aria-label', 'Print page');
    printButton.title = 'Print this page';
    
    const pageHeader = document.querySelector('.page-header');
    if (pageHeader) {
      pageHeader.appendChild(printButton);
      
      printButton.addEventListener('click', function() {
        window.print();
      });
    }
  }

  // Enhanced accessibility
  function initAccessibilityEnhancements() {
    // Add skip to content link
    const skipLink = document.createElement('a');
    skipLink.href = '#main-content';
    skipLink.className = 'skip-link';
    skipLink.textContent = 'Skip to main content';
    skipLink.setAttribute('aria-label', 'Skip to main content');
    
    document.body.insertBefore(skipLink, document.body.firstChild);
    
    // Add focus management
    const focusableElements = document.querySelectorAll('a, button, input, textarea, select, [tabindex]:not([tabindex="-1"])');
    focusableElements.forEach(element => {
      element.addEventListener('focus', function() {
        this.style.outline = '2px solid var(--link-color)';
        this.style.outlineOffset = '2px';
      });
      
      element.addEventListener('blur', function() {
        this.style.outline = '';
        this.style.outlineOffset = '';
      });
    });
  }

  // Enhanced performance
  function initPerformanceEnhancements() {
    // Lazy load images
    const images = document.querySelectorAll('img[data-src]');
    const imageObserver = new IntersectionObserver((entries, observer) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          const img = entry.target;
          img.src = img.dataset.src;
          img.classList.remove('lazy');
          observer.unobserve(img);
        }
      });
    });
    
    images.forEach(img => imageObserver.observe(img));
    
    // Preload critical resources
    const criticalLinks = document.querySelectorAll('a[href^="#"]');
    criticalLinks.forEach(link => {
      link.addEventListener('mouseenter', function() {
        const targetId = this.getAttribute('href').substring(1);
        const targetElement = document.getElementById(targetId);
        if (targetElement) {
          targetElement.scrollIntoView({ behavior: 'smooth' });
        }
      });
    });
  }

  // Enhanced analytics (if enabled)
  function initAnalytics() {
    // Track page views
    if (typeof gtag !== 'undefined') {
      gtag('config', 'GA_TRACKING_ID', {
        page_title: document.title,
        page_location: window.location.href
      });
    }
    
    // Track search queries
    const searchInput = document.querySelector('.search-input');
    if (searchInput) {
      searchInput.addEventListener('input', function() {
        if (this.value.length > 3) {
          // Track search queries
          console.log('Search query tracked:', this.value);
        }
      });
    }
  }

  // Initialize all enhancements
  function init() {
    // Wait for DOM to be ready
    if (document.readyState === 'loading') {
      document.addEventListener('DOMContentLoaded', init);
      return;
    }
    
    // Initialize all features
    initMobileNav();
    initEnhancedSearch();
    initEnhancedTOC();
    initEnhancedCodeBlocks();
    initEnhancedCallouts();
    initPrintEnhancements();
    initAccessibilityEnhancements();
    initPerformanceEnhancements();
    initAnalytics();
    
    console.log('hf-general-ci-tools documentation enhancements loaded');
  }

  // Start initialization
  init();

})();
