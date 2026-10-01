(function(){
  var SUPPORTED = ['it','en','es'];

  function detectLang(){
    var saved = localStorage.getItem('site_lang');
    if (saved && SUPPORTED.indexOf(saved) !== -1) return saved;
    var nav = ((navigator.language || navigator.userLanguage || 'it') + '').toLowerCase().slice(0,2);
    return SUPPORTED.indexOf(nav) !== -1 ? nav : 'it';
  }

  function dict(lang){
    var T = window.TRANSLATIONS || {};
    return T[lang] || T['it'] || {};
  }

  function applyLang(lang){
    if (SUPPORTED.indexOf(lang) === -1) lang = 'it';
    var d = dict(lang);
    document.querySelectorAll('[data-i18n]').forEach(function(el){
      var key = el.getAttribute('data-i18n');
      if (d[key] !== undefined) el.innerHTML = d[key];
    });
    document.querySelectorAll('[data-i18n-placeholder]').forEach(function(el){
      var key = el.getAttribute('data-i18n-placeholder');
      if (d[key] !== undefined) el.setAttribute('placeholder', d[key]);
    });
    document.querySelectorAll('[data-i18n-alt]').forEach(function(el){
      var key = el.getAttribute('data-i18n-alt');
      if (d[key] !== undefined) el.setAttribute('alt', d[key]);
    });
    if (d.__title) document.title = d.__title;
    var metaDesc = document.querySelector('meta[name="description"]');
    if (metaDesc && d.__description) metaDesc.setAttribute('content', d.__description);
    document.documentElement.lang = lang;
    localStorage.setItem('site_lang', lang);
    var sel = document.getElementById('langSelect');
    if (sel) sel.value = lang;
  }

  window.setSiteLang = applyLang;
  window.getSiteLang = detectLang;

  document.addEventListener('DOMContentLoaded', function(){
    applyLang(detectLang());
  });
})();
