$langs = @("", "de", "en", "es", "fr", "hi", "ja", "ko", "pt", "zh")
$baseDir = (Get-Item -Path ".\").FullName

$faRegex = '(?m)<link\s+rel="stylesheet"\s+href="https://cdnjs\.cloudflare\.com/ajax/libs/font-awesome/6\.5\.2/css/all\.min\.css"\s+crossorigin="anonymous"\s+referrerpolicy="no-referrer"\s*/>'
$faRepl = '<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />'

$mailtoRegex = '(?s)<a\s+href="mailto:[^"]+"\s+class="btn-primary"\s+id="contact-email-btn"\s+aria-label="([^"]+)">([\s\S]*?)</a>'
$mailtoRepl = '<button class="btn-primary" id="contact-email-btn" aria-label="$1">$2</button>'

$scriptAppend = @"
    /* ──────────────────────────────────────────────
       10. ANTI-SPAM EMAIL OBFUSCATION
    ────────────────────────────────────────────── */
    document.getElementById('contact-email-btn')?.addEventListener('click', function(e) {
      e.preventDefault();
      const user = 'appandgamesoft';
      const domain = 'gmail.com';
      window.location.href = 'mailto:' + user + '@' + domain;
    });
  </script>
"@

foreach ($lang in $langs) {
    $filePath = if ($lang -eq "") { Join-Path $baseDir "index.html" } else { Join-Path (Join-Path $baseDir $lang) "index.html" }
    
    if (Test-Path $filePath) {
        $content = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)
        
        $content = $content -replace $faRegex, $faRepl
        $content = $content -replace $mailtoRegex, $mailtoRepl
        
        if (-not $content.Contains('ANTI-SPAM EMAIL OBFUSCATION')) {
            $lastIdx = $content.LastIndexOf("</script>")
            if ($lastIdx -ne -1) {
                $content = $content.Substring(0, $lastIdx) + $scriptAppend + $content.Substring($lastIdx + 9)
            }
        }
        
        $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
        [System.IO.File]::WriteAllText($filePath, $content, $utf8NoBom)
        Write-Host "Updated $filePath"
    }
}
