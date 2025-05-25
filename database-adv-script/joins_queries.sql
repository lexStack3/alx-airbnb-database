SELECT User.user_id AS user_id,
    first_name,
    last_name,
    booking_id,
    start_date,
    end_date,
    total_price,
    status,
    Booking.created_at AS created_at
FROM User
INNER JOIN Booking
ON User.user_id = Booking.user_id;

SELECT Property.property_id AS property_id,
    Property.name AS property_name,
    Property.location,
    Review.review_id,
    Review.rating,
    Review.comment,
    Review.created_at
FROM Property
LEFT JOIN Review
ON Property.property_id = Review.property_id
ORDER BY Property.name ASC;

SELECT
    User.user_id AS user_id,
    first_name,
    last_name,
    booking_id,
    start_date,
    end_date,
    total_price,
    status,
    Booking.created_at AS created_at
FROM User
LEFT JOIN Booking ON User.user_id = Booking.user_id

UNION

SELECT
    User.user_id AS user_id,
    NULL AS first_name,
    NULL AS last_name,
    booking_id,
    start_date,
    end_date,
    total_price,
    status,
    Booking.created_at AS created_at
FROM Booking
LEFT JOIN User ON Booking.user_id = User.user_id

ORDER BY first_name ASC;
