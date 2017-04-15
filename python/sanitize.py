# with open('./RO_Example.tab', "r") as fp:
for line in open('./RO_Example.tab', encoding = "ISO-8859-1"):
    line = line.strip()
    line = bytes(line, 'utf-8').decode('utf-8','ignore')


# this runs completely... but I don't really know what it's doing.
## Okay nevermind, this erased all of the contents in my source file.
