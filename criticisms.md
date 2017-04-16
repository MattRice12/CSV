1. My main problem is that the column names aren't too descriptive. It took me a while to figure out what `ro_total` was. After a little research, it sounds like `ro_total` is the "repair order" price the dealership charges a customer for vehicle repairs/maintenance.
  - It is also unclear just by column names how to clearly distinguish between the `labor_amounts`, `parts_amounts`, or `misc_amounts` in a way to make helpful calculations.
  - After running some queries, it looks like `ro_total === customer_parts_amount + customer_labor_amount + customer_misc_amount`
  - Also `parts_amount + labor_amount === all parts + labor`.
  - Does this mean all amounts are sources of revenue?
  - What about `misc amount`?
  - I can't tell if warranty_labor_amounts are expenses or sources of revenue for the dealer. Some warranties cover cost of parts but still make the customer pay for labor.
  - Basically, I'm trying to make a profits analysis but I don't know what is revenue and what is an expense.

2. Some of the columns have nonstandard inputs. E.g., `description_1` and `description_2` have many (more than I can count) values which do not match any other value. So I can't tell whether certain dealerships do mostly oil changes or whatever else. It limits the usefulness of these columns and accuracy of any predictions.

3. `labor_time` has bad data which I don't know how to convert into something readable. I want to calculate the average `ro_total` divided by average `labor_time` to get the average `ro_total` per hour per dealership.
