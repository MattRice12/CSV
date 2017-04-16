for line in open('./RO_Example.tab', encoding = "ISO-8859-1"):
    line = line.strip()
    line = bytes(line, 'utf-8').decode('utf-8','ignore')


# Trying to encode the file with utf-8.
# This doesn't work. It deletes the content of the file. 
