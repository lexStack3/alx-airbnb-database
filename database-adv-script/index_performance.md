# Improving Query Performance with Indexes

## Objective
This document explains how query performance was improved by identifying and creating indexes on frequently used columns in the User, Booking, and Property tables of the AirBnB Cloen Database. Indexes were created based on the analysis of queries that involved `JOIN`, `WHERE` and `ORDER BY` clauses.

## Tables and Indexed Columns
| Table | Column(s) Indexed | Reason for Indexing
|-------|-------------------|--------------------|
|`User`| `first_name`, `last_name` | Frequently used in `joins_queries.sql` & `ggregations_and_window_functions.sql` file|
|`Booking` | `user_id`, `property_id`, `created_at` | Common in `JOIN`s and `WHERE` clauses |
|`Property` | `name`| Used in `JOIN`s and `ORDER BY` clauses|
|`Review` | `property_id`, `rating` | Used in `subqueries.sql` |

## Index Creation Commands
```sql
-- User table
CREATE INDEX idx_user_first_name ON User(first_name);
CREATE INDEX idx_user_last_name ON User(last_name);

-- Booking table
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_booking_booking_created_at ON Booking(created_at);

-- Property table
CREATE INDEX idx_property_name ON Property(name);

-- Review table
CREATE INDEX idx_review_property_id ON Review(property_id);
CREATE INDEX idx_review_rating ON Review(rating)
```

## Perfornance Measurement
Performance was measured before and after indexing using `EXPLAIN` and `ANALYZE` in MySQL.

## Before Indexing on `subqueries.sql`
![Before indexing](/img/before/subqueries.png)

## After Indexing on `subqueries.sql`
![After indexing](/img/after/subqueries.png)

## Observations
- Filteration operation actual time reduced from `time=1.16..1.16` to `time=0.638..0.638`.
- Total scan on `User` actual time reduced from `time=0.444.0.457` to `time=0.132..0.173`.
- Aggregate: `COUNT()` operation actual time reduced from `time=0.107..0.107` to `time=0.0454..0.0455`.


## Conclusion
Indexing significantly improved the performance of frequently executed queries. Careful selection of columns for indexing especially those in `WHERE`, and `ORDER BY` clauses can make a major impact on database speed and efficiency.