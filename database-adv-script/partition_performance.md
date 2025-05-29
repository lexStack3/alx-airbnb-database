# Brief Report on Observed Improvements

## Objective
To improve query performance on a large `Booking` table by partitioning it by `start_date`.

## Method
- Partitioned the `Booking` table using **range partitioning by year**.
- Created 6 partiions from 2020 to 2100.
- Queried both the original and partitioned table using `EXPLAIN ANALYZE`.

## Observation
- **Non-partitioned Table:** Full table scan occurred, leading to slower response time.
- **Partitioned Table:** Query planner only scanned the relevant partitions (e.g., `Booking_future`) using partition pruning, resulting in **faster query execution** and **lower cost**.

## Conclusion
Partitioning by `start_date` significantly reduced the number of rows scanned during time-based queries. This optimization is ideal for time-series data or frequent date-range lookups.