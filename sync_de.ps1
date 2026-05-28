$rootContent = [System.IO.File]::ReadAllText("index.html", [System.Text.Encoding]::UTF8)

# Extract root Contact
if ($rootContent -match '(?s)(<section id="contact"[^>]*>).*?(<div class="max-w-2xl mx-auto text-center">).*?(<p class="section-label reveal">).*?(</p>).*?(<h2 id="contact-heading" class="section-title mb-6 reveal reveal-delay-1">).*?(</h2>).*?(<p class="section-desc mx-auto mb-10 reveal reveal-delay-2">).*?(</p>).*?(<a href="mailto:appandgamesoft@gmail.com" class="btn-primary" id="contact-email-btn" aria-label=").*?(">).*?(<i class="fa-solid fa-envelope text-sm"></i>).*?(</a>).*?(</section>)') {
    # Not using regex to assemble, because it's too complex.
}

# Better approach: Just manually build the exact template string from root index.html
$contactTemplate = @"
    <section id="contact" aria-labelledby="contact-heading" class="py-24 px-5">
      <div class="max-w-2xl mx-auto text-center">
        <p class="section-label reveal">{0}</p>
        <h2 id="contact-heading" class="section-title mb-6 reveal reveal-delay-1">
          {1}
        </h2>
        <p class="section-desc mx-auto mb-10 reveal reveal-delay-2">
          {2}
        </p>
        <!-- Email — primary action -->
        <div class="flex flex-wrap items-center gap-3 justify-center reveal reveal-delay-3">
          <a href="mailto:recode.architect@gmail.com" class="btn-primary" id="contact-email-btn" aria-label="{3}">
            <i class="fa-solid fa-envelope text-sm"></i> {4}
          </a>
        </div>
      </div>
    </section>
"@

$footerTemplate = @"
    <footer id="footer" role="contentinfo">
      <div class="max-w-6xl mx-auto px-5 py-12">
        <!-- Social buttons + documents — centered -->
        <div class="flex flex-col items-center gap-6">
          <div class="flex items-center gap-3" role="list" aria-label="{0}">
            <a href="https://www.youtube.com/@ReCode-Architect" class="social-btn youtube" role="listitem" aria-label="{1}" title="YouTube" id="footer-youtube" target="_blank" rel="noopener noreferrer">
              <i class="fa-brands fa-youtube"></i>
            </a>
            <a href="https://www.tiktok.com/@recode.architect" class="social-btn tiktok" role="listitem" aria-label="{2}" title="TikTok" id="footer-tiktok" target="_blank" rel="noopener noreferrer">
              <i class="fa-brands fa-tiktok"></i>
            </a>
          </div>
          <div class="flex items-center gap-4 flex-wrap justify-center">
            <button class="footer-link" id="open-privacy-btn" onclick="openModal('modal-privacy')" aria-haspopup="dialog" aria-controls="modal-privacy">
              {3}
            </button>
            <span style="color:var(--border);">·</span>
            <button class="footer-link" id="open-tos-btn" onclick="openModal('modal-tos')" aria-haspopup="dialog" aria-controls="modal-tos">
              {4}
            </button>
          </div>
        </div>
        <div class="divider my-8"></div>
        <!-- Quote -->
        <div class="footer-text font-medium text-center">
          {5}
        </div>
      </div>
    </footer>
"@

function Sync-Locale {
    param($file, $cLabel, $cHead, $cDesc, $cAria, $cBtn, $fSoc, $fYt, $fTk, $fPriv, $fTos, $fQuote)
    
    $content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)
    
    # Replace contact
    $newContact = $contactTemplate -f $cLabel, $cHead, $cDesc, $cAria, $cBtn
    $content = [regex]::Replace($content, '(?s)<section id="contact".*?</section>', $newContact)
    
    # Replace footer
    $newFooter = $footerTemplate -f $fSoc, $fYt, $fTk, $fPriv, $fTos, $fQuote
    $content = [regex]::Replace($content, '(?s)<footer id="footer".*?</footer>', $newFooter)
    
    $utf8NoBom = New-Object System.Text.UTF8Encoding $false
    [System.IO.File]::WriteAllText($file, $content, $utf8NoBom)
    Write-Host "Synced $file"
}

# --- For DE ---
$de_cLabel = "Ping."
$de_cHead = "In Kontakt bleiben."
$de_cDesc = "E-Mail für Ihr Feedback, Fragen zur Architektur von MindHug oder einfach ein kurzes `"Hallo`". Ich suche keine Aufträge oder Partnerschaften, aber ich lese immer Nachrichten von echten Menschen."
$de_cAria = "E-Mail an den ReCode-Entwickler senden"
$de_cBtn = "E-Mail schreiben"

$de_fSoc = "Soziale Netzwerke"
$de_fYt = "YouTube-Kanal"
$de_fTk = "TikTok-Profil"
$de_fPriv = "Datenschutzrichtlinie"
$de_fTos = "Nutzungsbedingungen"
$de_fQuote = "Vibecoding ohne Kompromisse"

Sync-Locale "de/index.html" $de_cLabel $de_cHead $de_cDesc $de_cAria $de_cBtn $de_fSoc $de_fYt $de_fTk $de_fPriv $de_fTos $de_fQuote

