$files = Get-ChildItem -Filter "index.html" -Recurse
foreach ($f in $files) {
    $content = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)
    
    # Replace the corrupted separator (with or without corrupted chars around it) with exact HTML
    # We replace any span style color var(--border) completely to ensure correctness
    $content = [regex]::Replace($content, '<span style="color:var\(--border\);">[^<]+</span>', '<span style="color:var(--border);">·</span>')
    
    $utf8NoBom = New-Object System.Text.UTF8Encoding $false
    [System.IO.File]::WriteAllText($f.FullName, $content, $utf8NoBom)
    Write-Host "Fixed separator in $($f.FullName)"
}
