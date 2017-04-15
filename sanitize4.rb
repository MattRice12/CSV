file_contents = CSV.read("RO_Example.tab", col_sep: "\t", encoding: "ISO8859-1:utf-8")

CSV.parse(File.open(filename, 'r:iso-8859-1:utf-8'){|f| f.read}, col_sep: ';', headers: true, header_converters: :symbol) do |row|
    pp row
end


# utf8_string = latin1_string.force_encoding('iso-8859-1').encode('utf-8')
