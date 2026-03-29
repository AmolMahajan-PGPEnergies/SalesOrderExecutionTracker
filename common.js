/* ═══════════════════════════════════════════════════════
   COREPULSE — Common JavaScript
   Shared across all pages
═══════════════════════════════════════════════════════ */

// ─── THEME ───────────────────────────────────────────

function _syncThemeIcon() {
  const isLight = document.documentElement.classList.contains('light');
  document.querySelectorAll('.theme-toggle').forEach(function(btn) {
    btn.textContent = isLight ? '\uD83C\uDF19' : '\u2600\uFE0F';
    btn.title = isLight ? 'Switch to dark mode' : 'Switch to light mode';
  });
}

function toggleTheme() {
  document.documentElement.classList.toggle('light');
  var isLight = document.documentElement.classList.contains('light');
  try { localStorage.setItem('cpTheme', isLight ? 'light' : 'dark'); } catch(e) {}
  _syncThemeIcon();
}

// ─── SIDEBAR ─────────────────────────────────────────

function toggleSidebar() {
  document.body.classList.toggle('sb-col');
  var col = document.body.classList.contains('sb-col');
  var icon = document.getElementById('sbIcon');
  var lbl  = document.getElementById('sbLbl');
  if (icon) icon.textContent = col ? '\u25B7' : '\u25C1';
  if (lbl)  lbl.textContent  = col ? '' : 'Collapse';
}

// ─── MODAL ───────────────────────────────────────────

function openModal(id) {
  var el = document.getElementById(id);
  if (el) el.classList.add('open');
}

function closeModal(id) {
  var el = document.getElementById(id);
  if (el) el.classList.remove('open');
}

// ─── TOAST ───────────────────────────────────────────

function showToast(msg, type) {
  type = type || 'success';
  var area = document.getElementById('toastArea');
  if (!area) {
    area = document.createElement('div');
    area.id = 'toastArea';
    area.className = 'toast-area';
    document.body.appendChild(area);
  }
  var t = document.createElement('div');
  t.className = 'toast ' + type;
  t.innerHTML = '<span style="font-size:15px">' + (type === 'success' ? '\u2713' : '\u2715') + '</span> ' + msg;
  area.appendChild(t);
  setTimeout(function() {
    t.style.transition = 'opacity .4s';
    t.style.opacity = '0';
    setTimeout(function() { t.remove(); }, 400);
  }, 2800);
}

// ─── AUTO-INIT ────────────────────────────────────────
// Runs immediately since this script is loaded at end of <body>

// Sync theme icon (theme class already applied by inline <head> script)
_syncThemeIcon();

// Close modals on backdrop click
document.querySelectorAll('.modal-overlay').forEach(function(m) {
  m.addEventListener('click', function(e) {
    if (e.target === m) m.classList.remove('open');
  });
});

// Close modals on Escape key
document.addEventListener('keydown', function(e) {
  if (e.key === 'Escape') {
    document.querySelectorAll('.modal-overlay.open').forEach(function(m) {
      m.classList.remove('open');
    });
  }
});
