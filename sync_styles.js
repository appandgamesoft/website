const fs = require('fs');

const rootHtml = fs.readFileSync('index.html', 'utf-8');
const styleMatch = rootHtml.match(/(<script>\s*\/\*\s*───[\s\S]*?Tailwind[\s\S]*?)<\/style>/);
if (!styleMatch) {
    console.error('Style block not found in root index.html');
    process.exit(1);
}
const styleBlock = styleMatch[1] + '</style>';

['de', 'es'].forEach(lang => {
    let content = fs.readFileSync(`${lang}/index.html`, 'utf-8');
    
    // Replace style block
    content = content.replace(/(<script>\s*\/\*\s*───[\s\S]*?Tailwind[\s\S]*?)<\/style>/, styleBlock);
    
    // Fix dropdown links
    // The requirement: "use `./index.html` for the current folder and `../` to go back to the root"
    // Also "preventing the 'Index of' directory listing"
    
    // For English:
    content = content.replace(/href="\.\.\/en\/index\.html"/g, 'href="../en/index.html"'); // actually this is correct
    // For Russian (Root):
    content = content.replace(/href="\.\.\/index\.html"/g, 'href="../index.html"'); 
    
    // Fix missing index.html in links:
    content = content.replace(/href="\.\.\/de\/"/g, 'href="../de/index.html"');
    content = content.replace(/href="\.\.\/es\/"/g, 'href="../es/index.html"');
    content = content.replace(/href="\.\.\/fr\/"/g, 'href="../fr/index.html"');
    content = content.replace(/href="\.\.\/hi\/"/g, 'href="../hi/index.html"');
    content = content.replace(/href="\.\.\/ja\/"/g, 'href="../ja/index.html"');
    content = content.replace(/href="\.\.\/ko\/"/g, 'href="../ko/index.html"');
    content = content.replace(/href="\.\.\/pt\/"/g, 'href="../pt/index.html"');
    content = content.replace(/href="\.\.\/zh\/"/g, 'href="../zh/index.html"');
    
    // Finally, for the current language, change `../${lang}/index.html` to `./index.html`
    const currentLangRegex = new RegExp(`href="\\.\\.\\/${lang}\\/index\\.html"`, 'g');
    content = content.replace(currentLangRegex, 'href="./index.html"');
    
    // Also change `href="#" class="active"` to be self referencing correctly if it was
    // Oh wait, for active it already has `href="#"`. The user wants `./index.html` for the current folder!
    // So if the active item has `href="#"`, we change it to `href="./index.html"`
    content = content.replace(/href="#"(\s+onclick="localStorage.setItem\('pref-lang','(de|es)'\)")(\s*class="active")/g, 'href="./index.html"$1$3');

    fs.writeFileSync(`${lang}/index.html`, content, 'utf-8');
    console.log(`Updated ${lang}/index.html`);
});
