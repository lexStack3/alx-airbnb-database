SELECT
    property_id,
    name AS property_name
FROM Property
WHERE (
    SELECT AVG(rating)
    FROM Review
    WHERE Review.property_id = Review.property_id
) > 4.0;

SELECT
    user_id,
    first_name,
    last_name
FROM User
WHERE (
    SELECT COUNT(*)
    FROM Booking
    WHERE Booking.user_id = User.user_id
) > 3;
