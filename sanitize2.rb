string = "R\u00E9sum\u00E9"

open("transcoded.txt", "w:ISO-8859-1") do |io|
  io.write(string)
end

puts "raw text:"
p File.binread("transcoded.txt")
puts

open("transcoded.txt", "r:ISO-8859-1:UTF-8") do |io|
  puts "transcoded text:"
  p io.read
end
