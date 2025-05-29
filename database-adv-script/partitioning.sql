-- 1. Create the main partitioned table
CREATE TABLE IF NOT EXISTS Booking_partitioned (
    booking_id UUID PRIMARY KEY,
    property_id UUID,
    user_id UUID,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price NUMERIC(10,2) NOT NULL,
    status TEXT CHECK (status IN ('pending', 'confirmed', 'canceled')) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES "User"(user_id) ON DELETE CASCADE
) PARTITION BY RANGE (start_date);

-- 2. Create partitions
CREATE TABLE Booking_partitioned_2020 PARTITION OF Booking_partitioned
    FOR VALUES FROM ('2020-01-01') TO ('2021-01-01');

CREATE TABLE Booking_partitioned_2021 PARTITION OF Booking_partitioned
    FOR VALUES FROM ('2021-01-01') TO ('2022-01-01');

CREATE TABLE Booking_partitioned_2022 PARTITION OF Booking_partitioned
    FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');

CREATE TABLE Booking_partitioned_2023 PARTITION OF Booking_partitioned
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE Booking_partitioned_2024 PARTITION OF Booking_partitioned
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE Booking_partitioned_max PARTITION OF Booking_partitioned
    FOR VALUES FROM ('2025-01-01') TO ('9999-12-31');

-- 3. Copy data from old table to partitioned table
INSERT INTO Booking_partitioned
SELECT * FROM Booking;

-- Analyze the query plan for the unpartitioned table
EXPLAIN ANALYZE
SELECT
    booking_id,
    property_id,
    user_id,
    start_date,
    end_date,
    status
FROM Booking
WHERE start_date >= '2025-01-01';

-- Analyze the query plan for the partitioned table
EXPLAIN ANALYZE
SELECT
    booking_id,
    property_id,
    user_id,
    start_date,
    end_date,
    status
FROM Booking_partitioned
WHERE start_date >= '2025-01-01';
