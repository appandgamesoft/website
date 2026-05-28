$targets = @("de", "es", "fr", "hi", "ja", "ko", "pt", "zh")

foreach ($lang in $targets) {
    $path = "$lang/index.html"
    if (Test-Path $path) {
        $content = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)

        # Standardize class to match the root (de/es use social-link)
        $content = $content -replace '<a([^>]+href="[^"]*youtube[^"]*"[^>]*)class="social-link"([^>]*)>', '<a$1class="social-btn youtube"$2>'
        $content = $content -replace '<a([^>]+href="[^"]*tiktok[^"]*"[^>]*)class="social-link"([^>]*)>', '<a$1class="social-btn tiktok"$2>'

        # Inject the <i class="fa-brands fa-youtube"></i> tag inside the youtube anchor
        $content = [Regex]::Replace($content, '(?s)(<a[^>]*class="social-btn youtube"[^>]*>).*?(</a>)', "`$1`n          <i class=`"fa-brands fa-youtube`"></i>`n        `$2")

        # Inject the <i class="fa-brands fa-tiktok"></i> tag inside the tiktok anchor
        $content = [Regex]::Replace($content, '(?s)(<a[^>]*class="social-btn tiktok"[^>]*>).*?(</a>)', "`$1`n          <i class=`"fa-brands fa-tiktok`"></i>`n        `$2")

        $utf8NoBom = New-Object System.Text.UTF8Encoding $false
        [System.IO.File]::WriteAllText($path, $content, $utf8NoBom)
        Write-Host "Patched $path"
    }
}
