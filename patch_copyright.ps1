$files = @(
  'index.html',
  'en\index.html',
  'de\index.html',
  'es\index.html',
  'fr\index.html',
  'hi\index.html',
  'ja\index.html',
  'ko\index.html',
  'pt\index.html',
  'zh\index.html'
)

# Build the copyright string with a real © symbol (U+00A9)
$copyrightSymbol = [char]0x00A9
$newCopyright = "        $copyrightSymbol 2026 ReCode. All rights reserved."

foreach ($f in $files) {
  $bytes = [System.IO.File]::ReadAllBytes($f)
  $hasBom = ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF)
  if ($hasBom) {
    $enc = New-Object System.Text.UTF8Encoding $true
  } else {
    $enc = New-Object System.Text.UTF8Encoding $false
  }
  $content = $enc.GetString($bytes)

  $pattern = '(?<=<p style="text-align:center; font-size:0\.75rem; color:var\(--text-muted\); opacity:0\.6;">)[^<]+(?=</p>)'
  $replacement = "`n$newCopyright`n      "

  $newContent = [regex]::Replace($content, $pattern, $replacement)

  if ($newContent -eq $content) {
    Write-Host "WARNING: No change in $f"
  } else {
    [System.IO.File]::WriteAllText($f, $newContent, $enc)
    Write-Host "Updated: $f"
  }
}
