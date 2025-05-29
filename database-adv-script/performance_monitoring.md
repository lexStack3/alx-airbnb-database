# Performance Monitoring & Refinement Report

## Objective
To continuously monitor and refine database performance by analyzing query execution plans and making schema-level optimizations for improved speed and efficiency.

## Step 1: Monitoring Query Performance
Using PostgreSQL's `EXPLAIN ANALYZE`, I tested the performance of key queries from previous work, particularly those involving joins, aggregations, and date-based filters on the `Booking` table.

### Sample Query (Bookings from 2025 onward):
```sql
EXPLAIN ANALYZE 
SELECT booking_id, property_id, user_id, start_date, end_date, status
FROM Booking
WHERE start_date >= '2025-01-01';
```
### Observation:
- The sequential scan on the large `Booking` table resulted in high execution time.
- High cost estimates due to scanning the full table without utilizing indexes or partitions.

## Step 2: Identifying Bottlenecks
From the execution plans:
- No index usage on `start_date`, causing full table scans.
- Joins with `User` and `Property` were inefficient due to missing indexes on foreign key (`user_id`, `property_id`).
- Lack of filtering optimization due to flat schema and absence of partitions in the original table.

## Step 3: Schema Adjustments
- **eated Indexes**
```sql
CREATE INDEX idx_booking_start_date ON Booking(start_date);
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_property_id ON Booking(property_id);
```
- **troduced Partitioning**
Refactored the `Booking` table using RANGE partitioning by `start_date`, improving date-based queries significantly.
- **timized Joins**
Ensured that joins columns (`user_id`, `property_id`) are indexed across related tables (`User1`, `Property`).

## Step 4: Post-Optimization Performance
Re-tested using:
```sql
EXPLAIN ANALYZE 
SELECT booking_id, property_id, user_id, start_date, end_date, status
FROM Booking_partitioned
WHERE start_date >= '2025-01-01';
```
**Performance Improvement**
---
| **Metric** | **Before** | **After** |
|------------|------------|-----------|
| Execution Plan | Seq Scan | Index Scan + Partition Pruning |
| Planning Time | ~2.5 ms | ~0.7 ms |
| Execution Time | ~20 ms | ~5 ms |


## Conclusion
Partitioning and indexing significantly reduced execution time for large queries, especially those with the date filters. The system now ultizes partition pruning and indexed lookups, leading to faster query plans and reduced I/O operations.