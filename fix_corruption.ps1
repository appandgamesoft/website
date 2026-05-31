$htmlFiles = Get-ChildItem -Path C:\Users\Timoz\WebProjects\website -Recurse -Filter "*.html"
$regex = '(?s)/\*\s+[^\w]+?10\. ANTI-SPAM EMAIL OBFUSCATION[^\w]+?\*/'
$line = new-object string([char]0x2500, 46)
$correct = "/* " + $line + "`r`n       10. ANTI-SPAM EMAIL OBFUSCATION`r`n    " + $line + " */"

foreach ($file in $htmlFiles) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    if ($content -match $regex) {
        $content = $content -replace $regex, $correct
        $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
        [System.IO.File]::WriteAllText($file.FullName, $content, $utf8NoBom)
        Write-Host "Fixed $($file.FullName)"
    }
}
