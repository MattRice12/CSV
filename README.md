### The Code Challenge
This code challenge dealt with a 1.05GB .tab file.

```
This sample data set describes repair order patterns at hypothetical dealerships.

The data is clearly fictional, but it’s still a good representative sample of the types of data, data issues, and opportunities for insight that we encounter regularly.

Could you:

i. Pick a ‘top performing’ dealer, according to the criteria you think is best. Please describe why you think this.

ii. Comment on at least 2 other properties of the data that you think are interesting.

iii. Send a sample of any code used in generating your response. The language and style used are not important, but the general thought process is.

Please call out any data cleanliness issues you think are relevant. Charts and extra commentary are always welcome. Feel free to reach out over email with questions.
```

### In this repo:
  1. MD files:
    You will find 4 markdown files (excluding the README.md).
      - `process.md` covers notes I took trying to document the process I went through to solve this problem (up until I got SQL working).
      - `queries.md` includes many of the queries I ran (i) to get a feel for the data in trying to figure it out, and (ii) to solve the questions asked for this challenge.
      - `answers.md` includes my answers to challenge questions i. and ii.
      - `criticisms.md` includes the 3 main criticisms/issues I dealt with when running queries on the data.

  2. Scripts folder:
    You will find 2 scripts, a `.rb` and a `.py` file.
      - `sanitize.rb` utf-8 encodes the data so that I can add it to a table in SQL.
      - `create_table.py` creates a table with the now utf-8 encoded data.

  3. Practice folder:
    This folder contains several scripts that I used to get a better understanding of sanitizing data and using python. This is the part I struggled with the most by far, so the amount of files in the practice folder does not account for the amount of research that went into getting the final scripts to work.
