#!/bin/ruby

# settings

if ENV['WEBROOT'] == nil then
  ENV['WEBROOT'] = ''
end

WEBROOT = ENV['WEBROOT']

# execution

`mkdir -p build`

assets = Dir.glob("content/**/*.{pdf,jpg,png}") + Dir.glob("*.css")

`cp #{assets.join " "} build`

source_files = Dir.glob("content/**/*.md")

template = File.read("template.html").gsub '$WEBROOT', WEBROOT

for source_file in source_files do

  basedir = File.dirname(source_file).delete_prefix "content"
  basename = File.basename(source_file, ".md")

  body_file = "build/#{basedir}/#{basename}.body.html"
  target_file = "build/#{basedir}/#{basename}.html"

  `mkdir -p build/#{basedir}`

  puts "Processing #{source_file}"

  `pandoc --lua-filter="filter.lua" #{source_file} -o "#{body_file}" --mathml`

  result = template.gsub '$STUFF', `cat "#{body_file}"`

  File.write(target_file, result)
end
