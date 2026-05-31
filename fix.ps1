$txt = Get-Content 'pt/index.html' -Raw -Encoding UTF8

$replacements = @{
  'â€”' = '—'
  'criaÃ§Ã£o' = 'criação'
  'publicaÃ§Ã£o' = 'publicação'
  'AplicaÃ§Ãµes' = 'Aplicações'
  'padrÃµes' = 'padrões'
  'anĂ¡lise' = 'análise'
  'Ă©' = 'é'
  'Ã§' = 'ç'
  'Ã£' = 'ã'
  'Ãµ' = 'õ'
  'Ă¡' = 'á'
  'Ă©' = 'é'
  'Ã©' = 'é'
  'Ă ' = 'à'
  'Ã³' = 'ó'
  'Ã ' = 'à'
  'Ã¢' = 'â'
  'Ãª' = 'ê'
  'Ã' = 'í' # Wait, 'í' in utf8->win1252 is Ã, usually Ã is a prefix.
}

$txt = $txt -replace 'â€”', '—'
$txt = $txt -replace 'criaÃ§Ã£o', 'criação'
$txt = $txt -replace 'publicaÃ§Ã£o', 'publicação'
$txt = $txt -replace 'AplicaÃ§Ãµes', 'Aplicações'
$txt = $txt -replace 'padrÃµes', 'padrões'
$txt = $txt -replace 'anĂ¡lise', 'análise'
$txt = $txt -replace 'Ă©', 'é'

# For others containing the broken sequences, we can replace the general broken utf8 sequences:
$txt = $txt -replace 'Ã§', 'ç'
$txt = $txt -replace 'Ã£', 'ã'
$txt = $txt -replace 'Ãµ', 'õ'
$txt = $txt -replace 'Ă¡', 'á'
$txt = $txt -replace 'Ã©', 'é'
$txt = $txt -replace 'Ă©', 'é'
$txt = $txt -replace 'Ã³', 'ó'
$txt = $txt -replace 'Ã¢', 'â'
$txt = $txt -replace 'Ãª', 'ê'
$txt = $txt -replace 'Ã', 'í' # Safe? Only after all other Ã sequences are replaced!

Set-Content 'pt/index.html' $txt -Encoding UTF8 -NoNewline
Write-Host "Done"
