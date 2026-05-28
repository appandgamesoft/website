$files = Get-ChildItem -Filter "index.html" -Recurse
foreach ($f in $files) {
    $content = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)
    
    # We target the span that comes right after the privacy button
    $pattern = '(?s)(openModal\(''modal-privacy''\).*?</button>\s*)<span style="color:var\(--border\);">.*?</span>'
    $replacement = '$1<span style="color:var(--border);">·</span>'
    
    $newContent = [regex]::Replace($content, $pattern, $replacement)
    
    if ($content -ne $newContent) {
        $utf8NoBom = New-Object System.Text.UTF8Encoding $false
        [System.IO.File]::WriteAllText($f.FullName, $newContent, $utf8NoBom)
        Write-Host "Fixed separator strictly in $($f.FullName)"
    } else {
        Write-Host "No match found in $($f.FullName)"
    }
}
