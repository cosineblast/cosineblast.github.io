
# Geração de Sites

_2026/05/18_

Eu percebi que existem muitos projetos por aí para geração de sites estáticos.
A ideia é bem simples, vc dá uns arquivos markdown, um programa gera uns arquivos html, vc bota num host tipo github pages, e segue com a sua vida.

São úteis para documentação ou páginas pessoais, e acabei precisando de um para o meu [TCC](https://cosineblast.github.io/learn-it-up).

Já tentei usar Hugo ou Jekyll no passado, mas tive umas dores de cabeça com temas e versionamento.
Uns tempos atrás, eu vi várias publicações no [lobste.rs](https://lobste.rs) sobre pessoas montando os seus própios geradores de sites,
então resolvi entrar na onda e fazer o mesmo.

É bem divertido, e dependendo do que você precisa, pode ser bem simples!

Eu resolvi fazer um scriptzinho de shell em ruby (que é uma ótima linguagem para [substituir bash](https://lucasoshiro.github.io/posts/2024-06-17-ruby-shellscript/) em scripts),
que lê os arquivos markdown, transforma em um trecho de HTML usando `pandoc`, e substituti esse corpo um arquivo `template.html` com uma substituição de string
direta.

Eu não preciso de RSS ou tradução, então isso serve bem para mim por enquanto.

A única parte chatinha do processo todo foi definir o caminho base para links entre as páginas, já que se vc estiver hosteando o do seu site em "https://seu-website/blog",
(por exemplo, num repositório do github pages), então para colocar um anchor (`<a>`) para outra página "/abc.html", vc precisa trocar "/abc.html" por "/blog/abc.html".

Para isso, tive que usar um filtro do `pandoc` em lua. 

Foi bem divertido, planjo usar isso para outros sites pessoais, ou para expandir os que já tenho.

Recomendo fazer o mesmo para outras pessoas, usando a sua linguagem de programação de preferência.

## Scripts

Script de geração em Ruby:

```ruby
#!/bin/ruby

# settings

if ENV['WEBROOT'] == nil then
  ENV['WEBROOT'] = ''
end

WEBROOT = ENV['WEBROOT']

# execution

`mkdir -p build`
`cp *.pdf *.jpg *.png *.css build`

source_files = `ls *.md`.split("\n")

template = `cat template.html`.gsub '$WEBROOT', WEBROOT

for source_file in source_files do

  basename = File.basename(source_file, File.extname(source_file))
  body_file = "build/#{basename}.body.html"
  target_file = "build/#{basename}.html"

  `pandoc --lua-filter="filter.lua" #{source_file} -o "#{body_file}"`

  result = template.gsub '$STUFF', `cat "#{body_file}"`

  File.write(target_file, result)
end
```

Filtro do pandoc em lua:

```lua
-- https://github.com/jgm/pandoc/issues/4894

function Image (img)
  if img.src:sub(1,1) == '/' then
    img.src = os.getenv 'WEBROOT' .. img.src
  end
  return img
end

function Link (link)
  if link.target:sub(1,1) == '/' then
    link.target = os.getenv 'WEBROOT' .. link.target
  end
  return link
end
```
