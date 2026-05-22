
# Geração de Sites

_2026/05/18_

Eu percebi que existem muitos projetos por aí para geração de sites estáticos.
A ideia é bem simples, você escreve uns arquivos markdown, um programa gera uns arquivos html, você sobe num host tipo github pages, e segue com a sua vida.
São úteis para documentação ou páginas pessoais, e acabei precisando de um para o meu [TCC](https://cosineblast.github.io/learn-it-up), que se expandiu para
a minha página pessoal de publicações.

Já tentei usar Hugo ou Jekyll no passado, mas tive umas dores de cabeça com temas e versionamento.
Uns tempos atrás, eu vi várias publicações no [lobste.rs](https://lobste.rs) sobre pessoas montando os seus própios geradores de sites,
então resolvi entrar na onda e fazer o mesmo. É bem divertido, e dependendo do que você precisa, pode ser bem simples!

Eu resolvi fazer um scriptzinho de shell em ruby (que é uma ótima linguagem para [substituir bash](https://lucasoshiro.github.io/posts/2024-06-17-ruby-shellscript/) em scripts),
que lê os arquivos markdown, os transforma em trechos de HTML usando `pandoc`, e insere esse corpo um arquivo `template.html` com uma substituição de string.

Eu não preciso de RSS ou tradução, então isso serve bem para mim por enquanto.

A única parte chatinha do processo foi definir o caminho base para links entre as páginas, já que se você estiver hosteando seu site em "https://seu-website/projeto",
(por exemplo, num repositório do github pages), então para colocar um anchor (`<a>`) para outra página "/abc.html", vc precisa trocar "/abc.html" por "/projeto/abc.html".
O pandoc não possui nenhuma flag para especificar isso, mas é possível fazer isso com um pequeno filtro do `pandoc` em lua. 

Em geral, foi bem divertido, e planejo continuar usar esse método para expandir esse site.
Para outras pessoas que querem fazer suas páginas pessoais e possuem experiência em programação, recomendo fazer o mesmo:
Escolher a sua linguagem de programação de preferência, e montar um scriptzinho para converter o conteúdo de markdown para HTML, de acordo com suas necessidades.

- [Script original](https://gist.github.com/cosineblast/c87ca470f66f935a117e96d54218b8d2)
- [Filtro do pandoc para substituir / pelo webroot](https://gist.github.com/cosineblast/7ced4408a45b95babfcad3a4d3e29267)
- [Script atual](https://github.com/cosineblast/cosineblast.github.io/blob/main/gen.rb)

