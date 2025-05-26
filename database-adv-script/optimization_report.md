# Query Performance Optimization Report

## Objective
This report documents the process of improving SQL query performance for retrieving bookings along with `User`, `Property`, and `Payment` details from the AirBnB Clone database. The initial query included unnecessary `UNION` clauses and `LEFT JOIN` operations that were later optimized for better efficiency.

## Initial Query Overview
The original query combined three seperate `SELECT` statements using `UNION` to:
1. Retrieve all bookings with joined `User`, `Property`, and `Payment` details.
2. Retrieve `Property`s with no `Booking`s.
3. Retrieve `Payment`s with no `Booking`s.

This approach resulted in unnecessary full scans and additional overhead from deduplication and filtering operations due to `UNION`.
```sql
SELECT
    b.booking_id,
    u.first_name,
    u.last_name,
    p.name AS property_name,
    p.pricepernight AS property_price_per_night,
    pay.amount AS amount_paid,
    pay.payment_method,
    b.start_date,
    b.end_date,
    b.status AS booking_status
FROM Booking b
LEFT JOIN User u ON b.user_id = u.user_id
LEFT JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id

UNION

SELECT
    NULL AS booking_id,
    NULL AS first_name,
    NULL AS last_name,
    p.name AS property_name,
    p.pricepernight AS property_price_per_night,
    NULL AS amount_paid,
    NULL AS payment_method,
    NULL AS start_date,
    NULL AS end_date,
    NULL AS booking_status
FROM Property p
LEFT JOIN Booking b ON p.property_id = b.property_id
WHERE b.booking_id IS NULL

UNION

SELECT
    NULL AS booking_id,
    NULL AS first_name,
    NULL AS last_name,
    NULL AS property_name,
    NULL AS property_price_per_night,
    pay.amount AS amount_paid,
    pay.payment_method,
    NULL AS start_date,
    NULL AS end_date,
    NULL AS booking_status
FROM Payment pay
LEFT JOIN Booking b ON pay.booking_id = b.booking_id
WHERE b.booking_id IS NULL;
```

### EXPLAIN ANALYZE (Before Optimization)
```sql
-> Table scan on <union temporary>  (cost=11.6..14 rows=12) (actual time=2.32..2.32 rows=4 loops=1)
  -> Union materialize with deduplication  (cost=11.3..11.3 rows=12) (actual time=2.25..2.25 rows=4 loops=1)
    -> Nested loop left join  (cost=4.85 rows=4) (actual time=0.797..0.849 rows=4 loops=1)
      -> Nested loop left join  (cost=3.45 rows=4) (actual time=0.713..0.74 rows=4 loops=1)
        -> Nested loop left join  (cost=2.05 rows=4) (actual time=0.703..0.715 rows=4 loops=1)
          -> Table scan on b  (cost=0.65 rows=4) (actual time=0.0442..0.0492 rows=4 loops=1)
          -> Single-row index lookup on u using PRIMARY (user_id=b.user_id)  (cost=0.275 rows=1) (actual time=0.0189..0.0189 rows=1 loops=4)
        -> Single-row index lookup on p using PRIMARY (property_id=b.property_id)  (cost=0.275 rows=1) (actual time=0.00568..0.00578 rows=1 loops=4)
      -> Index lookup on pay using booking_id (booking_id=b.booking_id)  (cost=0.275 rows=1) (actual time=0.00869..0.0107 rows=1 loops=4)
    -> Filter: (b.booking_id is null)  (cost=3.25 rows=4) (actual time=0.295..0.295 rows=0 loops=1)
      -> Nested loop antijoin  (cost=3.25 rows=4) (actual time=0.294..0.294 rows=0 loops=1)
        -> Table scan on p  (cost=0.65 rows=4) (actual time=0.126..0.13 rows=4 loops=1)
        -> Covering index lookup on b using idx_booking_property_id (property_id=p.property_id)  (cost=0.256 rows=1) (actual time=0.0405..0.0405 rows=1 loops=4)
    -> Filter: (b.booking_id is null)  (cost=2.05 rows=4) (actual time=0.144..0.144 rows=0 loops=1)
      -> Nested loop antijoin  (cost=2.05 rows=4) (actual time=0.143..0.143 rows=0 loops=1)
        -> Table scan on pay  (cost=0.65 rows=4) (actual time=0.0378..0.0409 rows=4 loops=1)
        -> Single-row covering index lookup on b using PRIMARY (booking_id=pay.booking_id)  (cost=0.275 rows=1) (actual time=0.0253..0.0253 rows=1 loops=4)
```
### Performance Issues
- **Union Deduplication Overhead**: `UNION` forced MySQL to sort and remove duplicates unnecessary.
- **Multiple Nested Loop Anti-Joins**: To fetch unmatched records, MySQL performed extra filtering and scanning.
- **Unnecessary NULL Columns**: The second and third SELECTs returned mostly NULLs, offering little value.
- **Query Execution Time**: Overall time was increased due to excessive joins and filters.

## Optimized Query Overview
The improved query focuses solely on retrieving existing bookings with their related `User`, `Property`, and `Payment` data. Unnecessary `UNION` clauses and anti-joins were removed.
### Optimized Query
```sql
SELECT
    b.booking_id AS booking_id,
    u.first_name AS first_name,
    u.last_name AS last_name,
    u.email AS email,
    p.name AS property_name,
    p.location AS location,
    p.pricepernight AS price_per_night,
    pay.amount AS amount_paid,
    pay.payment_method AS payment_method,
    b.start_date AS start_date,
    b.end_date AS end_date,
    b.status AS booking_status,
    b.created_at AS created_at
FROM Booking b
LEFT JOIN User u ON b.user_id = u.user_id
LEFT JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id
WHERE u.user_id IS NOT NULL AND p.property_id IS NOT NULL;
```

### EXPLAIN ANALYZE (After Optimization)
```sql
- Nested loop left join  (cost=4.85 rows=4) (actual time=0.971..1.19 rows=4 loops=1)
  - Nested loop left join  (cost=3.45 rows=4) (actual time=0.835..0.905 rows=4 loops=1)
    - Nested loop left join  (cost=2.05 rows=4) (actual time=0.678..0.706 rows=4 loops=1)
      - Table scan on b  (cost=0.65 rows=4) (actual time=0.455..0.463 rows=4 loops=1)
      - Single-row index lookup on u using PRIMARY (user_id=b.user_id)  (cost=0.275 rows=1) (actual time=0.0489..0.049 rows=1 loops=4)
    - Single-row index lookup on p using PRIMARY (property_id=b.property_id)  (cost=0.275 rows=1) (actual time=0.0488..0.049 rows=1 loops=4)
  - Index lookup on pay using booking_id (booking_id=b.booking_id)  (cost=0.275 rows=1) (actual time=0.0415..0.059 rows=1 loops=4)
```

## Comparison Summary
---
| Aspect | Before Optimization | After Optimization | 
|--------|---------------------|--------------------|
|Execution Time | 2.32 seconds | 1.19 seconds |
|Join Complexity | 3 UNIONs with filters and anti-joins | 1 clean multi-join |
|Data Scanned | All tables scanned multiple times | Minimized with indexes |
|Query Structure | Redundant and bloated | Clean and focused |
|NULL Records Returned | Yes (artificially padded) | No |

## Conclusion
The optimized query offers a cleaner structure and significantly better performance. By forcusing only on meaningful data (existing bookings) and removing unnecessary `UNION` clauses and anti-joins, the query executes faster and is more maintainable. This demonstrates the importance of reviewing query logic as part of performance tuning not just indexing.