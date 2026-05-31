const fs = require('fs');
const path = require('path');

const baseDir = __dirname;
const langs = ['', 'de', 'en', 'es', 'fr', 'hi', 'ja', 'ko', 'pt', 'zh'];

const fontAwesomeRegex = /<link[\s\n]+rel="stylesheet"[\s\n]+href="https:\/\/cdnjs\.cloudflare\.com\/ajax\/libs\/font-awesome\/6\.5\.2\/css\/all\.min\.css"[\s\n]+crossorigin="anonymous"[\s\n]+referrerpolicy="no-referrer"[\s\n]*\/>/g;
const fontAwesomeRepl = `<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />`;

const mailtoRegex = /<a\s+href="mailto:[^"]+"\s+class="btn-primary"\s+id="contact-email-btn"\s+aria-label="([^"]+)">([\s\S]*?)<\/a>/g;
const mailtoRepl = `<button class="btn-primary" id="contact-email-btn" aria-label="$1">$2</button>`;

const scriptAppend = `
    /* ──────────────────────────────────────────────
       10. ANTI-SPAM EMAIL OBFUSCATION
    ────────────────────────────────────────────── */
    document.getElementById('contact-email-btn')?.addEventListener('click', function(e) {
      e.preventDefault();
      const user = 'appandgamesoft';
      const domain = 'gmail.com';
      window.location.href = 'mailto:' + user + '@' + domain;
    });
  </script>`;

for (const lang of langs) {
  const filePath = path.join(baseDir, lang, 'index.html');
  if (fs.existsSync(filePath)) {
    let content = fs.readFileSync(filePath, 'utf8');
    
    content = content.replace(fontAwesomeRegex, fontAwesomeRepl);
    content = content.replace(mailtoRegex, mailtoRepl);
    
    if (!content.includes('ANTI-SPAM EMAIL OBFUSCATION')) {
      const lastScriptIdx = content.lastIndexOf('</script>');
      if (lastScriptIdx !== -1) {
        content = content.slice(0, lastScriptIdx) + scriptAppend + content.slice(lastScriptIdx + 9);
      }
    }
    
    fs.writeFileSync(filePath, content, 'utf8');
    console.log('Updated ' + filePath);
  }
}
