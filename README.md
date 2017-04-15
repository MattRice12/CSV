###Process:
  1. What are .tab files?
    TAB files are text files that contain a list of data, separated by tabs. There is typically one record per line, with a tab (the same as typing the "Tab" key) between each field.

  2. Learn Python
    - Idea: Use python to run scripts to parse the .tab file and sort by column.
      - Maybe do this solely with python?
      - Maybe use python to run SQL query?
      - Can I run a SQL query on a .tab file without Python or other language? I think I'd have to convert the file into something that SQL can recognize.
    - I'm going to look at alternatives to this first.

  3. `csvkit`
    - https://csvkit.readthedocs.io/en/1.0.1/
    - Managed to extract column names and print them into a new tab file.
    - Having problems running the entire file; I think it's too large.
      - Error: Your file is not "utf-8" encoded.

  4. `q`
    - http://harelba.github.io/q/examples.html
    - This runs SQL queries on csv files from command line.
    - Problem: Works well on csv files; not so much on the .tab file. I'm thinking that either I'm using the wrong flag or the .tab file is just too large for q to run.

  5. `querycsv`
    - http://harelba.github.io/q/examples.html

  6. Copy into PostgreSQL:
    - https://www.postgresql.org/docs/current/static/sql-copy.html
    - Problem: Need to create table before importing.
      - To create table, need to create columns first. I don't think I should be manually creating a table with 50+ columns. Maybe need Python pandas library.
    - http://www.developersite.org/101-72480-postgresql

  7. `Python pandas library`
    - http://stackoverflow.com/questions/2987433/how-to-import-csv-file-data-into-a-postgresql-table
    - pip3 install pandas


  8. `Ruby`
    - Yes. I understand this a lot better and am getting it to work. So far, I can read the table. -
    - Next:
      A.) I need to figure out how to read a specific column
        - OR -
      B.1.) I need to figure out how to sort by a specific column
        - AND -
      B.2.) I need to figure out how to limit the output to 5-10 rows.
        - OR -
      C.1.) Sanitize the individual columns in Ruby (optional: write to a new file)
      C.2.) Create SQL table in Python
      C.3.) Query it in SQL

    - `ruby sanatize3.rb`
    - `python script.py`
      -- ERROR: with creating database
    - csvkit
      -- ERROR: file not utf-8 encoded

What I'm trying to do:
  General: Query the .tab file in SQL
    1) Use `pandas` to create a table with the data
    2) open table in `psql` and perform search queries.
    3) output?

Questions:
  1) Pandas?
  2) SQL?
  3) Do I need to convert the file to csv first?
  4) Matlab?
  5) R?
    -- problem max file size too low (only like 10MB)


Repeated issues:
  1) UnicodeDecodeError: 'utf-8' codec can't decode byte 0x96 in position 174: invalid start byte
    - I think I need to sanitize the file; people suggest this is the result of non ascii characters encoded in the data.


Pandas tutorial:
  https://realpython.com/blog/python/working-with-large-excel-files-in-pandas/

Successful combination:
  1) Ruby: `sanitize3.rb`
  2) Python: `script.py`
  3) SQL: PostgreSQL

Further Research:
  RO -- Repair Order System.
