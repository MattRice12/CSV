import pandas as pd


# Read the file
data = pd.read_csv("../RO_Example.tab", error_bad_lines=False, low_memory=False)
# Output the number of rows
print("Total rows: {0}".format(len(data)))
# See which headers are available
print(list(data))


## Didn't work
