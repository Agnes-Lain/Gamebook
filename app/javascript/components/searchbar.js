const initSearchBar = () => {
  const navbar = document.querySelector('.navbar-lewagon');
  if (navbar) {
    window.addEventListener('scroll', () => {
      if (window.scrollY >= 28) {
        navbar.classList.add('navbar-lewagon-dark');
      } else {
        navbar.classList.remove('navbar-lewagon-dark');
      }
    });
  }
}


export { initUpdateNavbarOnScroll };
