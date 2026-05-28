$root = [System.IO.File]::ReadAllText("index.html", [System.Text.Encoding]::UTF8)
if ($root -match '(?s)(<script src="https://cdn\.tailwindcss\.com"></script>.*?</style>)') {
    $styleBlock = $matches[1]
    
    $targets = @("de", "en", "es", "fr", "hi", "ja", "ko", "pt", "zh")
    foreach ($lang in $targets) {
        $path = "$lang/index.html"
        $content = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)
        $content = [regex]::Replace($content, '(?s)<script src="https://cdn\.tailwindcss\.com"></script>.*?</style>', $styleBlock.Replace('$', '$$'))
        
        $utf8NoBom = New-Object System.Text.UTF8Encoding $false
        [System.IO.File]::WriteAllText($path, $content, $utf8NoBom)
        Write-Host "Synced styles for $path"
    }
} else {
    Write-Host "Could not find style block in root"
}
