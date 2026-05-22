#!/bin/ruby

# settings

# The lua filter grabs the webroot from the WEBROOT environment variable.

if ENV['WEBROOT'] == nil then
  ENV['WEBROOT'] = ''
end

WEBROOT = ENV['WEBROOT']

# copy assets

`mkdir -p build`

assets = Dir.glob("content/**/*.{pdf,jpg,png}") + Dir.glob("*.css")

`cp #{assets.join " "} build`

# build source files

source_files = Dir.glob("content/**/*.md")

template = File.read("template.html").gsub '$WEBROOT', WEBROOT

for source_file in source_files do

  # copy directory structure for output file

  basedir = File.dirname(source_file).delete_prefix "content"
  basename = File.basename(source_file, ".md")

  body_file = "build/#{basedir}/#{basename}.body.html"
  target_file = "build/#{basedir}/#{basename}.html"

  `mkdir -p build/#{basedir}`

  puts "Processing #{source_file}"

  # generate page body.
  # the lua filter replaces /abc.html with $WEBROOT/abc.html
  `pandoc --lua-filter="filter.lua" #{source_file} -o "#{body_file}" --mathml`

  result = template.gsub '$STUFF', `cat "#{body_file}"`

  File.write(target_file, result)
end
