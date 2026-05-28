$enPath = "c:\Users\Timoz\WebProjects\MyWebsite\en\index.html"
$ptPath = "c:\Users\Timoz\WebProjects\MyWebsite\pt\index.html"

$html = [System.IO.File]::ReadAllText($enPath, [System.Text.Encoding]::UTF8)

$html = $html.Replace('<html lang="en"', '<html lang="pt"')

$html = [regex]::Replace($html, '<title>.*?</title>', '<title>ReCode — Desenvolvedor Mobile Independente</title>')
$html = [regex]::Replace($html, '<meta name="description" content=".*?" />', '<meta name="description" content="ReCode — desenvolvedor independente de aplicativos móveis. Especializado em vibecoding: criação de aplicativos de alta qualidade para App Store e Google Play." />')
$html = [regex]::Replace($html, '<meta name="keywords" content=".*?" />', '<meta name="keywords" content="ReCode, vibecoding, aplicativos móveis, KMP, Kotlin Multiplatform, Compose Multiplatform, MindHug" />')

$html = [regex]::Replace($html, '<meta property="og:title" content=".*?" />', '<meta property="og:title" content="ReCode — Desenvolvedor Mobile Independente" />')
$html = [regex]::Replace($html, '<meta property="og:description" content=".*?" />', '<meta property="og:description" content="Vibecoding: criação e publicação de aplicativos de alta qualidade nas maiores lojas do mundo." />')
$html = [regex]::Replace($html, '<meta property="og:locale" content=".*?" />', '<meta property="og:locale" content="pt_BR" />')

$html = $html.Replace('aria-label="Main navigation"', 'aria-label="Navegação principal"')
$html = $html.Replace('aria-label="ReCode — home page"', 'aria-label="ReCode — página inicial"')
$html = $html.Replace('id="nav-about">Manifest<', 'id="nav-about">Manifesto<')
$html = $html.Replace('id="nav-projects">Projects<', 'id="nav-projects">Projetos<')
$html = $html.Replace('id="nav-contact">Contact<', 'id="nav-contact">Contato<')

$html = $html.Replace('aria-label="Language selection"', 'aria-label="Seleção de idioma"')
$html = $html.Replace('🇬🇧 EN', '🇧🇷 PT')

$html = $html.Replace('<a href="./index.html" onclick="localStorage.setItem(''pref-lang'',''en'')" class="active" role="option"><span class="lang-flag">🇬🇧</span> English</a>', '<a href="../en/index.html" onclick="localStorage.setItem(''pref-lang'',''en'')" role="option"><span class="lang-flag">🇬🇧</span> English</a>')
$html = $html.Replace('<a href="../pt/index.html"           onclick="localStorage.setItem(''pref-lang'',''pt'')" role="option"><span class="lang-flag">🇧🇷</span> Português</a>', '<a href="./index.html"           onclick="localStorage.setItem(''pref-lang'',''pt'')" class="active" role="option"><span class="lang-flag">🇧🇷</span> Português</a>')

$html = $html.Replace('<a href="./index.html" onclick="localStorage.setItem(''pref-lang'',''en'')" class="active"><span>🇬🇧</span> English</a>', '<a href="../en/index.html" onclick="localStorage.setItem(''pref-lang'',''en'')"><span>🇬🇧</span> English</a>')
$html = $html.Replace('<a href="../pt/index.html"           onclick="localStorage.setItem(''pref-lang'',''pt'')"><span>🇧🇷</span> Português</a>', '<a href="./index.html"           onclick="localStorage.setItem(''pref-lang'',''pt'')" class="active"><span>🇧🇷</span> Português</a>')

$html = $html.Replace('aria-label="Open menu"', 'aria-label="Abrir menu"')
$html = $html.Replace('aria-label="Mobile menu"', 'aria-label="Menu móvel"')
$html = $html.Replace('onclick="closeMobileMenu()">Manifest<', 'onclick="closeMobileMenu()">Manifesto<')
$html = $html.Replace('onclick="closeMobileMenu()">Projects<', 'onclick="closeMobileMenu()">Projetos<')
$html = $html.Replace('onclick="closeMobileMenu()">Contact<', 'onclick="closeMobileMenu()">Contato<')

$html = $html.Replace('Currently creating', 'Atualmente criando')
$html = $html.Replace('Vibecoding<br />unbound', 'Vibecoding<br />sem limites')
$html = $html.Replace('<strong>ReCode</strong> — independent developer.<br />
          Specializing in building and publishing', '<strong>ReCode</strong> — desenvolvedor independente.<br />
          Especializado na criação e publicação de')
$html = $html.Replace('const phrases = [
        ''products for global mobile marketplaces.'',
        ''architectural solutions on KMP.'',
        ''native mobile experiences.'',
      ];', 'const phrases = [
        ''produtos para mercados móveis globais.'',
        ''soluções arquiteturais em KMP.'',
        ''experiências móveis nativas.'',
      ];')
$html = $html.Replace('Explore MindHug', 'Explorar MindHug')
$html = $html.Replace('My vibe', 'Minha vibe')
$html = $html.Replace('aria-label="Technologies used"', 'aria-label="Tecnologias utilizadas"')

$html = $html.Replace('<p class="section-label reveal">Philosophy</p>', '<p class="section-label reveal">Filosofia</p>')
$html = $html.Replace('Code is&nbsp;<span class="gradient-text">art</span>', 'Código é&nbsp;<span class="gradient-text">arte</span>')
$html = $html.Replace('Vibecoding is not just development. It''s a flow state where technical decisions are born intuitively, and every app comes out as a coherent creative statement.', 'Vibecoding não é apenas desenvolvimento. É um estado de fluxo onde decisões técnicas nascem intuitivamente e cada aplicativo surge como uma declaração criativa coerente.')
$html = $html.Replace('Publishing products on global platforms is my way of sharing my vision and creating tools that I enjoy using every single day.', 'Publicar produtos em plataformas globais é minha forma de compartilhar minha visão e criar ferramentas que eu gosto de usar todos os dias.')

$html = $html.Replace('100% anonymous', '100% anônimo')
$html = $html.Replace('Zero data collection', 'Zero coleta de dados')
$html = $html.Replace('Mobile-First', 'Mobile-First')
$html = $html.Replace('Autonomous operation', 'Operação autônoma')

$html = $html.Replace('Project in portfolio', 'Projeto no portfólio')
$html = $html.Replace('Creative potential', 'Potencial criativo')

$html = $html.Replace('Clean multiplatform architecture', 'Arquitetura multiplataforma limpa')
$html = $html.Replace('Kotlin Multiplatform as a foundation', 'Kotlin Multiplatform base')
$html = $html.Replace('Kotlin Multiplatform base', 'Kotlin Multiplatform como base') # fix substring match issues
$html = $html.Replace('Native UX via Compose Multiplatform', 'UX nativo via Compose Multiplatform')
$html = $html.Replace('Full locality — your data never leaves your device', 'Localidade total — seus dados nunca saem do seu dispositivo')

$html = $html.Replace('<p class="section-label reveal">Portfolio</p>', '<p class="section-label reveal">Portfólio</p>')
$html = [regex]::Replace($html, '>\s*Projects\s*</h2>', '>
            Projetos
          </h2>')
$html = $html.Replace('My projects are a balance between reliable architecture and smooth interaction. Current focus — MindHug.', 'Meus projetos são um equilíbrio entre arquitetura confiável e interação fluida. Foco atual — MindHug.')

$html = $html.Replace('aria-label="Project MindHug"', 'aria-label="Projeto MindHug"')
$html = $html.Replace('aria-label="MindHug App Icon"', 'aria-label="Ícone do aplicativo MindHug"')
$html = $html.Replace('Flagship', 'Principal')
$html = $html.Replace('Comprehensive cross-platform solution on KMP', 'Solução multiplataforma abrangente em KMP')
$html = $html.Replace('MindHug is a mental health support app built from scratch on pure Kotlin Multiplatform. It embodies the principles of modern cross-platform development: unified business logic, native UI via Compose Multiplatform, and complete data locality without servers or analytics.', 'MindHug é um aplicativo de apoio à saúde mental construído do zero em Kotlin Multiplatform puro. Incorpora os princípios do desenvolvimento multiplataforma moderno: lógica de negócios unificada, UI nativa via Compose Multiplatform e localidade total de dados sem servidores ou análises.')

$html = $html.Replace('Tech Stack', 'Stack Tecnológico')
$html = $html.Replace('aria-label="MindHug Technologies"', 'aria-label="Tecnologias do MindHug"')

$html = $html.Replace('aria-label="Architectural approach"', 'aria-label="Abordagem arquitetural"')
$html = $html.Replace('Clean Architecture</h3>', 'Arquitetura Limpa</h3>')
$html = $html.Replace('Clean Architecture + MVI. Layer separation, testability, scalability.', 'Clean Architecture + MVI. Separação de camadas, testabilidade, escalabilidade.')

$html = $html.Replace('aria-label="Privacy philosophy"', 'aria-label="Filosofia de privacidade"')
$html = $html.Replace('Zero analytics. All data is stored locally. No servers, no trackers.', 'Zero análises. Todos os dados são armazenados localmente. Sem servidores, sem rastreadores.')

$html = $html.Replace('<p class="section-label reveal">Ping.</p>', '<p class="section-label reveal">Ping.</p>')
$html = $html.Replace('Get in touch.', 'Em contato.')
$html = $html.Replace('Email for your feedback, questions about MindHug''s architecture, or just a quick "hello". I am not looking for gigs or partnerships, but I always read messages from real people.', 'Email para seus comentários, perguntas sobre a arquitetura do MindHug ou apenas um olá rápido. Não procuro trabalhos ou parcerias, mas sempre leio mensagens de pessoas reais.')
$html = $html.Replace('aria-label="Email the ReCode developer"', 'aria-label="Enviar email ao desenvolvedor ReCode"')
$html = $html.Replace('Send an email', 'Enviar email')

$html = $html.Replace('aria-label="Social networks"', 'aria-label="Redes sociais"')
$html = $html.Replace('aria-label="YouTube channel"', 'aria-label="Canal do YouTube"')
$html = $html.Replace('aria-label="TikTok profile"', 'aria-label="Perfil do TikTok"')

$html = $html.Replace('Privacy Policy', 'Política de Privacidade')
$html = $html.Replace('Terms of Service', 'Termos de Serviço')
$html = $html.Replace('Vibecoding without compromises', 'Vibecoding sem compromissos')
$html = $html.Replace('© 2026 ReCode. Developed for the sake of creativity.', '© 2026 ReCode. Desenvolvido por amor à criatividade.')

$html = $html.Replace('aria-label="Close privacy policy"', 'aria-label="Fechar política de privacidade"')
$html = $html.Replace('aria-label="Close terms of service"', 'aria-label="Fechar termos de serviço"')

$utf8NoBom = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::WriteAllText($ptPath, $html, $utf8NoBom)
Write-Host "Done"
