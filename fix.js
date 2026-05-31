const fs = require('fs');
let txt = fs.readFileSync('pt/index.html', 'utf8');

const replacements = {
  'â€”': '—',
  'criaÃ§Ã£o': 'criação',
  'publicaÃ§Ã£o': 'publicação',
  'AplicaÃ§Ãµes': 'Aplicações',
  'padrÃµes': 'padrões',
  'anĂ¡lise': 'análise',
  'Ă©': 'é',
  'aplicaÃ§Ãµes': 'aplicações',
  'nÃ£o': 'não',
  'sÃ£o': 'são',
  'visÃ£o': 'visão',
  'declaraÃ§Ã£o': 'declaração',
  'NÃ£o': 'Não',
  'decisÃµes': 'decisões',
  'separaÃ§Ã£o': 'separação',
  'operaÃ§Ã£o': 'operação',
  'seleÃ§Ã£o': 'seleção',
  'navegaÃ§Ã£o': 'navegação'
};

for (const [bad, good] of Object.entries(replacements)) {
  txt = txt.split(bad).join(good);
}

// Find any other instances of strange characters:
// 'Ã', 'Ă', 'µ', '§', '£', 'â'
const regex = /\b\w*[ÃĂµ§£â]\w*\b/g;
let match;
while ((match = regex.exec(txt)) !== null) {
  console.log('Found unhandled:', match[0]);
}

fs.writeFileSync('pt/index.html', txt, 'utf8');
console.log('Done replacements.');
