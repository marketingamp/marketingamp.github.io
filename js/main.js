// ===== Mobile Menu Toggle =====
document.addEventListener('DOMContentLoaded', () => {
  const toggle = document.querySelector('.menu-toggle');
  const navLinks = document.querySelector('.nav-links');
  if (toggle && navLinks) {
    toggle.addEventListener('click', () => {
      navLinks.classList.toggle('active');
    });
    // Close menu when clicking a link
    navLinks.querySelectorAll('a').forEach(link => {
      link.addEventListener('click', () => navLinks.classList.remove('active'));
    });
  }

  // ===== Auto-generate Table of Contents =====
  const articleBody = document.querySelector('.article-body');
  if (articleBody) {
    const headings = articleBody.querySelectorAll('h2');
    if (headings.length >= 3) {
      const toc = document.createElement('nav');
      toc.className = 'toc';
      toc.setAttribute('aria-label', 'Table of contents');
      let html = '<div class="toc-header"><span class="toc-title">In This Article</span></div><ol class="toc-list">';
      headings.forEach((h, i) => {
        const id = 'section-' + i;
        h.id = id;
        const text = h.textContent.replace(/[—–]/g, '-').trim();
        html += `<li><a href="#${id}">${text}</a></li>`;
      });
      html += '</ol>';
      toc.innerHTML = html;
      // Insert before first paragraph
      const firstP = articleBody.querySelector('p');
      if (firstP) {
        // Insert after the second paragraph for better reading flow
        const secondP = firstP.nextElementSibling;
        if (secondP && secondP.tagName === 'P') {
          secondP.after(toc);
        } else {
          firstP.after(toc);
        }
      }
    }
  }

  // ===== Back to Top Button =====
  const btn = document.createElement('button');
  btn.className = 'back-to-top';
  btn.setAttribute('aria-label', 'Back to top');
  btn.innerHTML = '&#8593;';
  document.body.appendChild(btn);

  let ticking = false;
  window.addEventListener('scroll', () => {
    if (!ticking) {
      requestAnimationFrame(() => {
        btn.classList.toggle('visible', window.scrollY > 600);
        ticking = false;
      });
      ticking = true;
    }
  });
  btn.addEventListener('click', () => {
    window.scrollTo({ top: 0, behavior: 'smooth' });
  });

  // ===== Smooth scroll for anchor links =====
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', (e) => {
      const target = document.querySelector(anchor.getAttribute('href'));
      if (target) {
        e.preventDefault();
        target.scrollIntoView({ behavior: 'smooth', block: 'start' });
      }
    });
  });

  // ===== Reading Progress Bar (article pages only) =====
  if (articleBody) {
    const progressBar = document.createElement('div');
    progressBar.className = 'reading-progress';
    document.body.appendChild(progressBar);

    window.addEventListener('scroll', () => {
      if (!ticking) {
        requestAnimationFrame(() => {
          const rect = articleBody.getBoundingClientRect();
          const articleTop = rect.top + window.scrollY;
          const articleHeight = rect.height;
          const scrolled = window.scrollY - articleTop;
          const progress = Math.min(Math.max(scrolled / (articleHeight - window.innerHeight), 0), 1);
          progressBar.style.width = (progress * 100) + '%';
        });
      }
    });
  }

  // ===== Animate elements on scroll =====
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('fade-in');
        observer.unobserve(entry.target);
      }
    });
  }, { threshold: 0.1, rootMargin: '0px 0px -40px 0px' });

  document.querySelectorAll('.category-card, .article-card, .cta-box, .pros-cons, .verdict').forEach(el => {
    el.style.opacity = '0';
    observer.observe(el);
  });

  // ===== Slide-in CTA (article pages only) =====
  if (articleBody) {
    let slideInDismissed = false;
    const slideIn = document.createElement('div');
    slideIn.className = 'slide-in-cta';
    slideIn.innerHTML = `
      <button class="slide-in-close" aria-label="Close">&times;</button>
      <div class="slide-in-accent"></div>
      <h4>Free Download</h4>
      <p>2026 SaaS Tools Buyer's Guide</p>
      <form class="slide-in-form" action="#">
        <input type="email" placeholder="Your email address" required aria-label="Email address" />
        <button type="submit" class="btn btn-primary">Get the PDF</button>
      </form>
      <small>No spam. Unsubscribe anytime.</small>
    `;
    document.body.appendChild(slideIn);

    slideIn.querySelector('.slide-in-close').addEventListener('click', () => {
      slideIn.classList.remove('visible');
      slideInDismissed = true;
    });

    slideIn.querySelector('.slide-in-form').addEventListener('submit', (e) => {
      e.preventDefault();
      slideIn.classList.remove('visible');
      slideInDismissed = true;
    });

    window.addEventListener('scroll', () => {
      if (slideInDismissed) return;
      const rect = articleBody.getBoundingClientRect();
      const articleTop = rect.top + window.scrollY;
      const articleHeight = rect.height;
      const scrolled = window.scrollY - articleTop;
      const progress = scrolled / (articleHeight - window.innerHeight);
      if (progress >= 0.6) {
        slideIn.classList.add('visible');
      }
    });
  }

  // ===== Exit Intent Popup (desktop only) =====
  if (window.innerWidth > 768) {
    let exitPopupShown = false;
    const exitOverlay = document.createElement('div');
    exitOverlay.className = 'exit-popup-overlay';
    exitOverlay.innerHTML = `
      <div class="exit-popup-modal">
        <button class="exit-popup-close" aria-label="Close">&times;</button>
        <div class="exit-popup-icon">&#128218;</div>
        <h3>Before You Go...</h3>
        <p>Download our free <strong>2026 SaaS Tools Buyer's Guide</strong> and make smarter software decisions.</p>
        <form class="exit-popup-form" action="#">
          <input type="email" placeholder="Enter your email" required aria-label="Email address" />
          <button type="submit" class="btn btn-primary">Send Me the Guide</button>
        </form>
        <small>Join 5,000+ readers. No spam, ever.</small>
      </div>
    `;
    document.body.appendChild(exitOverlay);

    function closeExitPopup() {
      exitOverlay.classList.remove('visible');
    }

    exitOverlay.querySelector('.exit-popup-close').addEventListener('click', closeExitPopup);
    exitOverlay.addEventListener('click', (e) => {
      if (e.target === exitOverlay) closeExitPopup();
    });
    exitOverlay.querySelector('.exit-popup-form').addEventListener('submit', (e) => {
      e.preventDefault();
      closeExitPopup();
    });

    document.addEventListener('mouseout', (e) => {
      if (exitPopupShown) return;
      if (e.clientY < 10) {
        exitPopupShown = true;
        exitOverlay.classList.add('visible');
      }
    });
  }
});
