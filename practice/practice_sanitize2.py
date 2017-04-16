import pandas

def create_dictionary(filename):
    my_data = pandas.read_csv(filename, sep='\t', encoding="latin-1", error_bad_lines=False, index_col=False, dtype='unicode')
    list_of_dicts = [item for item in my_data.T.to_dict().values()]
    return list_of_dicts

x = create_dictionary("../transcoded.tab")

# creates transcoded.tab file with latin-1 formatting.
    # tried running csv
# tried with iso-8859-1


# list of encodings: https://docs.python.org/3/library/codecs.html#standard-encodings
