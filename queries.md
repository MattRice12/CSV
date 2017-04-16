#Queries:

###General Queries

1. Sort dealers by id:
  `SELECT dealer_id
   FROM dealers
   GROUP BY dealer_id;`

2. Sort parts_amount by dealer_id:
 `SELECT dealer_id,
         ROUND(AVG(parts_amount::float)::numeric, 2)
  FROM dealers
  GROUP BY 1
  ORDER BY 2;`
    - lowest:  dealer_id=10467,  avg parts_amount=$13.78
    - highest: dealer_id=213615, avg parts_amount=$92.57

3. Sort labor_amount by dealer_id
  `SELECT dealer_id,
          ROUND(AVG(labor_amount::float)::numeric, 2)
   FROM dealers
   GROUP BY 1
   ORDER BY 2;`
     - lowest:  dealer_id=9906,  avg labor_amount=$10.67
     - highest: dealer_id=11457, avg labor_amount=$90.93

4. Sort customer email_address by dealer_id ---> This tells us how many transactions each dealership has made
  `SELECT dealer_id,
          COUNT(email_address)
  FROM dealers
  GROUP BY 1
  ORDER BY 2;`
  - lowest:  dealer_id=211653, customers=999
  - highest: dealer_id=33078,  customers=93597

5. Unique customers
    `SELECT dealer_id,
            COUNT(DISTINCT(email_address))
    FROM dealers
    GROUP BY 1
    ORDER BY 2;`
    - It looks like each dealership served 180 unique customers except for dealer_id=211653. I think this is probably erroneous.

6. See how many e-mail addresses there are
    `SELECT email_address,
           COUNT(email_address)
    FROM dealers
    GROUP BY 1
    ORDER BY 2;`
    - So there are only 180 email addresses. They also have made roughly the same amount of orders each.

7. Group by dealer_id; show how many customers served (email_addresses) and average ro_amount:
  `SELECT dealer_id,
          COUNT(email_address),
          ROUND(AVG(ro_total::float)::numeric, 2)
  FROM dealers
  GROUP BY 1
  ORDER BY 3;`
  - lowest-customers:  dealer_id=211653, customers=999,   amount=$53.14
  - highest-customers: dealer_id=33078,  customers=93597, amount=$28.05

  - lowest-ro_amount:  dealer_id=9906,   customers=13836, amount=$16.67
  - highest-ro_amount: dealer_id=11460,  customers=18852, amount=113.51


###RO_TOTAL and revenue

8. Group dealers by ro_total (revenue?):
  `SELECT dealer_id,
          ROUND(SUM(ro_total::float)::numeric, 2)
  FROM dealers
  GROUP BY 1
  ORDER BY 2;`

9. Group dealership by the number of times that dealership has performed maintenance (ro_total) on cars that amounts to great than $100:
  `SELECT dealer_id,
          COUNT(dealer_id) AS ro_total_over_$100
  FROM dealers
  WHERE ro_total::float > 100
  GROUP BY 1
  ORDER BY 2;`
      dealer_id | ro_total_over_$100
     -----------+--------------------
      15783    |                109
      9774     |              11849

10. Group by dealer_id: show average revenue per customer (ARPC).
  `SELECT dealer_id,
          ROUND(COUNT(email_address)/AVG(ro_total::float)::numeric, 2) AS ARPC
  FROM dealers
  GROUP BY 1
  ORDER BY 2;`
  - lowest-revenue:  dealer_id=211653, ARPC=$18.80
  - highest-revenue: dealer_id=33078,  ARPC=$3336.65

11. Trying to figure out ro_total and its relation to labor, parts, and misc amounts
    `SELECT
        parts_amount,
        labor_amount,
        ro_total,
        customer_labor_amount AS cla,
        customer_parts_amount AS cpa,
        customer_misc_amount  AS cma,
        warranty_labor_amount AS wla,
        warranty_parts_amount AS wpa,
        warranty_misc_amount  AS wma,
        internal_labor_amount AS ila,
        internal_parts_amount AS ipa,
        internal_misc_amount  AS ima
    FROM dealers
    LIMIT 20;`

12. ro_total === customer_parts_amount + customer_labor_amount + customer_misc_amount
    `SELECT
        dealer_id,
        ROUND(SUM(parts_amount::float + labor_amount::float)::numeric, 2) AS parts_and_labor,
        ROUND(SUM(customer_parts_amount::float + customer_labor_amount::float + customer_misc_amount::float)::numeric, 2) AS cust_pla,
        ROUND(SUM(warranty_parts_amount::float + warranty_labor_amount::float + warranty_misc_amount::float)::numeric, 2) AS warr_pla,
        ROUND(SUM(internal_parts_amount::float + internal_labor_amount::float + internal_misc_amount::float)::numeric, 2) AS internal_pla,
        ROUND(SUM(ro_total::float)::numeric, 2) AS ro_total
    FROM dealers
    GROUP BY 1
    ORDER BY 2, 3, 4;`
      Question -- If ro_total is total revenue, does this mean that total profit is `ro_total` minus `warranty` and `internal` amounts?
                  I'm not sure about this. Some warranties still make the customer pay for labor even though the parts are free.

13. total parts + labor + misc
    `SELECT dealer_id,
            ROUND(SUM(customer_parts_amount::float +
                      customer_labor_amount::float +
                      customer_misc_amount::float  +
                      warranty_parts_amount::float +
                      warranty_labor_amount::float +
                      warranty_misc_amount::float  +
                      internal_parts_amount::float +
                      internal_labor_amount::float +
                      internal_misc_amount::float)::numeric, 2) AS all_plm
    FROM dealers
    GROUP BY 1
    ORDER BY 2;`

14. Profit === ro_total - (warranty + internal)???
    `SELECT
        dealer_id,
        ROUND(SUM(warranty_parts_amount::float +
                  warranty_labor_amount::float +
                  warranty_misc_amount::float)::numeric, 2) AS warranty_plm,
        ROUND(SUM(internal_parts_amount::float +
                  internal_labor_amount::float +
                  internal_misc_amount::float)::numeric, 2) AS internal_plm,
        ROUND(SUM(ro_total::float)::numeric, 2) AS ro_total,
        ROUND(SUM(ro_total::float -
                 (warranty_parts_amount::float +
                  warranty_labor_amount::float +
                  warranty_misc_amount::float) -
                 (internal_parts_amount::float +
                  internal_labor_amount::float +
                  internal_misc_amount::float))::numeric, 2) AS profit
    FROM dealers
    GROUP BY 1
    ORDER BY profit;`
      Conclusion: It may be true that profit equals ro_total - (warranty + internal parts/labor/misc). However, I'm not convinced. This would mean that dealer `15774` is running a $1.8 million loss, and 28 dealers total (out of 95 total) running some sort of loss. That is roughly 1/3 of the dealers!

15. parts_amount + labor_amount equals all parts + labor. In retrospect, this was obvious.
    `SELECT
        dealer_id,
        ROUND(SUM(parts_amount::float + labor_amount::float)::numeric, 2) AS parts_and_labor,
        ROUND(SUM(customer_parts_amount::float +
                  customer_labor_amount::float +
                  warranty_parts_amount::float +
                  warranty_labor_amount::float +
                  internal_parts_amount::float +
                  internal_labor_amount::float
                  )::numeric, 2) AS all_pl,
        ROUND(SUM(ro_total::float)::numeric, 2) AS ro_total
    FROM dealers
    GROUP BY 1
    ORDER BY 2, 3, 4;`
  If parts_amount and labor_amounts cover all parts and labors respectively, does that mean all parts and labor are costs to the dealer? If that's the case, then since ro_total equals customer parts, labor, and misc, is ro_total a cost to the dealer?


###oil vs non-oil maintenance
16. Group by dealer_id: Group dealership by the amount of maintenance involving oil (e.g., oil changes):
  `SELECT dealer_id,
          COUNT(description_1) AS oil_maintenance
  FROM dealers
  WHERE description_1
  LIKE '%OIL%'
  GROUP BY 1
  ORDER BY 2;`
  - lowest-count:   dealer_id=213660, oil_maintenance=2
  - highest-spread: dealer_id=33078,  oil_maintenance=50413
    *Prediction*
      - Dealer `213660`'s main source of revenue comes from more expensive maintenance.
        (non-oil-maintenance = 8819)
      - Dealer `33078`'s main source of revenue involves cheaper maintenance (such as oil changes)
        (non-oil-maintenance = 43184) !!! interesting! My prediction might have been wrong.

17. Group dealership by the amount of maintenance NOT involving oil:
  `SELECT dealer_id,
          COUNT(description_1) AS non_oil_maintenance
  FROM dealers
  WHERE description_1 NOT LIKE '%OIL%'
  GROUP BY 1
  ORDER BY 2;`
  - lowest-count:   dealer_id=211653, non_oil_maintenance=730
  - highest-count:  dealer_id=9774,   non_oil_maintenance=59998

18. Search dealership by percentage of non-oil maintenance over total maintenance
  ` SELECT dealer_id,
          ROUND((
            (SELECT COUNT(description_1)
               FROM dealers
               WHERE description_1 NOT LIKE '%OIL%' AND dealer_id::numeric = '213660'
               GROUP BY dealer_id
               ORDER BY 1) /
            (SELECT COUNT(description_1)
               FROM dealers
               WHERE dealer_id = '213660'
               GROUP BY dealer_id
               ORDER BY 1)::float *
            100)::numeric, 2) || '%' AS non_oil_perc
    FROM dealers
    WHERE dealer_id = '213660'
    GROUP BY 1
    ORDER BY 2;
    `
    - dealer_id=9774,    non-oil-maintenance=64.25%
    - dealer_id=211653,  non-oil-maintenance=73.07%
    - dealer_id=33078,   non-oil-maintenance=46.14%
    - dealer_id=213660,  non-oil-maintenance=99.98% *** This is interesting. They do almost no oil-related maintenance

###NISSAN!!!!

19. NISSAN vehicles seem to require the most maintenance by a huge margin:
    Times anyone has worked on NISSAN     = 1,299,166 - 88179
    Times anyone has worked on INFINITI   = 88,179
    Times anyone has worked on VOLKSWAGEN = 53142
      `SELECT make_name, COUNT(make_name)
      FROM dealers
      GROUP BY 1
      ORDER BY 2;`

20. The 3 most worked on vehicle models (hint: they're all NISSANS, and they're actually the top 12 vehicle models worked on):

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

21. Nissan accounts for most of the revenue for dealerships, collectively (accounting for over 50 million more than the next vehicle make):
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


###Model Years

22. Group by dealer_id: show latest model number dealership worked on:
  `SELECT dealer_id,
          MAX(model_year) AS max_model_year
  FROM dealers
  GROUP BY 1
  ORDER BY 2;`
  dealer_id=6696 & 11520, model_year=2019
  dealer_id=15801,        model_year=2032

23. Group by dealer_id: show largest spread of model_year a dealership works on:
  `SELECT dealer_id,
          MAX(model_year) AS max_model_year,
          MIN(model_year) AS min_model_year,
         (MAX(model_year)::int - MIN(model_year)::int) AS year_spread
  FROM dealers
  GROUP BY 1
  ORDER BY 3;`
  - lowest-spread:  dealer_id=211653, spread=17 years  (1996 - 2013)
  - highest-spread: dealer_id=33078,  spread=102 years (1930 - 2032)
