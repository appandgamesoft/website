import os
import re

base_dir = os.path.dirname(os.path.abspath(__file__))
langs = ['', 'de', 'en', 'es', 'fr', 'hi', 'ja', 'ko', 'pt', 'zh']

font_awesome_regex = re.compile(
    r'<link\s+rel="stylesheet"\s+href="https://cdnjs\.cloudflare\.com/ajax/libs/font-awesome/6\.5\.2/css/all\.min\.css"\s+crossorigin="anonymous"\s+referrerpolicy="no-referrer"\s*/>',
    re.MULTILINE
)
font_awesome_repl = '<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />'

mailto_regex = re.compile(
    r'<a\s+href="mailto:[^"]+"\s+class="btn-primary"\s+id="contact-email-btn"\s+aria-label="([^"]+)">([\s\S]*?)</a>'
)
mailto_repl = r'<button class="btn-primary" id="contact-email-btn" aria-label="\1">\2</button>'

script_append = """
    /* ──────────────────────────────────────────────
       10. ANTI-SPAM EMAIL OBFUSCATION
    ────────────────────────────────────────────── */
    document.getElementById('contact-email-btn')?.addEventListener('click', function(e) {
      e.preventDefault();
      const user = 'appandgamesoft';
      const domain = 'gmail.com';
      window.location.href = 'mailto:' + user + '@' + domain;
    });
  </script>"""

for lang in langs:
    file_path = os.path.join(base_dir, lang, 'index.html') if lang else os.path.join(base_dir, 'index.html')
    if os.path.exists(file_path):
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # 1. FontAwesome SRI
        content = font_awesome_regex.sub(font_awesome_repl, content)
        
        # 2. Mailto Link
        content = mailto_regex.sub(mailto_repl, content)
        
        # 3. Append script
        if 'ANTI-SPAM EMAIL OBFUSCATION' not in content:
            last_idx = content.rfind('</script>')
            if last_idx != -1:
                content = content[:last_idx] + script_append + content[last_idx + 9:]
                
        with open(file_path, 'w', encoding='utf-8', newline='') as f:
            f.write(content)
        print(f'Updated {file_path}')
