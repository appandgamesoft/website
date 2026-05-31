$htmlFiles = Get-ChildItem -Path C:\Users\Timoz\WebProjects\website -Recurse -Filter "*.html"
$line = new-object string([char]0x2500, 46)

$regex = '(?m)^(\s*\}\)\(\);)\r?\n(\s*/\* ' + $line + '\r?\n\s+10\. ANTI-SPAM EMAIL OBFUSCATION)'
$repl = "`$1`r`n`r`n`$2"

foreach ($file in $htmlFiles) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    if ($content -match $regex) {
        $content = $content -replace $regex, $repl
        $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
        [System.IO.File]::WriteAllText($file.FullName, $content, $utf8NoBom)
        Write-Host "Fixed $($file.FullName)"
    }
}
