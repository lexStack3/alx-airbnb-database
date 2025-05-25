SELECT
    Property.property_id AS property_id,
    Property.name AS property_name,
    Review.rating AS rating,
    Review.comment AS comment
FROM Property
INNER JOIN Review
ON Property.property_id = Review.property_id
WHERE Review.rating >= 4;

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
