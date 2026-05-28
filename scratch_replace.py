import os
import re

en_path = r'c:\Users\Timoz\WebProjects\MyWebsite\en\index.html'
pt_path = r'c:\Users\Timoz\WebProjects\MyWebsite\pt\index.html'

with open(en_path, 'r', encoding='utf-8') as f:
    html = f.read()

# Replace HTML lang
html = html.replace('<html lang="en"', '<html lang="pt"')

# Meta tags
html = re.sub(r'<title>.*?</title>', '<title>ReCode — Desenvolvedor Mobile Independente</title>', html)
html = re.sub(r'<meta name="description" content=".*?" />', '<meta name="description" content="ReCode — desenvolvedor independente de aplicativos móveis. Especializado em vibecoding: criação de aplicativos de alta qualidade para App Store e Google Play." />', html)
html = re.sub(r'<meta name="keywords" content=".*?" />', '<meta name="keywords" content="ReCode, vibecoding, aplicativos móveis, KMP, Kotlin Multiplatform, Compose Multiplatform, MindHug" />', html)

html = re.sub(r'<meta property="og:title" content=".*?" />', '<meta property="og:title" content="ReCode — Desenvolvedor Mobile Independente" />', html)
html = re.sub(r'<meta property="og:description" content=".*?" />', '<meta property="og:description" content="Vibecoding: criação e publicação de aplicativos de alta qualidade nas maiores lojas do mundo." />', html)
html = re.sub(r'<meta property="og:locale" content=".*?" />', '<meta property="og:locale" content="pt_BR" />', html)

# Nav links
html = html.replace('aria-label="Main navigation"', 'aria-label="Navegação principal"')
html = html.replace('aria-label="ReCode — home page"', 'aria-label="ReCode — página inicial"')
html = html.replace('id="nav-about">Manifest<', 'id="nav-about">Manifesto<')
html = html.replace('id="nav-projects">Projects<', 'id="nav-projects">Projetos<')
html = html.replace('id="nav-contact">Contact<', 'id="nav-contact">Contato<')

# Lang button and dropdown
html = html.replace('aria-label="Language selection"', 'aria-label="Seleção de idioma"')
html = html.replace('🇬🇧 EN', '🇧🇷 PT')

# Language dropdown logic
# Replace hrefs
html = html.replace('<a href="./index.html" onclick="localStorage.setItem(\'pref-lang\',\'en\')" class="active"', '<a href="../en/index.html" onclick="localStorage.setItem(\'pref-lang\',\'en\')"')
html = html.replace('<a href="../pt/index.html"           onclick="localStorage.setItem(\'pref-lang\',\'pt\')" role="option"', '<a href="./index.html"           onclick="localStorage.setItem(\'pref-lang\',\'pt\')" class="active" role="option"')

# Mobile grid logic
html = html.replace('<a href="./index.html" onclick="localStorage.setItem(\'pref-lang\',\'en\')" class="active"><span>🇬🇧</span> English</a>', '<a href="../en/index.html" onclick="localStorage.setItem(\'pref-lang\',\'en\')"><span>🇬🇧</span> English</a>')
html = html.replace('<a href="../pt/index.html"           onclick="localStorage.setItem(\'pref-lang\',\'pt\')"><span>🇧🇷</span> Português</a>', '<a href="./index.html"           onclick="localStorage.setItem(\'pref-lang\',\'pt\')" class="active"><span>🇧🇷</span> Português</a>')

# Mobile hamburger
html = html.replace('aria-label="Open menu"', 'aria-label="Abrir menu"')
html = html.replace('aria-label="Mobile menu"', 'aria-label="Menu móvel"')
html = html.replace('onclick="closeMobileMenu()">Manifest<', 'onclick="closeMobileMenu()">Manifesto<')
html = html.replace('onclick="closeMobileMenu()">Projects<', 'onclick="closeMobileMenu()">Projetos<')
html = html.replace('onclick="closeMobileMenu()">Contact<', 'onclick="closeMobileMenu()">Contato<')

# Hero section
html = html.replace('Currently creating', 'Atualmente criando')
html = html.replace('Vibecoding<br />unbound', 'Vibecoding<br />sem limites')
html = html.replace('<strong>ReCode</strong> — independent developer.<br />\n          Specializing in building and publishing', '<strong>ReCode</strong> — desenvolvedor independente.<br />\n          Especializado na criação e publicação de')
html = html.replace("const phrases = [\n        'products for global mobile marketplaces.',\n        'architectural solutions on KMP.',\n        'native mobile experiences.',\n      ];", "const phrases = [\n        'produtos para mercados móveis globais.',\n        'soluções arquiteturais em KMP.',\n        'experiências móveis nativas.',\n      ];")
html = html.replace('Explore MindHug', 'Explorar MindHug')
html = html.replace('My vibe', 'Minha vibe')
html = html.replace('aria-label="Technologies used"', 'aria-label="Tecnologias utilizadas"')

# About section
html = html.replace('<p class="section-label reveal">Philosophy</p>', '<p class="section-label reveal">Filosofia</p>')
html = html.replace('Code is&nbsp;<span class="gradient-text">art</span>', 'Código é&nbsp;<span class="gradient-text">arte</span>')
html = html.replace('Vibecoding is not just development. It\'s a flow state where technical decisions are born intuitively, and every app comes out as a coherent creative statement.', 'Vibecoding não é apenas desenvolvimento. É um estado de fluxo onde decisões técnicas nascem intuitivamente e cada aplicativo surge como uma declaração criativa coerente.')
html = html.replace('Publishing products on global platforms is my way of sharing my vision and creating tools that I enjoy using every single day.', 'Publicar produtos em plataformas globais é minha forma de compartilhar minha visão e criar ferramentas que eu gosto de usar todos os dias.')

html = html.replace('100% anonymous', '100% anônimo')
html = html.replace('Zero data collection', 'Zero coleta de dados')
html = html.replace('Mobile-First', 'Mobile-First')
html = html.replace('Autonomous operation', 'Operação autônoma')

html = html.replace('Project in portfolio', 'Projeto no portfólio')
html = html.replace('Creative potential', 'Potencial criativo')

html = html.replace('Clean multiplatform architecture', 'Arquitetura multiplataforma limpa')
html = html.replace('Kotlin Multiplatform as a foundation', 'Kotlin Multiplatform como base')
html = html.replace('Native UX via Compose Multiplatform', 'UX nativo via Compose Multiplatform')
html = html.replace('Full locality — your data never leaves your device', 'Localidade total — seus dados nunca saem do seu dispositivo')

# Projects section
html = html.replace('<p class="section-label reveal">Portfolio</p>', '<p class="section-label reveal">Portfólio</p>')
html = html.replace('<h2 id="projects-heading" class="section-title mb-4 reveal reveal-delay-1">\n            Projects\n          </h2>', '<h2 id="projects-heading" class="section-title mb-4 reveal reveal-delay-1">\n            Projetos\n          </h2>')
html = html.replace('My projects are a balance between reliable architecture and smooth interaction. Current focus — MindHug.', 'Meus projetos são um equilíbrio entre arquitetura confiável e interação fluida. Foco atual — MindHug.')

html = html.replace('aria-label="Project MindHug"', 'aria-label="Projeto MindHug"')
html = html.replace('aria-label="MindHug App Icon"', 'aria-label="Ícone do aplicativo MindHug"')
html = html.replace('Flagship', 'Principal')
html = html.replace('Comprehensive cross-platform solution on KMP', 'Solução multiplataforma abrangente em KMP')
html = html.replace('MindHug is a mental health support app built from scratch on pure Kotlin Multiplatform. It embodies the principles of modern cross-platform development: unified business logic, native UI via Compose Multiplatform, and complete data locality without servers or analytics.', 'MindHug é um aplicativo de apoio à saúde mental construído do zero em Kotlin Multiplatform puro. Incorpora os princípios do desenvolvimento multiplataforma moderno: lógica de negócios unificada, UI nativa via Compose Multiplatform e localidade total de dados sem servidores ou análises.')

html = html.replace('Tech Stack', 'Stack Tecnológico')
html = html.replace('aria-label="MindHug Technologies"', 'aria-label="Tecnologias do MindHug"')

html = html.replace('aria-label="Architectural approach"', 'aria-label="Abordagem arquitetural"')
html = html.replace('Clean Architecture</h3>', 'Arquitetura Limpa</h3>')
html = html.replace('Clean Architecture + MVI. Layer separation, testability, scalability.', 'Clean Architecture + MVI. Separação de camadas, testabilidade, escalabilidade.')

html = html.replace('aria-label="Privacy philosophy"', 'aria-label="Filosofia de privacidade"')
html = html.replace('Zero analytics. All data is stored locally. No servers, no trackers.', 'Zero análises. Todos os dados são armazenados localmente. Sem servidores, sem rastreadores.')

# Contact section
html = html.replace('<p class="section-label reveal">Ping.</p>', '<p class="section-label reveal">Ping.</p>')
html = html.replace('Get in touch.', 'Em contato.')
html = html.replace('Email for your feedback, questions about MindHug\'s architecture, or just a quick "hello". I am not looking for gigs or partnerships, but I always read messages from real people.', 'Email para seus comentários, perguntas sobre a arquitetura do MindHug ou apenas um olá rápido. Não procuro trabalhos ou parcerias, mas sempre leio mensagens de pessoas reais.')
html = html.replace('aria-label="Email the ReCode developer"', 'aria-label="Enviar email ao desenvolvedor ReCode"')
html = html.replace('Send an email', 'Enviar email')

# Footer section
html = html.replace('aria-label="Social networks"', 'aria-label="Redes sociais"')
html = html.replace('aria-label="YouTube channel"', 'aria-label="Canal do YouTube"')
html = html.replace('aria-label="TikTok profile"', 'aria-label="Perfil do TikTok"')

html = html.replace('Privacy Policy', 'Política de Privacidade')
html = html.replace('Terms of Service', 'Termos de Serviço')
html = html.replace('Vibecoding without compromises', 'Vibecoding sem compromissos')
html = html.replace('© 2026 ReCode. Developed for the sake of creativity.', '© 2026 ReCode. Desenvolvido por amor à criatividade.')

# Modals
html = html.replace('aria-label="Close privacy policy"', 'aria-label="Fechar política de privacidade"')
html = html.replace('aria-label="Close terms of service"', 'aria-label="Fechar termos de serviço"')

with open(pt_path, 'w', encoding='utf-8') as f:
    f.write(html)

print("Done")
