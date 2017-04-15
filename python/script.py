import pandas
df = pandas.read_csv('../transcoded.tab', sep='\t', encoding="latin-1", error_bad_lines=False, index_col=False, dtype='unicode')
df.columns = [c.lower() for c in df.columns] #postgres doesn't like capitals or spaces

from sqlalchemy import create_engine
engine = create_engine('postgresql://Matt:password@localhost:5432/dealers')

df.to_sql("dealers", engine)


# error that username does not exist
## I'm guessing this is talking about `username` in the create_engine argument string (originally: 'postgresql://username:password@localhost:5432/dbname' ).

# Changed username to my psql username and database to my `dealers` database
    ## Not getting the error; script is running for a lot longer. Causing my mac fan to turn on.
    ### IT WORKED!!!!! FINALLY!
    #### ...Sort of. I should turn the values which are gibberish into null values; but for now this is fine. 
