(function () {
  const storageKey = 'blog-theme';
  const systemPreference = window.matchMedia('(prefers-color-scheme: dark)');
  const savedTheme = localStorage.getItem(storageKey);
  const initialTheme = savedTheme === 'dark' || savedTheme === 'light'
    ? savedTheme
    : (systemPreference.matches ? 'dark' : 'light');

  function setTheme(theme, persist) {
    document.documentElement.dataset.theme = theme;
    if (persist) {
      localStorage.setItem(storageKey, theme);
    }
    const toggle = document.querySelector('.theme-toggle');
    if (toggle) {
      const isDark = theme === 'dark';
      toggle.textContent = isDark ? '☀' : '☾';
      toggle.setAttribute('aria-label', isDark ? 'Attiva modalità chiara' : 'Attiva modalità scura');
      toggle.setAttribute('title', isDark ? 'Modalità chiara' : 'Modalità scura');
      toggle.setAttribute('aria-pressed', String(isDark));
    }
  }

  setTheme(initialTheme, false);

  const nav = document.querySelector('.nav');
  if (!nav) return;

  const toggle = document.createElement('button');
  toggle.className = 'theme-toggle';
  toggle.type = 'button';
  toggle.addEventListener('click', function () {
    setTheme(document.documentElement.dataset.theme === 'dark' ? 'light' : 'dark', true);
  });
  nav.appendChild(toggle);
  setTheme(initialTheme, false);

  systemPreference.addEventListener('change', function (event) {
    if (!localStorage.getItem(storageKey)) {
      setTheme(event.matches ? 'dark' : 'light', false);
    }
  });
}());
