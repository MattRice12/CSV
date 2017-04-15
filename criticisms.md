1. My main problem is that the column names aren't too descriptive. It took me a while to figure out what ro_total was; this is also a hard keyword to google. After a little research, it sounds like ro_total is the "repair order" price the dealership charges a customer for vehicle repairs/maintenance.
  - It is also unclear just by column names how to clearly distinguish between the labor_amounts, parts_amounts, or misc_amounts in a way to make helpful calculations.

2. Some of the columns have nonstandard inputs. E.g., description_1 and description_2 have many (more than I can count) values which do not match any other value. So I can't tell whether certain dealerships do mostly oil changes or whatever else. It limits the usefulness of these columns and accuracy of any predictions.

3. labor_time has bad data which I don't know how to convert into something readable. I want to calculate the average ro_total divided by average labor_time to get the average ro_total per hour per dealership.
