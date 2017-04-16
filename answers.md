### Top Performing Dealer
  I noticed through running several queries that two dealers show up the most: dealer `33078` and dealer `9774`.

  Dealer 33078 really stands out on many of these:
    (query #8) -- Total ro_total(revenue) = $2,625,508.26 (5th place)
    (query #13) - Total parts, labor, misc = $6,245,859.54 (2nd place)
    (query #4) -- Total Number of (non-unique) customers served=93597
    (query #10) - Average revenue per customer=$3336.65
    (query #7) -- Average revenue per deal=$28.05

  Dealer 9774 also stands out:
    (query #8) -- Total ro_total (revenue) = $4,314,259.42 (1st place)
    (query #13) - Total parts, labor, misc = $7,437,117.90 (1st place)
    (query #4) -- Total Number of (non-unique) customers served=93388
    (query #10) - Average revenue per customer=$2021.51
    (query #7) -- Average revenue per deal=$46.20

#### Winner:
   
   **ro_total**: `9774`. I'm determining the winner based on `ro_total`, which I assume is total revenue. I realize that making a decision based on revenue without considering overhead or any other costs is limited and potentially misleading. However, I wasn't sure which columns held data for the dealers' expenses. (See )

   **total parts, labor, misc**: `9774`. Assuming that all parts, labor, and misc are billed to the customers, 9774 pulls in over $7 million, well over $1 million ahead of the 2nd place competitor.

   However! If profit equals `ro_total - (warranty + internal)`, then the winner by a slim margin is dealer `5523` with `27081` as a close 2nd. `9774` is still at the top of the charts, though a few hundred thousand behind. Surprisingly, `33078`, which we noted above made a substantial amount of revenue and also worked on a substantially large amount of vehicles is running nearly a $1 million loss. (See query #14)
    

      ```
      Query #14
      dealer_id | warranty_plm | internal_plm |  ro_total  |   profit
      -----------+--------------+--------------+------------+-------------
      15774     |   1709783.73 |    670333.68 |  560510.74 | -1819606.67
      33078     |   1365009.84 |   2255341.44 | 2625508.26 |  -994843.02
      ..................................................................
      9894      |    282050.26 |    282497.03 | 1728858.09 |  1164310.80
      9774      |   1298643.07 |   1824215.42 | 4314259.42 |  1191400.93
      11460     |    437458.76 |    321288.42 | 2139800.60 |  1381053.43
      27081     |    916920.56 |    662235.69 | 3052341.43 |  1473185.18
      5523      |   1057016.54 |    514088.56 | 3055864.03 |  1484758.94
      ```

   **labor**: `33078`. This isn't really a winning category, but `33078` seems to have worked the hardest, serving nearly 10k customers (See query #4). It is interesting how they failed to make a profit. According to query #16, `33078` performed the most work involving "oil" (at over 50k customers). I hypothesized that most of their labor was devoted to cheap work. However, query #17 showed that they performed the 2nd most non-oil work as well (at over 43k customers). However, query #7 also indicates that they have a pretty low ro_amount per work order (they have the 6th lowest), indicating that they do in fact perform a lot of cheap labor (or don't charge enough for what they do). See also query #18 -- dealer `33078` does a comparatively low percentage of non-oil related maintenance

### NISSANS
  Nissans are by far the most maintained vehicle make. Query #19 shows us that they have been worked on 1,299,166 times (1.2 million times more than the next vehicle (Infiniti @ 88k times)).

  As a result, Query #21 shows us they account for $57 million of the ro_total ($55 million more than the next vehicle make).

  **Analysis**: I'm sure Nissan's aren't just bad vehicles. There is likely a good reason that they are the most serviced vehicle and the largest source of revenue. I'm guessing they are just the most popular vehicle on the list and so are owned by more people. Sadly, the data doesn't give us this insight, but it is worth noting that there is probably some 3rd variable causing this outcome.


### Model Year
  Query #23 shows us that the oldest vehicle being worked on is from 1928.
  
  Query #22 shows us that the newest vehicle is from the future, being a 2032 model. Two 2019 models also have had some maintenance.

### Other:
  - I found it interesting that each dealer served 180 distinct customers (sorting by e-mail addresses) (Query #5).
  - Also, each customer has been to the dealership roughly 10.3k times (Query #6).
