require 'nokogiri'

def parser(file)
  doc = Nokogiri::HTML(open(file))
  puts doc.title
end

def get_file_list(target, parsed)
  puts target
  Dir::foreach(target).each do |file|
    next if file == "." or file == ".."
    parser(target + "/" + file)
    move_file(target + "/" + file, parsed + "/" + file)
  end
end

def move_file(from, to)
  puts from
  puts to
  File.rename(from, to)
end

get_file_list("files", "parsed")
