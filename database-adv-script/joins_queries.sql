SELECT User.user_id AS user_id,
    first_name,
    last_name,
    booking_id,
    status,
    Booking.created_at AS created_at
FROM Booking
INNER JOIN User
ON Booking.user_id = User.user_id;

SELECT Property.property_id,
    name,
    description,
    user_id,
    rating,
    comment
FROM Property
LEFT JOIN Review
ON Property.property_id = Review.property_id;

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
LEFT JOIN User ON Booking.user_id = User.user_id;
