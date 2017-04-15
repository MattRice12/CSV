utf8_csv = File.open("RO_Example.tab", :encoding => 'cp1252:utf-8', col_sep: '\t', headers: true).read


open("transcoded.tab", "w:cp1252") do |io|
  io.write(utf8_csv)
end

# puts "raw text:"
# p File.binread("transcoded.txt")
# puts
