$files = Get-ChildItem -Filter "index.html" -Recurse
foreach ($f in $files) {
    $content = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)
    
    # We construct the exact replacement string using the unicode character point 0x00B7
    $dot = [char]0x00B7
    $replacement = '<span style="color:var(--border);">' + $dot + '</span>'
    
    # Replace the corrupted span
    $newContent = [regex]::Replace($content, '<span style="color:var\(--border\);">[^<]+</span>', $replacement)
    
    if ($content -ne $newContent) {
        $utf8NoBom = New-Object System.Text.UTF8Encoding $false
        [System.IO.File]::WriteAllText($f.FullName, $newContent, $utf8NoBom)
        Write-Host "Fixed separator properly in $($f.FullName)"
    } else {
        Write-Host "No match found in $($f.FullName)"
    }
}
