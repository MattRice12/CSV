###Process:
  1. Research:
    (A) What are .tab files?
      TAB files are text files that contain a list of data, separated by tabs. There is typically one record per line, with a tab (the same as typing the "Tab" key) between each field.

    (B) What does RO mean?
      RO -- Repair Order System. A system for quoting a price to customers before the service is done. If the service is quoted at 2 hours but it takes 1 hour, the customer still pays for 2 hours. If it takes 4 hours to complete, the customer still pays for 2 hours.
        https://calaborlawnews.com/legal-news/interview-california-labor-law-5-17591.php
        http://www.fleetwisevb.com/FleetSoftware/FleetWise_RepairOrders.aspx

  2. Planning
    (A) Try to run scripts to output data on .tab file directly
      - With Python
      - With SQL?
    (B) Try to convert the file first before SQL can read it.
      - Can I run a SQL query on a .tab file without Python or other language? I think I'd have to convert the file into something that SQL can recognize.

  3. Python
    - Idea: Use python to run scripts to parse the .tab file and sort by column.
    - After looking at a few scripts and realizing that I should start with something I know, I decided to look at SQL and other alternative technologies first.

  4. SQL
    - https://www.postgresql.org/docs/current/static/sql-copy.html
    - Problem: Need to create table before importing.
      - To create table, need to create columns first. I don't think I should be manually creating a table with 50+ columns. Maybe need Python `pandas` library.
      - I found some other technologies while researching this process, so I'm going to try those before getting into `pandas`.

  5. `csvkit`
    - https://csvkit.readthedocs.io/en/1.0.1/
    - Managed to extract column names and print them into a new tab file.
    - Having problems running the entire file; I think it's too large.
      - Error: Your file is not "utf-8" encoded.

  6. `q`
    - http://harelba.github.io/q/examples.html
    - This runs SQL queries on csv files from command line.
    - Problem: Works well on csv files; not so much on the .tab file. I'm thinking that either I'm using the wrong flag or the .tab file is just too large for q to run.
      - Error: 'utf8' codec can't decode byte 0x96 in position 0: invalid start byte

  7. `R`
    - problem max file size too low (file must be under something like 10MB)

  8. SQL (reprise):
    - Restating the issue: Need to create table before importing.
      - One quick way of converting a csv into a table is with the Python pandas library (version
      - http://www.developersite.org/101-72480-postgresql

  9. `Python pandas library`
    - http://stackoverflow.com/questions/2987433/how-to-import-csv-file-data-into-a-postgresql-table
    - pip3 install pandas
    - Working through a lot of scripts, but not really understanding what I'm writing. Encoding adds to the confusion on top of this.

  10. `Ruby`
    - Yes. I understand this a lot better and am getting it to work. So far, I can read the .tab file. -
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

      (I went with C)

    - `ruby sanitize.rb`
    - `python create_table.py`
      -- ERROR: with creating database
    - csvkit
      -- ERROR: file not utf-8 encoded

  11. Re-evaluate
    What I'm trying to do:
      General: Query the .tab file in SQL
        1) Use ruby to sanitize the data.
        2) Use `pandas` to create a table with the data
        3) open table in `psql` and perform search queries.

    Repeated issues:
      1) UnicodeDecodeError: 'utf-8' codec can't decode byte 0x96 in position 174: invalid start byte
        - I think I need to sanitize the file; people suggest this is the result of non ascii characters encoded in the data.

    Pandas tutorial:
      https://realpython.com/blog/python/working-with-large-excel-files-in-pandas/

    Encoding:
      https://docs.python.org/3/library/codecs.html#standard-encodings

  12. Solution
    I was not encoding correctly. Once I utf-8 encoded my data (and finally wrote the script correctly), I was able to create a table in postgreSQL to run queries on it.

    Successful combination:
      1) Ruby: `sanitize.rb`
      2) Python: `create_table.py`
      3) SQL: PostgreSQL
