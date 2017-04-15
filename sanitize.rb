
utf8_csv = File.open("RO_Example.tab", :encoding => 'windows-1251:utf-8').read


# CSV.read('/path/to/file', :encoding => 'windows-1251:utf-8')
# CSV.read('/..', {:headers => true, :col_sep => ';', :encoding => 'ISO-8859-1'})

# gotta be careful with the weird parameters order: TO, FROM !
# ascii_str = utf8_csv.unpack("U*").map{|c|c.chr}.join
#
# File.open("ansifile.csv", "w") { |f| f.puts ascii_str }


open("transcoded.tab", "w:ISO-8859-1") do |io|
  io.write(utf8_csv)
end

puts "raw text:"
p File.binread("transcoded.txt")
puts
#
# open("transcoded.txt", "r:ISO-8859-1:UTF-8") do |io|
#   puts "transcoded text:"
#   p io.read
# end

# menu.force_encoding("ISO-8859-1").encode("UTF-8")
