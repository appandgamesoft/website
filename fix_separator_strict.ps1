$files = Get-ChildItem -Filter "index.html" -Recurse
foreach ($f in $files) {
    $content = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)
    
    # We will use Regex to explicitly target the span between the two buttons in the footer
    $pattern = '(?s)(<div class="flex items-center gap-4 flex-wrap justify-center">\s*<button.*?</button>\s*)<span[^>]*>.*?</span>(\s*<button)'
    $replacement = '$1<span style="color:var(--border);">·</span>$2'
    
    $newContent = [regex]::Replace($content, $pattern, $replacement)
    
    if ($content -ne $newContent) {
        $utf8NoBom = New-Object System.Text.UTF8Encoding $false
        [System.IO.File]::WriteAllText($f.FullName, $newContent, $utf8NoBom)
        Write-Host "Fixed separator strictly in $($f.FullName)"
    } else {
        Write-Host "No match found in $($f.FullName)"
    }
}
