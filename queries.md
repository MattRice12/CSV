Search: dealer_id, parts_amount

Sort dealers by id:
  `SELECT dealer_id
   FROM dealers
   GROUP BY dealer_id;`

Sort parts_amount by dealer_id:
  `SELECT dealer_id, AVG(parts_amount)
   FROM dealers
   GROUP BY 1`
   -- Problem: all types are `undefined`.

   -- Solution:
    `SELECT dealer_id, AVG(parts_amount::float)
     FROM dealers
     GROUP BY 1;`

   -- Round to 2 decimal places:
     `SELECT dealer_id, ROUND(AVG(parts_amount::float)::numeric, 2)
      FROM dealers
      GROUP BY 1;`

   - ORDER:
   `SELECT dealer_id, ROUND(AVG(parts_amount::float)::numeric, 2)
    FROM dealers
    GROUP BY 1
    ORDER BY 2;`
      - lowest:  dealer_id=10467,  avg parts_amount=$13.78
      - highest: dealer_id=213615, avg parts_amount=$92.57

Sort labor_amount by dealer_id
  `SELECT dealer_id, ROUND(AVG(labor_amount::float)::numeric, 2)
   FROM dealers
   GROUP BY 1
   ORDER BY 2;`
     - lowest:  dealer_id=9906,  avg labor_amount=$10.67
     - highest: dealer_id=11457, avg labor_amount=$90.93

Sort customer email_address by dealer_id ---> This tells us how many transactions each dealership has made
  `SELECT dealer_id, COUNT(email_address)
  FROM dealers
  GROUP BY 1
  ORDER BY 2;`
  - lowest:  dealer_id=211653, customers=999
  - highest: dealer_id=33078,  customers=93597

  -- Unique customers
  `SELECT dealer_id,
  COUNT(DISTINCT(email_address))
  FROM dealers
  GROUP BY 1
  ORDER BY 2;`
    -- It looks like each dealership served 180 unique customers except for dealer_id=211653. I think this is probably erroneous.

Group by dealer_id; show how many customers served (email_addresses) and average ro_amount (I'm assuming ro_amount is revenue):
  `SELECT dealer_id, COUNT(email_address), ROUND(AVG(ro_total::float)::numeric, 2)
  FROM dealers
  GROUP BY 1
  ORDER BY 2;`
  - lowest-customers:  dealer_id=211653, customers=999,   amount=$53.14
  - highest-customers: dealer_id=33078,  customers=93597, amount=$28.05

  - lowest-ro_amount:  dealer_id=9906,   customers=13836, amount=$16.67
  - highest-ro_amount: dealer_id=11460,  customers=18852, amount=113.51

Group by dealer_id: show average revenue per customer (APC).
  `SELECT dealer_id, ROUND(COUNT(email_address)/AVG(ro_total::float)::numeric, 2)
  FROM dealers
  GROUP BY 1
  ORDER BY 2;`
  - lowest-revenue:  dealer_id=211653, APC=$18.80
  - highest-revenue: dealer_id=33078,  APC=$3336.65

Group by dealer_id: show latest model number dealership worked on:
  `SELECT dealer_id, MAX(model_year)
  FROM dealers
  GROUP BY 1
  ORDER BY 2;`
  dealer_id=6696 & 11520, model_year=2019
  dealer_id=15801,        model_year=2032

Group by dealer_id: show largest spread of model_year a dealership works on:
  `SELECT dealer_id,
          MAX(model_year),
          MIN(model_year),
          (MAX(model_year)::int - MIN(model_year)::int)
  FROM dealers
  GROUP BY 1
  ORDER BY 4;`
  - lowest-spread:  dealer_id=211653, spread=17 years  (2013 - 1996)
  - highest-spread: dealer_id=33078,  spread=102 years (2032 - 1930)

Group by dealer_id: Group dealership by the amount of maintenance involving oil (e.g., oil changes):
  `SELECT dealer_id, COUNT(description_1) AS oil_maintenance
  FROM dealers
  WHERE description_1
  LIKE '%OIL%'
  GROUP BY 1
  ORDER BY 2;`
  - lowest-count:   dealer_id=213660, oil_maintenance=2
  - highest-spread: dealer_id=33078,  oil_maintenance=50413
    *Prediction*
      -Dealer 213660's main source of revenue comes from more expensive maintenance.
        (non-oil-maintenance = 8819)
      -Dealer 33078's main source of revenue involves cheaper maintenance (such as oil changes)
        (non-oil-maintenance = 43184) !!! interesting! My prediction might have been wrong.

Group by dealer_id: Group dealership by the amount of maintenance NOT involving oil:
  `SELECT dealer_id, COUNT(description_1) AS non_oil_maintenance
  FROM dealers
  WHERE description_1
  NOT LIKE '%OIL%'
  GROUP BY 1
  ORDER BY 2;`
  - lowest-count:   dealer_id=211653, non_oil_maintenance=730
  - highest-spread: dealer_id=9774,   non_oil_maintenance=59998

  Total:
    `SELECT dealer_id, COUNT(description_1) AS total_maintenance
    FROM dealers
    GROUP BY 1
    ORDER BY 2;`
      dealer_id=211653, total=999
      dealer_id=9774,   total=93388

Group dealership by the number of times that dealership has performed maintenance (ro_total) on cars that amounts to great than $100:
  `SELECT dealer_id, COUNT(dealer_id) AS ro_total_over_$100
  FROM dealers WHERE ro_total::float > 100
  GROUP BY 1
  ORDER BY 2;`
      dealer_id | ro_total_over_$100
     -----------+--------------------
      15783    |                109
      9774     |              11849


Dealer 33078 really stands out on many of these:
  Total ro_total(revenue) = $2,625,508.26 (5th place)
  Total Number of (non-unique) customers served=93597
  Average revenue per customer=$3336.65
  Average revenue per deal=$28.05
  Times worked on NISSAN=43477
  Times worked on SUBARUS=37442

Dealer 9774 also stands out:
  Total ro_total (revenue) = $4,314,259.42 (1st place)
  Total Number of (non-unique) customers served=93388
  Average revenue per customer=$2021.51
  Average revenue per deal=$46.20
  Times worked on NISSAN=37247
  Times worked on SUBARUS=21161

Winner: Just from revenue--dealer 9774 wins by a lot.
Analysis: Although 9774 works on fewer vehicles, the amount they get paid per vehicle strongly outweighs this. Indeed, 2nd place for ro_total is 1.3 million less ($3,055,864.03).

  `SELECT dealer_id, ROUND(SUM(ro_total::float)::numeric, 2)
  FROM dealers
  GROUP BY 1
  ORDER BY 2;`

- On reflection, using e-mail addresses to count customers doesn't seem too accurate. 9774 served fewer customers and generated less revenue per customer when using the e-mail addresses, yet still generated more revenue overall. I'm guessing 9774 just isn't putting in e-mail addresses or something else is not adding up correctly.


______________________-______________________-______________________-
______________________-______________________-______________________-

NISSAN vehicles seem to require the most maintenance by a huge margin:
  Times anyone has worked on NISSAN     = 1299166
  Times anyone has worked on INFINITI   = 88179
  Times anyone has worked on VOLKSWAGEN = 53142
    `SELECT make_name, COUNT(make_name)
    FROM dealers
    GROUP BY 1
    ORDER BY 2;`

The 3 most worked on vehicle models (hint: they're all NISSANS, and they're actually the top 12 vehicle models worked on):

  make_name | model_name | count
  -----------+------------+--------
  NISSAN    | ALTIMA     | 332453
  NISSAN    | MAXIMA     | 129457
  NISSAN    | SENTRA     | 122557
    `SELECT make_name, model_name, COUNT(model_name)
    FROM dealers
    GROUP BY 1, 2
    ORDER BY 3
    DESC
    LIMIT 3;`

Nissan accounts for most of the revenue for dealerships, collectively (accounting for over 50 million more than the next vehicle make):
  make_name  | collective_revenue
  ------------+--------------------
  NISSAN     |        57913196.38
  INFINITI   |         7403421.38
  VOLKSWAGEN |         3590785.34

  `SELECT make_name,
          ROUND(SUM(ro_total::float)::numeric, 2) AS collective_revenue
  FROM dealers
  GROUP BY 1
  ORDER BY 2
  DESC
  LIMIT 3;`

Analysis: I'm sure Nissan's aren't just bad vehicles. There is likely a good reason that they are the most serviced vehicle and the largest source of revenue. I'm guessing they are just the most popular vehicle on the list and so are owned by more people. Sadly, the data doesn't give us this insight, but it is worth noting that there is probably some 3rd variable causing this outcome.

______________________-______________________-______________________-
______________________-______________________-______________________-
