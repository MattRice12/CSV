utf8_csv = File.open("../RO_Example.tab", :encoding => 'ISO-8859-1:utf-8', col_sep: '\t', headers: true).read

open("../transcoded.tab", "w:ISO-8859-1") do |io|
  io.write(utf8_csv)
end

## This file tries to clean up the data in RO_Example.tab and convert it into something SQL can read.
  ## It works, but certain values are still nonsensical.
    ## ISO-8859-1:utf-8  => does not correct weird values
    ## cp1252:utf-8      => does not correct weird values
    ## utf-8:utf-8       => does not correct weird values

    ## ISO-8559-1:utf-16 => does not correct weird values. It also took WAY longer to run
      # http://stackoverflow.com/questions/2241348/what-is-unicode-utf-8-utf-16 explains why (utf-16 is much less memory efficient)
