# This script isn't trying to sanitize; it is my early attempt to just write to a new file.

require 'csv'

out_file = File.new('output.tab', 'w')

File.open("RO_Example.tab", "r", { :col_sep => "\t" }).each_with_index do |row, i|
  if i < 1
    out_file.puts(row)
  end
end
