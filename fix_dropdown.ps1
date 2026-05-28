# Extract exact dropdown from en/index.html
$enContent = [System.IO.File]::ReadAllText("en/index.html", [System.Text.Encoding]::UTF8)
$dropdownRegex = '(?s)(<div class="lang-dropdown" id="lang-dropdown"[^>]*>.*?</div>)'
if ($enContent -match $dropdownRegex) {
    $dropdown = $matches[1]
    
    # We will remove the active class from en
    $dropdownBase = $dropdown -replace 'href="./index.html"(.*?)class="active"([^>]*)', 'href="../en/index.html"$1$2'
    
    $locales = @{
        "de" = 'href="../de/index.html"';
        "es" = 'href="../es/index.html"';
        "fr" = 'href="../fr/index.html"';
        "hi" = 'href="../hi/index.html"';
        "ja" = 'href="../ja/index.html"';
        "ko" = 'href="../ko/index.html"';
        "pt" = 'href="../pt/index.html"';
        "zh" = 'href="../zh/index.html"'
    }
    
    foreach ($lang in $locales.Keys) {
        $path = "$lang/index.html"
        $fileContent = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)
        
        $hrefToReplace = $locales[$lang]
        
        # Replace the target href with ./index.html and add class="active"
        $langDropdown = $dropdownBase -replace [regex]::Escape($hrefToReplace), 'href="./index.html" class="active"'
        
        # Replace the whole dropdown block in the file
        $fileContent = [regex]::Replace($fileContent, '(?s)<div class="lang-dropdown" id="lang-dropdown"[^>]*>.*?</div>', $langDropdown.Replace('$', '$$'))
        
        # Write back
        $utf8NoBom = New-Object System.Text.UTF8Encoding $false
        [System.IO.File]::WriteAllText($path, $fileContent, $utf8NoBom)
        Write-Host "Fixed dropdown in $path"
    }
}
