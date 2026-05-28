$ptPath = "c:\Users\Timoz\WebProjects\MyWebsite\pt\index.html"
$html = [System.IO.File]::ReadAllText($ptPath, [System.Text.Encoding]::UTF8)

$html = [regex]::Replace($html, '(?s)<button class="lang-btn"[^>]*>.*?</button>', '<button class="lang-btn" id="lang-menu-btn" aria-haspopup="listbox" aria-expanded="false" aria-label="Seleção de idioma">
              🇧🇷 PT <i class="fa-solid fa-chevron-down lang-chevron"></i>
            </button>')

$html = [regex]::Replace($html, '(?s)<a href="\./index\.html"\s+onclick="localStorage\.setItem\(''pref-lang'',''en''\)"\s+class="active"\s+role="option">.*?</a>', '<a href="../en/index.html" onclick="localStorage.setItem(''pref-lang'',''en'')" role="option"><span class="lang-flag">🇬🇧</span> English</a>')

$html = [regex]::Replace($html, '(?s)<a href="\.\./pt/index\.html"\s+onclick="localStorage\.setItem\(''pref-lang'',''pt''\)"\s+role="option">.*?</a>', '<a href="./index.html"           onclick="localStorage.setItem(''pref-lang'',''pt'')" class="active" role="option"><span class="lang-flag">🇧🇷</span> Português</a>')

$html = [regex]::Replace($html, '(?s)<a href="\./index\.html"\s+onclick="localStorage\.setItem\(''pref-lang'',''en''\)"\s+class="active">.*?</a>', '<a href="../en/index.html" onclick="localStorage.setItem(''pref-lang'',''en'')"><span>🇬🇧</span> English</a>')

$html = [regex]::Replace($html, '(?s)<a href="\.\./pt/index\.html"\s+onclick="localStorage\.setItem\(''pref-lang'',''pt''\)">.*?</a>', '<a href="./index.html"           onclick="localStorage.setItem(''pref-lang'',''pt'')" class="active"><span>🇧🇷</span> Português</a>')

$utf8NoBom = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::WriteAllText($ptPath, $html, $utf8NoBom)
Write-Host "Done"
