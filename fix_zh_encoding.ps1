$content = [System.IO.File]::ReadAllText('c:\Users\Timoz\WebProjects\MyWebsite\index.html', [System.Text.Encoding]::UTF8)
$lines = $content -split "`n"
$i = 0
$found = 0
foreach ($l in $lines) {
    $i++
    # Look for comment-style divider lines (CSS /* */ blocks and HTML <!-- --> blocks)
    if ($l -match '/\*\s*[^\x00-\x7F]{2,}' -or $l -match '<!--\s*[^\x00-\x7F]{2,}') {
        Write-Host "L${i}: $l"
        $found++
        if ($found -ge 20) { break }
    }
}
if ($found -eq 0) { Write-Host "No mojibake comment lines found in root index.html" }
