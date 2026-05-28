$modalPrivacyTemplate = @"
  <div
    id="modal-privacy"
    class="modal-overlay"
    role="dialog"
    aria-modal="true"
    aria-labelledby="privacy-title"
    tabindex="-1"
  >
    <div class="modal-box">
      <div class="flex items-center justify-between mb-6">
        <h2 id="privacy-title" class="modal-h1">
          <i class="fa-solid fa-shield-halved mr-2" style="color:#a78bfa;"></i>
          {0}
        </h2>
        <button
          class="modal-close"
          onclick="closeModal('modal-privacy')"
          aria-label="{1}"
          id="close-privacy-btn"
        >
          <i class="fa-solid fa-xmark"></i>
        </button>
      </div>
    </div>
  </div>
"@

$modalTosTemplate = @"
  <div
    id="modal-tos"
    class="modal-overlay"
    role="dialog"
    aria-modal="true"
    aria-labelledby="tos-title"
    tabindex="-1"
  >
    <div class="modal-box">
      <div class="flex items-center justify-between mb-6">
        <h2 id="tos-title" class="modal-h1">
          <i class="fa-solid fa-file-contract mr-2" style="color:#a78bfa;"></i>
          {0}
        </h2>
        <button
          class="modal-close"
          onclick="closeModal('modal-tos')"
          aria-label="{1}"
          id="close-tos-btn"
        >
          <i class="fa-solid fa-xmark"></i>
        </button>
      </div>
    </div>
  </div>
"@

function Sync-Modals {
    param($file, $pTitle, $pAria, $tTitle, $tAria)
    $content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)
    
    $newPriv = $modalPrivacyTemplate -f $pTitle, $pAria
    $newTos = $modalTosTemplate -f $tTitle, $tAria
    
    $content = [regex]::Replace($content, '(?s)<div[^>]*id="modal-privacy".*?</div>\s*</div>\s*</div>|<div[^>]*id="privacy-modal".*?</div>\s*</div>\s*</div>', $newPriv)
    $content = [regex]::Replace($content, '(?s)<div[^>]*id="modal-tos".*?</div>\s*</div>\s*</div>|<div[^>]*id="tos-modal".*?</div>\s*</div>\s*</div>', $newTos)
    
    $utf8NoBom = New-Object System.Text.UTF8Encoding $false
    [System.IO.File]::WriteAllText($file, $content, $utf8NoBom)
    Write-Host "Synced modals in $file"
}

$es_pTitle = "Política de Privacidad"
$es_pAria = "Cerrar política de privacidad"
$es_tTitle = "Términos de Servicio"
$es_tAria = "Cerrar términos de servicio"
Sync-Modals "es/index.html" $es_pTitle $es_pAria $es_tTitle $es_tAria
