$content = [System.IO.File]::ReadAllText("es/index.html", [System.Text.Encoding]::UTF8)
$content = [regex]::Replace($content, '(?s)<h1 id="hero-heading" class="hero-title reveal reveal-delay-1">.*?</h1>', '<h1 id="hero-heading" class="hero-title reveal reveal-delay-1">
          Vibecoding<br />sin límites
        </h1>')
$utf8NoBom = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::WriteAllText("es/index.html", $content, $utf8NoBom)
Write-Host "Fixed Spanish hero"
