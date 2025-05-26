-- Retrieves all bookings along with the user details, property details, and payment details.
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
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id;
