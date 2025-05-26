-- Before Indexing
EXPLAIN ANALYZE SELECT
    property_id,
    name AS property_name
FROM Property
WHERE (
    SELECT AVG(rating)
    FROM Review
    WHERE Review.property_id = Review.property_id
) > 4.0;

EXPLAIN ANALYZE SELECT
    user_id,
    first_name,
    last_name
FROM User
WHERE (
    SELECT COUNT(*)
    FROM Booking
    WHERE Booking.user_id = User.user_id
) > 3;

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

-- After Indexing
EXPLAIN ANALYZE SELECT
    property_id,
    name AS property_name
FROM Property
WHERE (
    SELECT AVG(rating)
    FROM Review
    WHERE Review.property_id = Review.property_id
) > 4.0;

EXPLAIN ANALYZE SELECT
    user_id,
    first_name,
    last_name
FROM User
WHERE (
    SELECT COUNT(*)
    FROM Booking
    WHERE Booking.user_id = User.user_id
) > 3;
